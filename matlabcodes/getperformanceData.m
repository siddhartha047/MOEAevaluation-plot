function data=getperformanceData(filename,type)
    
    %filename='E:\Thesis lab experiment documents\abcgenerations\perfectWFG-DTLZ\perfectMOEAminmax2\sidwfg12.txt';
    %type='Ss'
    line='';
    
    fid = fopen(filename);
    y = 0;
    tline = fgetl(fid);
    while ~feof(fid)
        tline=fgetl(fid);
        arr=strsplit(tline);        
        if strcmp(arr(1,1),type)==1
            line=tline;
        end        
    end
    
    
    a=strsplit(line);    
    [r,c]=size(a);    
    data=str2double(a(:,2:c));
    
    fclose(fid);
end

