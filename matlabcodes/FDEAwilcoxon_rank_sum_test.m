function s = FDEAwilcoxon_rank_sum_test()
    
    %x1=[1 2 3 4 5]
    %x2=[10 ]
    thebaseDir='D:\FDEA2016\Codes\abcgenerations\recompileWFG-DTLZ';    
    performancetype='Ss';
    writedir=strcat(thebaseDir,'\',performancetype,'wfgtest.txt');
    writerank=strcat(thebaseDir,'\',performancetype,'wfgranktest.txt');
    writeobjectivescore=strcat(thebaseDir,'\',performancetype,'wfgobjectivescoretest.txt');
    
    problem='wfg'
    %problemNos=[1 2 3 4 5 6 7 8 9];
    problemNos=[1 2];
    dimensions=[2 3 5 7 10 12 15 20 25];
    
    
    
    
    
    
    seed=20;
    
    algorithms=[{'hype'},{'moead'},{'zhenan'},{'sde'},{'nsgaiii'},{'piceag'},{'moeaxxx'}];
   % algorithms=[{'hype'},{'moead'},{'sde'},{'nsgaiii'},{'piceag'},{'moeaxxx'}];
    
    totalscore=zeros(9,size(algorithms,2)+1);

    fid = fopen(writedir, 'w+');
    fid1 =fopen(writerank, 'w+');
    %fidobj=fopen(writeobjectivescore,'w+');
    
    for problemNo=problemNos
        
        fprintf(fid,'objective\t');
        fprintf(fid1,'objective\t');
        for l=1:size(algorithms,2)                
            fprintf(fid,'%s\t',cell2mat(algorithms(1,l)));
            fprintf(fid1,'%s\t',cell2mat(algorithms(1,l)));
            
        end
        fprintf(fid,'\n');
        fprintf(fid1,'\n');
        
        dimindex=0;
        
        for dimension=[2 3 5 7 10 12 15 20 25];
            
            dimindex=dimindex+1;
            
            
            %gde3=make_array_fix_length(getperformanceData(strcat(thebaseDir,'\perfectgde3','\','gde3',problem,num2str(problemNo),num2str(dimension),'.txt'),performancetype),seed)
            hype=make_array_fix_length(getperformanceData(strcat(thebaseDir,'\perfectHYPEBoundSample\CorrectWFG12','\','hype',problem,num2str(problemNo),num2str(dimension),'.txt'),performancetype),seed)
            moead=make_array_fix_length(getperformanceData(strcat(thebaseDir,'\perfectMOEAD\CorrectWFG12','\','moead',problem,num2str(problemNo),num2str(dimension),'.txt'),performancetype),seed)
            zhenan=make_array_fix_length(getperformanceData(strcat(thebaseDir,'\perfectZhenan\CorrectWFG12','\','zhenan',problem,num2str(problemNo),num2str(dimension),'.txt'),performancetype),seed)
            sde=make_array_fix_length(getperformanceData(strcat(thebaseDir,'\perfectSDEwfg\CorrectWFG12','\','sde',problem,num2str(problemNo),num2str(dimension),'.txt'),performancetype),seed)
            nsgaiii=make_array_fix_length(getperformanceData(strcat(thebaseDir,'\perfectNSGAIII\CorrectWFG12','\','nsgaiii',problem,num2str(problemNo),num2str(dimension),'.txt'),performancetype),seed)
            piceag=make_array_fix_length(getperformanceData(strcat(thebaseDir,'\perfectPICEAG\CorrectWFG12','\','p',problem,num2str(problemNo),num2str(dimension),'.txt'),performancetype),seed)
            %theta=make_array_fix_length(getperformanceData(strcat(thebaseDir,'\perfectThetaDEA','\','theta',problem,num2str(problemNo),num2str(dimension),'.txt'),performancetype),seed)
            %moeaxxx=make_array_fix_length(getperformanceData(strcat(thebaseDir,'\FDEA\newFDEAwfg2504\2','\','sid',problem,num2str(problemNo),num2str(dimension),'.txt'),performancetype),seed)
            moeaxxx=make_array_fix_length(getperformanceData(strcat(thebaseDir,'\FDEA\FDEAwfggaussian\2\CorrectWFG12','\','sid',problem,num2str(problemNo),num2str(dimension),'.txt'),performancetype),seed)

            data=[{hype},{moead},{zhenan},{sde},{nsgaiii},{piceag},{moeaxxx}];
            %data=[{hype},{moead},{sde},{nsgaiii},{piceag},{moeaxxx}];

            score=zeros(1,size(algorithms,2));
            
            for i=1:size(algorithms,2)
                delta=0;
                for j=1:size(algorithms,2)
                    if i==j
                        continue;
                    end
                    [p,h,stats]=ranksum(cell2mat(data(1,j)),cell2mat(data(1,i)),'alpha',0.01,'tail','right');
                    if h==1
                        delta=delta+1;
                    end

                end

                score(1,i)=delta;  
                                
            end
        %}
            
            score            
            
            totalscore(dimindex,1)=dimension;
            
            totalscore(dimindex,2:size(algorithms,2)+1)=totalscore(dimindex,2:size(algorithms,2)+1)+score;
            
            fprintf(fid,'%d\t',dimension);            
            fprintf(fid,'%d\t',score);
            fprintf(fid,'\n');
            
            tie=tiedrank(score)
            
            fprintf(fid1,'%d\t',dimension);            
            fprintf(fid1,'%g\t',tie);
            fprintf(fid1,'\n');
            
            
        end
    end 
    
    %[p,h,stats]=ranksum(x1,x2,'alpha',0.05,'tail','right')
    
    totalscore
    
    totalscore=totalscore/9
    
    fclose(fid);
    fclose(fid1);
    
    fclose('all');
    
    s=0;
end