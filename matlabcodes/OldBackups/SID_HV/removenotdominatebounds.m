function NP1=removenotdominatebounds(P1, bounds)
    
fN=true(size(P1,1),1);

    for c1=1:size(P1,1)
                    
        f=all(bsxfun(@le, P1(c1,:),bounds),2);        
            
        if f==1 
            fN(c1)=1;
        else 
            fN(c1)=0;
        end
        
        
    end    
       
    NP1=P1(fN,:);


end