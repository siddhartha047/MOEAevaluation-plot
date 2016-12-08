%Andrew's robust benchmark problem-multi-objective version

function f=MTP20(x)


f(:,1)=x(1);
    f(:,2)=h(x(2))*(g(x)+S(x(1)))+1.5;
    
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

function o=S(x1)
    o=-sqrt(x1);
end
