%3 objectives of MTP10
function f=Test1(x)
    f(:,1)=x(1);
    f(:,2)=x(2);
    f(:,3)=g(x)*((sin((4*pi*x(1)))-15*x(1))/15+1)*((sin((4*pi*x(2)))-15*x(2))/15+1);
end


function o=g(x)
    [m n]=size(x);
    o=1+10*sum(x(3:n))/n;
end

