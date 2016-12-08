function s = wilcoxon_rank_sum_testDTLZ()
    
    %x1=[1 2 3 4 5]
    %x2=[10 ]
    
    writedir='E:\Thesis lab experiment documents\abcgenerations\perfectWFG-DTLZ\dtlz.txt';
    writerank='E:\Thesis lab experiment documents\abcgenerations\perfectWFG-DTLZ\dtlzrank.txt';
    
    problem='dtlz'
    problemNos=[1 2 3 4 7];
    dimensions=[2 3 5 7 10 12 15 20];
    performancetype='Ss';
    seed=20;
    
    algorithms=[{'gde3'},{'hype'},{'moead'},{'zhenan'},{'nsgaiii'},{'moeaxxx'}];
    
    fid = fopen(writedir, 'w+');
    fid1 =fopen(writerank, 'w+');
    
    
    for problemNo=problemNos
        
        fprintf(fid,'objective\t');
        fprintf(fid1,'objective\t');
        for l=1:6                
            fprintf(fid,'%s\t',cell2mat(algorithms(1,l)));
            fprintf(fid1,'%s\t',cell2mat(algorithms(1,l)));
            
        end
        fprintf(fid,'\n');
        fprintf(fid1,'\n');
        
        for dimension=[2 3 5 7 10 12 15 20];
            
            gde3=make_array_fix_length(getperformanceData(strcat('E:\Thesis lab experiment documents\abcgenerations\perfectWFG-DTLZ\perfectgde3','\','gde3',problem,num2str(problemNo),num2str(dimension),'.txt'),performancetype),seed)
            hype=make_array_fix_length(getperformanceData(strcat('E:\Thesis lab experiment documents\abcgenerations\perfectWFG-DTLZ\perfectHYPEDTLZBoundSample','\','hype',problem,num2str(problemNo),num2str(dimension),'.txt'),performancetype),seed)
            moead=make_array_fix_length(getperformanceData(strcat('E:\Thesis lab experiment documents\abcgenerations\perfectWFG-DTLZ\perfectMOEAD','\','moead',problem,num2str(problemNo),num2str(dimension),'.txt'),performancetype),seed)
            zhenan=make_array_fix_length(getperformanceData(strcat('E:\Thesis lab experiment documents\abcgenerations\perfectWFG-DTLZ\perfectZhenan','\','zhenan',problem,num2str(problemNo),num2str(dimension),'.txt'),performancetype),seed)
            nsgaiii=make_array_fix_length(getperformanceData(strcat('E:\Thesis lab experiment documents\abcgenerations\perfectWFG-DTLZ\perfectDTLZNSGAIII','\','nsgaiiiexp',problem,num2str(problemNo),num2str(dimension),'.txt'),performancetype),seed)
            moeaxxx=make_array_fix_length(getperformanceData(strcat('E:\Thesis lab experiment documents\abcgenerations\perfectWFG-DTLZ\perfectMOEAminmax2','\','sid',problem,num2str(problemNo),num2str(dimension),'.txt'),performancetype),seed)

            data=[{gde3},{hype},{moead},{zhenan},{nsgaiii},{moeaxxx}];

            score=zeros(1,6);
            
            for i=1:6
                delta=0;
                for j=1:6
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
    
    fclose(fid);
    fclose(fid1);
    
    flcose('all');
    
    s=0;
end