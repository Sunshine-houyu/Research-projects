% Number of candidates.
L = 5;
% Number of levels for each RV (number of cols of P_channel).
H = 10;
ObsSpcDim = L*L + L;
% Number of permissible actions (at least 3 candidate UEs must be active).
ActSpcSize = (2^L)-nchoosek(L,0)-nchoosek(L,1)-nchoosek(L,2);

obsInfo = rlNumericSpec([ObsSpcDim 1]);
obsInfo.Name = 'System States';
obsInfo.Description = ['|h_kj|^2 for k,j=1:L, followed by c_l for l=1:L'];

actInfo = rlFiniteSetSpec(1:ActSpcSize);
actInfo.Name = 'UE Selection';

net = [imageInputLayer([ObsSpcDim 1 1], 'Normalization','none','Name','sysState') 
       convolution2dLayer([5 1],100,'Stride',[1 1])
       %fullyConnectedLayer(40)
       reluLayer
       %tanhLayer
       convolution2dLayer([4 1],95,'Stride',[1 1])
       %fullyConnectedLayer(35)
       reluLayer
       %tanhLayer
       convolution2dLayer([3 1],90,'Stride',[1 1])
       %fullyConnectedLayer(30)
       reluLayer
       %tanhLayer
       convolution2dLayer([2 1],85,'Stride',[1 1])
       reluLayer
       %tanhLayer
       %fullyConnectedLayer(25)
       %reluLayer
       %tanhLayer
       fullyConnectedLayer(ActSpcSize,'Name','qValue')];

criticOpts = rlRepresentationOptions('LearnRate',0.001);
%criticOpts = rlRepresentationOptions('LearnRate',0.001,'UseDevice',"gpu");

critic = rlQValueRepresentation(net,obsInfo,actInfo,'Observation',{'sysState'},...
                                criticOpts);

%v = getValue(critic,{rand(ObsSpcDim,1)})

% You can now use the critic (along with an actor) to create a discrete 
% action space agent relying on a Q-value function critic (such as an 
% rlQAgent, rlDQNAgent, or rlSARSAAgent agent).


%% The following command opens a live script containing Ex2 below in R2020a
% openExample('rl/CreateADQNAgentExample')
%% Ex2
% Specify agent options, and create a DQN agent using the specified options 
% and critic.

agentOpts = rlDQNAgentOptions(...
    'UseDoubleDQN',true, ...    
    'TargetUpdateMethod','periodic-smoothing', ...
    'TargetUpdateFrequency',4, ...
    'TargetSmoothFactor',0.001, ...
    'ExperienceBufferLength',50000, ...
    'DiscountFactor',0.001, ...
    'MiniBatchSize',8);

% You can also set some options in this way.
agentOpts.EpsilonGreedyExploration.Epsilon = 1; % default is 1
agentOpts.EpsilonGreedyExploration.EpsilonMin = 0.1; % default is 0.01
agentOpts.EpsilonGreedyExploration.EpsilonDecay = 1-0.1^(1e-4); % default is 0.005

agent = rlDQNAgent(critic,agentOpts);

% To check your agent, use getAction to return the action from a random 
% observation.

%getAction(agent,{rand(ObsSpcDim,1)})


%% The following command opens a live script containing Ex3 below in R2020a
% openExample('rl/MATLABCartPoleDQNExample')
%% Ex3
% Training the agent on an environment (you need to create your env.
% manually!).

% To train the agent, first specify the training options. It will be
% something like.

trainOpts = rlTrainingOptions(...
    'MaxEpisodes', 1e3, ...
    'MaxStepsPerEpisode', 5e2, ...
    'Verbose', false, ...
    'Plots','training-progress',...
    'StopTrainingCriteria',"GlobalStepCount",...
    'StopTrainingValue',5e5);


% load your environment.
% The following links to Matlab online help discuss custom-made
% enviroments!
% https://www.mathworks.com/help/reinforcement-learning/ug/create-matlab-environments-for-reinforcement-learning.html
% https://www.mathworks.com/help/reinforcement-learning/ug/create-custom-matlab-environment-from-template.html
% https://www.mathworks.com/help/reinforcement-learning/ref/rlcreateenvtemplate.html
% https://www.mathworks.com/help/reinforcement-learning/ref/rl.env.rlfunctionenv.html

%% Define the environment constants.
envConstants.L = L;
envConstants.H = H;
envConstants.ActSpcSize = ActSpcSize;
% Noise power
envConstants.sigma_2 = 1e-4; % watts
% Tx Power of each candidate (set so that the SNR at each candidate is 30dB)
envConstants.P = 1e-1; % watts
% Total backhaul capacity
envConstants.C_tot = 60; % Mbps
% CSI share capacity per UE
envConstants.Cc = 2; % Mbps
% Number of IA-procced channels (No. of MIMO channels linking all candidates)
envConstants.num_mimo_ch = L*L;
% Possible levels for any |h_kk|^2
envConstants.h_levels = [0, 1e-6, 0.3:0.3:2.4];
% Cache states transitions for any c_l, l=1:L.
envConstants.P_cache =...
[0.6 0.4; % p(c_l(t+1)=1|c_l(t)=1)=0.6, p(c_l(t+1)=0|c_l(t)=1)=0.4
 0.4 0.6]; % p(c_l(t+1)=0|c_l(t)=0)=0.4, p(c_l(t+1)=1|c_l(t)=0)=0.6
% Compiling a list of all legal actions.
envConstants.Act_list = zeros(ActSpcSize,L);
for a=1:2^L
    act = dec2binvec(a-1,L);
    %act = decimalToBinaryVector(a-1,L,'LSBFirst');
    % add only if legal action (i.e. if 3 or more UEs are selected).
    if (sum(act) >= 3)
        envConstants.Act_list(a,:) = act;
    end
end
% Removing all all-zero rows remaining in the list (these correspond to
% illegal actions that were skipped).
envConstants.Act_list = envConstants.Act_list(...
                                        sum(envConstants.Act_list,2)~=0,:);

% Create an anonymous function handle to the custom step function, passing 
% envConstants as an additional input argument. Because envConstants is 
% available at the time that StepHandle is created, the function handle 
% includes those values. The values persist within the function handle 
% even if you clear the variables.
StepHandle = @(Action,LoggedSignals) step_fcn_rand_2(Action,LoggedSignals,...
                                                             envConstants);

% Use the same reset function, specifying it as a function handle rather 
% than by using its name.
ResetHandle = @reset_fcn_rand;

% Create the environment using the custom function handles.
env = rlFunctionEnv(obsInfo,actInfo,StepHandle,ResetHandle);
%env = rlFunctionEnv(obsInfo,actInfo,'step_fcn','reset_fcn');
%env = rlFunctionEnv(obsInfo,actInfo,'step_fcn_rand','reset_fcn_rand');

% Train the agent.
trainingStats = train(agent,env,trainOpts);

% After training is finished, you can save the agent in a folder
% "savedAgent" that you create in the working directory. for more on this
% you can refer to the link:
% https://www.mathworks.com/help/reinforcement-learning/ug/train-reinforcement-learning-agents.html#:~:text=By%20default%2C%20calling%20the%20train,average%20reward%20value%20(AverageReward).
%save(trainOpts.SaveAgentDirectory + "/finalAgent.mat",'agent');

% If the agent is well-trained, you can use it to get the action that
% should be taken for a given state
%actn = getAction(agent,state);
