function data=make_array_fix_length(data,desiredLength)
    %data =1:1:16;    
    %desiredLength=20;
    [dm,dn]=size(data);
    meanValue=mean(data);
    
    for i=dn+1:desiredLength
        data(1,i)=meanValue;
    end
    
end