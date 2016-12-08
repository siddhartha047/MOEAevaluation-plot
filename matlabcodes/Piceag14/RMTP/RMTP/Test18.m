%pelle

function f=MTP14(x)
    f(:,1)=(exp(x(1))-1)/(exp(1)-1);;
    if x(1)<=0.2 && x(1)>=0
        f(:,2)=g(x)-0.1*x(1);
    end
    
    if x(1)<=0.4 && x(1)>0.2
        f(:,2)=g(x)-0.25*x(1);
    end
    
    if x(1)<=0.6 && x(1)>=0.4
        f(:,2)=g(x)-0.5*x(1);
    end  
    
    if x(1)<=0.8 && x(1)>0.6
        f(:,2)=g(x)-0.75*x(1);
    end  
    
    if x(1)<=1 && x(1)>0.8
        f(:,2)=g(x)-1*x(1);
    end      
    
  
end


function o=g(x)
    [m n]=size(x);
    o=1+10*sum(x(2:n))/n;
end

