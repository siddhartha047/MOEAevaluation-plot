function bounds=getDTLZbounds(problemno,dim)
    bounds=zeros(1,dim);
   
    if problemno==1
        for i=1:dim
            bounds(1,i)=0.5;
        end
        
    else 
        for i=1:dim
            bounds(1,i)=1;
        end    
    end
    
    
end