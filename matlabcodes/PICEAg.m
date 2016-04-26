% PICEA-g MATLAB code for TEC paper
% The University of Sheffield
% Created by Rui on 02/10/2011
%
% Feel free to contact me if you have any problem on this algorithm
% Rui Wang,   Email: ruiwangnudt@gmail.com
%

%**************************************************************************
% Main Idea:
% PICEA-g is developed to solve many-objective problems. It co-evolves
% candidate solutions with goal vectors during the seach progress. Candiate
% solutions are guided twoards the Pareto optimal front by goal vectors.
% Goal vectors gain fitness by offering comparablity to the candidate
% solutions
%**************************************************************************
% Reference: 
% R. Wang, R. Purshouse, and P. Fleming, Preference-inspired
% coevolutionary algorithms for many-objective optimisation, IEEE Trans.
% Evol. Comput., 2013. In press.

%**************************************************************************
% <1> Note that in this version, the goalbounds are pre-defined within the 
%     bounds determinted by the ideal and 1.2*nadir point. The goal vector 
%     bounds can also be obtained by an online estimation of the ideal and
%     nadir point.  
%     goalUpper = 1.2*max(jointF,[],1);
%     goalLower = min([jointF;goalLower],[],1);
%     ideally, goalLower should be the ideal point
% <2> In this version the Pareto dominance check specifed in the paper is
%     not included. As the effect of Pareto dominance check is not significant
%     for many-objective problems

%**************************************************************************

% ************************************************
% objvNo:  number of objectives
% testNo: test problem
% N: population size
% Ngoal : the no. of goal vectors
%
% This code demonstrates the performance of PICEA-g on 2-objective WFG4
% problem
% ************************************************


dirName='gen\';

%dimNNNN=[2 4 7 10];
dimNNNN=[5,7,10,13,19];

seed=[0.05, 0.10, 0.15, 0.20, 0.25, 0.30, 0.35, 0.40, 0.45,0.50, 0.55, 0.60, 0.65, 0.70, 0.75, 0.80, 0.85 ,0.9,0.95,1]

%for seedNo=[0.1:0.05:0.9]

for seedNo=seed

for dimno=dimNNNN

for sidTestNo=(2:9)

testNo = sidTestNo; objvNo = dimno; N = 200; Ngoal = dimno*100; maxGen = 200;

mkdir(dirName,num2str(seedNo));
filedirectory=strcat(dirName,num2str(seedNo),'\');
filename = strcat(filedirectory,'pwfg', num2str(testNo), '_',num2str(objvNo),'.pf')

%{
%% setup figure
warning all off
hf = figure;
set(hf,'Units','pixels');
figuresize=get(hf,'Position');
screensize=get(0,'screensize');
set(gcf,'outerposition',[(screensize(3)-figuresize(3))/3,...
    (screensize(4)-figuresize(4))/3,1.5*figuresize(3),1.5*figuresize(4)]);

%}
%% parameter settings
k = 36;  l = 18; %WFG problem parameters
nVar = k + l; %number of decision variables
bounds=[zeros(1, nVar); 2*(1:nVar)]; %bounds for decision varialbes

%% initialise offline archive
bestobjv = Inf*ones(1,objvNo);
bestphen = NaN*ones(1,nVar);

% generate initial candidate solutions, compute objective values
P = crtrp(N,bounds);
F_P = wfg(P, objvNo, k, l, testNo);
% generate goal vectors within goal vector bounds
goalUpper = 1.2*max(F_P,[],1);
goalLower = min(F_P,[],1); 
Goal = initGoals(Ngoal,objvNo,goalUpper,goalLower); 

for gen = 1:maxGen
    % obtain new solutions by crossover and mutation
    numn = size(P,1); rx = randperm(numn);
    C = P(rx,:);
    C= sbx_sal(C, bounds, 15, 0, 1, 1,0.5);
    C = polymut_sal(C, bounds, 20, 1/nVar);
    F_C = wfg(C, objvNo, k, l, testNo);
    % combine the parents and offspring for S and F_S
    jointP = [P;C]; jointF = [F_P;F_C];
    
    % Update the goal vector bounds
    goalUpper = 1.2*max(jointF,[],1);
    goalLower = min([jointF;goalLower],[],1);

    % generate new goal vectors within goal vector bounds
    GoalC = initGoals(Ngoal,objvNo,goalUpper,goalLower); 
    %  combine the parents and offspring for G
    jointG = [Goal; GoalC];
    
    % fitness assignment <the core part of the PICEA-g>
    result = fitness_PICEAg(jointF,jointP,jointG,objvNo);
    
    scoreS = result{1};  scoreG = result{2};
    %% select best N candidate solutions and Ngoal goal vectors
    ixS = trunc_No(scoreS,N);
    P = jointP(ixS,:);
    F_P = jointF(ixS,:);
    ix = trunc_No(scoreG,Ngoal);
    Goal = jointG(ix,:);

    
    %% obtain non-dominated solutions
    nonDomix = find_nd(F_P);
    Hobjv =  F_P(logical(nonDomix),:);

    %% Offline archive
    [ix,bestix] = find_nd(F_P,bestobjv);
    bestobjv = [bestobjv(logical(bestix),:) ; F_P(logical(ix),:)];
    bestphen = [bestphen(logical(bestix),:) ; P(logical(ix),:)];
    % if more than N solutions are in the archive, use SPEA clustering
    % method to obtain a set of well distributed solutions
    if size(bestobjv,1)>N
        [bestobjv,index] = reducer(bestobjv, objvNo, N);
        bestphen = bestphen(index,:);
    end
    
    %% Plot the results
    CurrentPF=bestobjv;
    CurrentPS=bestphen;
    Fbound = 2.4*(1:objvNo);
    if gen == maxGen
        fid = fopen(filename,'w');
        dlmwrite(filename,CurrentPF,'-append','delimiter','\t','newline','pc');
        fclose(fid);
       
    end
    
    
    
    %gen
    
   %% plot(CurrentPF(:,1),CurrentPF(:,2),'b*',Goal(:,1),Goal(:,2),'ro'),  axis([0 Fbound(1) 0 Fbound(2)]);
  %%  legend('Candidates','Goal vectors')
  %%  title({['TestNo: ',num2str(testNo)],['Generation: ',num2str(gen)]})
  %%  drawnow
end

end

end

end

