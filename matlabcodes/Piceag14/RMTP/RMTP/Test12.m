% This function has (n-1) number of local Pareto fronts 1 global and 1
% robust front

function f=MTP30(x)

f(:,1)=x(1);
    f(:,2)=h(x(2))*(g(x)+S(x(1)))+1;
    
end

function o=h(x2)
n=4;  
    o=((exp(-x2)*cos((n*2*pi*x2)))-x2)/3+0.5;
    
    %2-(0.8*exp(-((x2-0.35)/0.25)^2))-exp(-((x2-0.85)/0.03)^2);
end

function o=g(x)
    [m n]=size(x);
    o=sum(50.*x(3:n).^2);
end

function o=S(x1)
    o=-x1^1.5;;
end
