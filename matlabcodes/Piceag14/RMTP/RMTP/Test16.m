% This function is similar to ZDT3
%n=5 is the default

function f=MTP31(x)
    
n=5;
    
    f(:,1)=x(1);
    f(:,2)=x(2);
%     f(:,2)=g(x)*((exp(-x(1))*cos((n*2*pi*x(1))))-x(1))/3+1.5;
  f(:,3)=g(x)*(((1-sqrt(x(1)/g(x))-((x(1)/g(x))*sin(n*2*pi*x(1))))+h(x(1)))+((1-sqrt(x(2)/g(x))-((x(2)/g(x))*sin(n*2*pi*x(2))))+h(x(2))));

end

function o=h(x2)
n=4;  
    o=((exp(-2*x2)*sin(((((n*2))*pi)*(x2+pi/(4*n)))))-(x2))/3+0.5;
    
    %2-(0.8*exp(-((x2-0.35)/0.25)^2))-exp(-((x2-0.85)/0.03)^2);
end


function o=g(x)
    [m n]=size(x);
    o=1+10*sum(x(3:n))/n;
end

