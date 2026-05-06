function [NextObs,Reward,IsDone,LoggedSignals] = step_fcn_rand_2(Action,LoggedSignals,envConstants)
% Custom step function to construct the environment for the function
% name case.
%
% This function applies the given action to the environment and evaluates
% the system dynamics for one simulation step.

%% Check if the requested action is valid.
if ~ismember(Action,[1:envConstants.ActSpcSize])
    error('Action not included in supported actions list');
end

%% Unpack the state vector from the logged signals to update the state.
% Separating IA-procced channels and cache states
h_states = LoggedSignals.State(1:envConstants.num_mimo_ch);
cache_states = LoggedSignals.State(envConstants.num_mimo_ch+1 :...
                                  envConstants.num_mimo_ch+envConstants.L);

% Updating the channels states.
for comp = 1:envConstants.L
    LoggedSignals.State((comp-1)*envConstants.L+comp) = ...
                              envConstants.h_levels(randi(envConstants.H));
end

% Updating the cache states according to P_cache
% Again, this is based on the interpretation of P_cache. If it changes, the
% code will need to be updated to reflect the change.
for comp = 1:envConstants.L
    rand_prob = rand;
    if(cache_states(comp)==1)
        if(rand_prob > envConstants.P_cache(1,1))
            LoggedSignals.State(envConstants.num_mimo_ch+comp) = 0;
        end
    else
        if(rand_prob > envConstants.P_cache(2,1))
            LoggedSignals.State(envConstants.num_mimo_ch+comp) = 1;
        end
    end
end

% Transform state to observation.
NextObs = LoggedSignals.State;

%% Check terminal condition (we don't have a terminal state!).
IsDone = 0;

%% Get reward for the action taken.
% determining which action is requested (which UEs are to be selected)
requested_act = envConstants.Act_list(Action,:);

% Imedidate reward of the requested action (i.e. sum r_n(t) for n=1:L).
Reward = 0;
for c = 1:envConstants.L
    if(requested_act(c)==1) % reward computed only for active UEs
        Tx_UEs = requested_act; % for intereference calc.
        Tx_UEs(c) = 0; % no interference from any UE on itself.
        SINR = h_states((c-1)*envConstants.L+c)/...
               (Tx_UEs*h_states(c*envConstants.L-(envConstants.L-1) :...
                c*envConstants.L) + (envConstants.sigma_2/envConstants.P));
        r1 = log2(1+SINR);
        if (cache_states(c)==0)
            r2 = (envConstants.C_tot - envConstants.Cc*...
                                    sum(requested_act))/sum(requested_act);
            r2 = r2/1e6;
            Reward = Reward + min(r1,r2);
        else
            Reward = Reward + r1;
        end
    end
end

end