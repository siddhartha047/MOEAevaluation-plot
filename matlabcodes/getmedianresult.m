function dir=getmedianresult(filename,type)
    
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
    
    %line
    
    a=strsplit(line);
    [r,c]=size(a);
    
    if c~=21
        disp('not all seed used');
        
        
        [pathstr,name,ext] = fileparts(filename);   
        dir=strcat(pathstr,'\0.1\');
        
        return 
    end    
    b=a(:,2:c);    
    seed=0:0.05:1;
    
    
    
   [sorted, indices]=sort(b);
   
   s=seed(indices);
   
   seedNo=seed(1,10);
   
   [pathstr,name,ext] = fileparts(filename);   
   dir=strcat(pathstr,'\',num2str(seedNo,2),'\');

end

