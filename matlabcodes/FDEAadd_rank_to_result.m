function r=FDEAadd_rank_to_result()
    
  
    resultfile='D:\FDEA2016\Codes\abcgenerations\recompileWFG-DTLZ\WFGhypervolume.txt';
    rankfile='D:\FDEA2016\Codes\abcgenerations\recompileWFG-DTLZ\Sswfgranktest.txt';
    writefile='D:\FDEA2016\Codes\abcgenerations\recompileWFG-DTLZ\SswfgMerged.txt';
  %}
    %{
    resultfile='D:\FDEA2016\Codes\abcgenerations\igdEvaluationDTLZ\DTLZhypervolume.txt';
    rankfile='D:\FDEA2016\Codes\abcgenerations\igdEvaluationDTLZ\Ssdtlzranktest.txt';
    writefile='D:\FDEA2016\Codes\abcgenerations\igdEvaluationDTLZ\SsdtlzMerged.txt';
    %}
%{
    resultfile='D:\FDEA2016\Codes\abcgenerations\igdEvaluationDTLZ\DTLZigd.txt';
    rankfile='D:\FDEA2016\Codes\abcgenerations\igdEvaluationDTLZ\IGDdtlzranktest.txt';
    writefile='D:\FDEA2016\Codes\abcgenerations\igdEvaluationDTLZ\IGDdtlzMerged.txt';    
%}

    %{
    resultfile='D:\FDEA2016\Codes\abcgenerations\recompileWFG-DTLZ\FDEA\FDEAdtlzcomparison\Ssdtlz.txt';
    rankfile='D:\FDEA2016\Codes\abcgenerations\recompileWFG-DTLZ\FDEA\FDEAdtlzcomparison\Ssdtlzranktest.txt';
    writefile='D:\FDEA2016\Codes\abcgenerations\recompileWFG-DTLZ\FDEA\FDEAdtlzcomparison\SsdtlzMerged.txt';    
    %}
    
    %{
    resultfile='D:\FDEA2016\Codes\abcgenerations\recompileWFG-DTLZ\FDEA\FDEAwfgcomparison\Sswfg.txt';
    rankfile='D:\FDEA2016\Codes\abcgenerations\recompileWFG-DTLZ\FDEA\FDEAwfgcomparison\Sswfgranktest.txt';
    writefile='D:\FDEA2016\Codes\abcgenerations\recompileWFG-DTLZ\FDEA\FDEAwfgcomparison\SswfgMerged.txt';    
    %}

    columns=8;
    fidresult= fopen(resultfile);
    fidrank=fopen(rankfile);
    fidwrite=fopen(writefile,'w+');
        
    
    while ~feof(fidresult)
    
        resultline = fgetl(fidresult);
        rankline = fgetl(fidrank);    
        
        result=strsplit(resultline);        
        rank=strsplit(rankline);        
                
        for i=1:columns
            merged(1,i)=strcat(result(1,i),'(',rank(1,i),')');
        end
        
        merged
        
        for l=1:columns        
            fprintf(fidwrite,'%s\t',cell2mat(merged(1,l)));            
        end        
        fprintf(fidwrite,'\n');
            
    end
    
    
  
    fclose('all');
    
end

