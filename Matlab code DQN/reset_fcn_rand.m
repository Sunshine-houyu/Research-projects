function [InitialObservation, LoggedSignal] = reset_fcn_rand()
% Reset function to place the environment into a random initial state.

% Return initial environment state variables as logged signals.
% |h_kk|^2 and c_l are initialized to a random state
L = 5;
h_levels = [0, 1e-6, 0.3:0.3:2.4];
num_levels = length(h_levels);

LoggedSignal.State = zeros(L*L+L,1);
for comp = 1:L
    LoggedSignal.State((comp-1)*L+comp) = h_levels(randi(num_levels));
end

% reward is always r1=log2(1+SNR) for now
for comp = L*L+1:L*L+L
    LoggedSignal.State(comp) = randi(2)-1;
    %LoggedSignal.State(comp) = 1;
end

InitialObservation = LoggedSignal.State;

end