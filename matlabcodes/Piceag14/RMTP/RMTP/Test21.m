%3 objectives of MTP11
function f=MTP12(x)
    f(:,1)=(exp(x(1))-1)/(exp(1)-1);
    f(:,2)=(exp(x(2))-1)/(exp(1)-1);
    f(:,3)=g(x)*((sin((4*pi*x(1)))-15*x(1))/15+1)*((sin((4*pi*x(2)))-15*x(2))/15+1);
end


function o=g(x)
    [m n]=size(x);
    o=1+10*sum(x(3:n))/n;
end

