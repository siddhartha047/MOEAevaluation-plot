function s = FDEAwilcoxon_rank_sum_testComparisonWFG()
    
    %x1=[1 2 3 4 5]
    %x2=[10 ]
    thebaseDir='D:\FDEA2016\Codes\abcgenerations\recompileWFG-DTLZ\FDEA\FDEAwfgcomparison\';    
    performancetype='Ss';
    writedir=strcat(thebaseDir,'\',performancetype,'wfgtest.txt');
    writerank=strcat(thebaseDir,'\',performancetype,'wfgranktest.txt');
    writeobjectivescore=strcat(thebaseDir,'\',performancetype,'wfgobjectivescoretest.txt');
    
    problem='wfg'
    problemNos=[4 5 6];
    dimensions=[2 3 5 7 10 12 15 20];
    
    
    
    
    
    
    seed=20;
    
   % algorithms=[{'fdea'},{'fdea'},{'fdea'},{'fdea'}];
    algorithms=[{'sid'},{'sid'},{'sid'}];
       
    totalscore=zeros(8,size(algorithms,2)+1);

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
        
        for dimension=[7 10 15];
            
            dimindex=dimindex+1;
            
            
            withoutref=make_array_fix_length(getperformanceData(strcat(thebaseDir,'\withoutrefpoints\2','\','sid',problem,num2str(problemNo),num2str(dimension),'.txt'),performancetype),seed)
            pareto=make_array_fix_length(getperformanceData(strcat(thebaseDir,'\pareto\2','\','sid',problem,num2str(problemNo),num2str(dimension),'.txt'),performancetype),seed)
            gaussian=make_array_fix_length(getperformanceData(strcat(thebaseDir,'\gaussian\2','\','sid',problem,num2str(problemNo),num2str(dimension),'.txt'),performancetype),seed)
            sigmoid=make_array_fix_lengthFDEA(getperformanceData(strcat(thebaseDir,'\sigmoid\2','\','sid',problem,num2str(problemNo),num2str(dimension),'.txt'),performancetype),seed)
            
            %data=[{withoutref},{pareto},{gaussian},{sigmoid}];
            data=[{withoutref},{pareto},{gaussian}];
           
            score=zeros(1,size(algorithms,2));
            
            for i=1:size(algorithms,2)
                delta=0;
                for j=1:size(algorithms,2)
                    if i==j
                        continue;
                    end
                    [p,h,stats]=ranksum(cell2mat(data(1,j)),cell2mat(data(1,i)),'alpha',0.05,'tail','right');
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