function r=add_rank_to_result()
    
    resultfile='E:\Thesis lab experiment documents\abcgenerations\perfectWFG-DTLZ\dtlzresult.txt';
    rankfile='E:\Thesis lab experiment documents\abcgenerations\perfectWFG-DTLZ\dtlzrank.txt';
    writefile='E:\Thesis lab experiment documents\abcgenerations\perfectWFG-DTLZ\dtlzmerged.txt';
    
    fidresult= fopen(resultfile);
    fidrank=fopen(rankfile);
    fidwrite=fopen(writefile,'w+');
    
    
    
    while ~feof(fidresult)
    
        resultline = fgetl(fidresult);
        rankline = fgetl(fidrank);    
        
        result=strsplit(resultline);        
        rank=strsplit(rankline);        
                
        for i=1:7
            merged(1,i)=strcat(result(1,i),'(',rank(1,i),')');
        end
        
        merged
        
        for l=1:7              
            fprintf(fidwrite,'%s\t',cell2mat(merged(1,l)));            
        end        
        fprintf(fidwrite,'\n');
            
    end
    
    
  
    fclose('all');
    
end

