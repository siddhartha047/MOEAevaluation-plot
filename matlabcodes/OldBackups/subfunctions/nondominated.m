function [P1] = nondominated(P1)
    
    fN=true(size(P1,1),1);

    for c1=1:size(P1,1)
    
        for c2=1:size(P1,1)
            
            %disp(strcat('[',num2str(c1),',',num2str(c2),']'));
            
            if c1==c2          
                continue;                
            end
      
            f=all(bsxfun(@ge, P1(c1,:), P1(c2,:)),2);        
            
            if f==1 
                fN(c1)=0;
                break;
            end
        end               
    end    
   
    
    P1=P1(fN,:);

    %{

    fN=true(size(P1,1),1);
    
    for c1=1:size(P1,1)
    
        f=all(bsxfun(@ge, P1(c1,:), P1),2);        
    
        f(c1)=0;
        f=any(f,1);
        f=~f;   %0 for those which satisfy this condition
        fN(c1)=f;
    end    

    P1=P1(fN,:);
    %}
    
end