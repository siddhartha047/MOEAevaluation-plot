%Andrew's robust benchmark problem-multi-objective version

function f=MTP23(x)


f(:,1)=x(1);
if x(2)<0.8
    f(:,2)=h(x(2))*(g(x)+S1(x(1)))+1.5;
end
if x(2)>=0.8
    f(:,2)=h(x(2))*(g(x)+S2(x(1)))+1.5;
end
    
end

function o=h(x2)
alpha=0.1;
    o=+(1/((2*pi)^0.5))*exp(-0.5*((x2-1.5)/0.5).^2)+(2/((2*pi)^0.5))*exp(-0.5*((x2-0.5)/alpha).^2);
    
    %2-(0.8*exp(-((x2-0.35)/0.25)^2))-exp(-((x2-0.85)/0.03)^2);
end

function o=g(x)
    [m n]=size(x);
    o=sum(50.*x(3:n).^2);
end

function o=S1(x1)
    o=-x1;
    
end

function o=S2(x1)
    o=-x1^1.5;
end