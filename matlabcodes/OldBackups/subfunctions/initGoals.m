% Generate goal vectors 
% input: Ngoal: the no. of goal vectors
%       objvNo: the no. of objectives
%       fEasy: upper goal vector
%       fHard: upper goal vector
% output: goals: generated goal vectors

function goals = initGoals(Ngoal,objvNo,fEasy,fHard);

goals = NaN*ones(Ngoal,objvNo);
goals = rep(fEasy,[Ngoal,1])-rand(Ngoal, objvNo) .* rep((fEasy-fHard),[Ngoal,1]);

end
