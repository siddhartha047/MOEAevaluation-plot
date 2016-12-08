%% PICEA-g MATLAB code
%**************************************************************************
% Main Idea:
% PICEA-g is developed to solve multi/many-objective problems. It co-evolves
% candidate solutions with a set of goal vectors during the seach progress. 
% Candiate solutions are guided twoards the Pareto optimal front by goal vectors.
% Goal vectors gain fitness by offering comparablity to the candidate solutions

% The PICEA-g employs the "mu+lamada" elitist framework, that is, select
% the best N solutions from a union of parent (N) and offspring (N) 
% population
%**************************************************************************
% Reference: 
% R. Wang, R. Purshouse, and P. Fleming, Preference-inspired
% coevolutionary algorithms for many-objective optimisation, IEEE Trans.
% Evol. Comput., 2013. In press.
%**************************************************************************
%
% <1> Note that in this version, goal vector bounds are set as follows  
%     alpha = 1.2; % suggested to be set within (1,2)
%     goalUpper = scalingfactor*ones(1,objvNo); 
%     goalLower = zeros(1,objvNo);
%     Goal = initGoals(Ngoal,goalUpper,goalLower); 
     
% <2> As the effect of Pareto dominance check is not significant
%     for many-objective problems, the Pareto dominance check specifed 
%     in the paper is not applied here. Also the fitness assignment used in
%     PICEA-g is weak Pareto dominace complied.

% <3> Note that this code demonstrates the performance of PICEA-g on 
%     2-objective WFG4 problem
%**************************************************************************

% Author:     Rui Wang     The University of Sheffield, UK & 
%                          National University of Defense Technology, P.R.China 
% History:    02.OCT.2011  file created
%             04.SEP.2015  clean up
  
% Feel free to contact me if you have any questions on this algorithm
% Dr. Rui Wang,   Email: ruiwangnudt@gmail.com
% Copyright reserved by the authors


dirName='D:\FDEA2016\Codes\abcgenerations\recompileWFG-DTLZ\perfectPICEAGdtlz\';
seedS=[0.05, 0.10, 0.15, 0.20, 0.25, 0.30, 0.35, 0.40, 0.45,0.50, 0.55, 0.60, 0.65, 0.70, 0.75, 0.80, 0.85 ,0.9,0.95,1];
%seedS=[0.05];
dimNNNN=[2, 3, 5, 7, 10, 12, 15, 20, 25];
populationSize=[204 ,204, 212, 212, 220, 160, 240, 212, 328];
[dimr dimc]=size(dimNNNN);

for seedNo=seedS

for iter=9:9
    for testNo=[1 2 3 4 7]

%% ************************************************
% The number of objectives
objvNo = dimNNNN(iter);
%objvNo=2;
% testNo: test problem
%testNo = 1;  

% The population size of candidate solutions and goal vectors
%N = 204; 
N = populationSize(iter); 

Ngoal = objvNo*100; 
% The maximum number of generations
maxGen = 250;

N
Ngoal
objvNo
testNo

mkdir(dirName,num2str(seedNo));
filedirectory=strcat(dirName,num2str(seedNo),'\');
filename = strcat(filedirectory,'pDTLZ', num2str(testNo), '_',num2str(objvNo),'.pf')

%% create figure
%hf = figure;
%% parameters for decision variables. 
% ******** Note that this might need to changed to follow your own problem ****** %
% i) WFG test problem setting
% k = 4;  l = 4; % the wfg problem parameters
% nVar = k + l;  % number of decision variables
% bounds=[zeros(1, nVar); 2*(1:nVar)];  % bounds of decision varialbes

% ii) DTLZ test problem setting

%nVar = 10;  % number of decision variables

dim=objvNo;
nVar=dim+9;
number_of_decvars=nVar;
problemNo=testNo;	        

if problemNo==1 
    number_of_decvars=dim+4;
elseif problemNo==2 ||problemNo==3 || problemNo==4 || problemNo==5 || problemNo==6
    number_of_decvars=dim+9;
elseif problemNo==7 
    number_of_decvars=dim+19;
else
    error('invalid problem');
end
    
nVar=number_of_decvars;


k = nVar-objvNo+1; % DTLZ problem parameter
bounds=[zeros(1, nVar); ones(1,nVar)];  % bounds of decision varialbes

