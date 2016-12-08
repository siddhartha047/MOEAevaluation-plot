function bounds=getbounds(problemtype,problemno,dim)
    bounds=zeros(1,dim);
    
    start=2;
    
    if problemtype=='wfg'
        for i=1:dim
            bounds(1,i)=start;
            start=start+2;
        end
    end
    
end