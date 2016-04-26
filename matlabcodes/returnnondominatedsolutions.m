function f=returnnondominatedsolutions()
    
    problem_name='wfg2';
    dimension=[2 3 5 7 10 12 15 20];
    
    RefDir = 'E:\Thesis lab experiment documents\pf\WFGReferencePoints\'
    NewDir = 'E:\Thesis lab experiment documents\pf\WFGReferencePoints\nondominated\'
    work=10000;
    
    for dim=dimension
        
        writefileName=strcat(NewDir,problem_name,'_',num2str(dim),'.pf');        
        display(writefileName);
        fid = fopen(writefileName, 'w+');

        RefA=strcat(RefDir,problem_name,'_',num2str(dim),'.pf');
        disp(RefA);
        Ref=load(RefA);
        
        disp(size(Ref));
        %Ref=Ref(1:work,:);
        disp(size(Ref));
        
        P1=nondominated(Ref);
        disp(size(P1));
        [row col]=size(P1);
        %fprintf(fid,'%f\n',P1);
        %dlmwrite(writefileName,P1,'\t%0.6f');
        
        for i=1:size(P1,1)
           fprintf(fid, '%f\t', P1(i,:));
           fprintf(fid, '\n');
        end
        
        fclose(fid);
    
    end
           
    f=0;
end