%% initialise offline archive
% To store the best so far Pareto optimal front
bestobjv = Inf*ones(1,objvNo);
% To store the best so far Pareto optimal set 
bestphen = NaN*ones(1,nVar);

%% initialize candidate solutions
P = crtrp(N,bounds);

%% compute objective values of P
% ******** Note that you can replace "wfg" with your own objective functions *******%
%F_P = wfgextend(P, objvNo, k, l, testNo); 
disp('sending');
objvNo
k
testNo
F_P = dtlz(P, objvNo,k,testNo);

%% generate goal vectors within goal vector bounds
alpha = 1.2; % suggested to be set within (1,2)
goalUpper = alpha*ones(1,objvNo); 
goalLower = zeros(1,objvNo);
Goal = initGoals(Ngoal,goalUpper,goalLower); 
%% Evolution process
for gen = 1:maxGen
   %% obtain new solutions by crossover and mutation
    % shuffle candidate solutions first
    numn = size(P,1);  rx = randperm(numn); C = P(rx,:);
    % apply crrossover (SBX) and mutation (PM) operators to generate new offspring 
    % Note that SBX and PM is only for real-number optimization.  You might need to 
    % design your own crossover and mutation operators
    C= sbx_sal(C, bounds, 15, 0, 1, 1,0.5);
    C = polymut_sal(C, bounds, 20, 1/nVar);
    
    %% Compute objective values for the new offspring 
    % For your problem you should also replace "wfg" with your own objective functions 
    %F_C = wfgextend(C, objvNo, k, l, testNo);
    F_C = dtlz(C, objvNo,k,testNo);
    
    %% combine the parent and offspring population for candidate solutions
    jointP = [P;C]; jointF = [F_P;F_C];
    
    %% normalize objective values within [0,1]
    % find the non-dominated ones only, and normalise using this
    % floor(jointF.*100)/100 is to ingore the small difference such as 
    % 1.11113 and 1.111,
    nonDomjointFix = find_nd(floor(jointF.*100)/100);
    %nonDomjointFix = find_nd(jointF);
    nonjointF =  jointF(logical(nonDomjointFix),:);
    jointFnum = size(jointF,1);
    normjointF = (jointF- rep(min(nonjointF,[],1),[jointFnum,1]))./rep((max(nonjointF,[],1) - min(nonjointF,[],1)),[jointFnum,1]);
    
    %% generate new goal vectors
    GoalC = initGoals(Ngoal,goalUpper,goalLower); 
       %%  combine the parent and offspring population for goal vectors
    jointG = [Goal; GoalC];
    
    %% fitness assignment <the core part of the PICEA-g>
    result = fitness_PICEAg(normjointF,jointP,jointG,objvNo);
    scoreS = result{1};  scoreG = result{2};
    
    %% select the best N candidate solutions and Ngoal goal vectors
    ixS = trunc_No(scoreS,N);
    P = jointP(ixS,:);
    F_P = jointF(ixS,:);
    ix = trunc_No(scoreG,Ngoal);
    Goal = jointG(ix,:);
  
    %% Offline archive
    % store all non-dominated solutions found so far
    [ix,bestix] = find_nd(F_P,bestobjv);
    bestobjv = [bestobjv(logical(bestix),:) ; F_P(logical(ix),:)];
    bestphen = [bestphen(logical(bestix),:) ; P(logical(ix),:)];
    % if more than N solutions are in the archive, use the SPEA clustering
    % method to obtain a set of well distributed solutions
    if size(bestobjv,1)>N
        [bestobjv,index] = reducer(bestobjv, objvNo, N);
        bestphen = bestphen(index,:);
    end
    
    
    
    %% Plot the results
    CurrentPF=bestobjv;
    CurrentPS=bestphen;
    %{
    %plot(CurrentPF(:,1),CurrentPF(:,2),'b*',Goal(:,1),Goal(:,2),'ro'); legend('Pareto optimal front','Goal vectors')
    plot(CurrentPF(:,1),CurrentPF(:,2),'b*');
    title({['TestNo: ',num2str(testNo)],['Generation: ',num2str(gen)]})
    drawnow
    %}
    
    if gen == maxGen
        fid = fopen(filename,'w');
        dlmwrite(filename,CurrentPF,'-append','delimiter','\t','newline','pc');
        fclose(fid);       
    end
end
end
end
end


