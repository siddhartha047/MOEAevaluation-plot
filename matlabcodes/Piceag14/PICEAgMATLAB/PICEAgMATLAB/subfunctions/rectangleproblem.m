function F = rectangleproblem( x, M )

[noSols, n] = size(x);
   
 F=zeros(noSols, 4);
 
    for i=1:noSols

         F(i,1)=abs(x(i,1)-0);
         F(i,2)=abs(x(i,1)-100);
         F(i,3)=abs(x(i,2)-0);
         F(i,4)=abs(x(i,2)-100);

    end
end

