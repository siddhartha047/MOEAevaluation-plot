function f=FDEAHypeEvaluationDTLZ()


seedNo=[0.05, 0.10, 0.15, 0.20, 0.25, 0.30, 0.35, 0.40, 0.45,0.50, 0.55, 0.60, 0.65, 0.70, 0.75, 0.80, 0.85 ,0.90,0.95,1.00]
%seedNo=[0.05, 0.10, 0.15, 0.20, 0.25]
%seedNo=[0.1,0.5, 0.9]



problemtype='DTLZ';
problem_name=['DTLZ1';'DTLZ2';'DTLZ3';'DTLZ4';'DTLZ7';]; %p1
dimension=[2 3 5 7 10 12 15 20 25];%p2%

algo_name=['fdea'];%i3

RefDir = 'D:\FDEA2016\Codes\NSGAIII\DTLZfront\DTLZfront\PF\dtlzuniform\';
%RefDir = 'D:\FDEA2016\Codes\NSGAIII\DTLZfront\DTLZfront\PF\fdeadtlzuniform\';
%RefDir = 'D:\FDEA2016\Codes\pf\perfectDTLZ\';

genDirectory = 'D:\FDEA2016\Codes\abcgenerations\recompileWFG-DTLZ\FDEA\FDEAdtlzgaussian\gaussian\2\';

%later run the 1:4 20 for 3 seed

for i1=1:1
       
    for i2=1:9
        %===================Dimension name=========================================
        
        writefileName=strcat(genDirectory,'nFIGD',algo_name(1,:),problem_name(i1,:), num2str(dimension(i2)),'.txt');
        display(writefileName);
        
        [pathstr,name,ext] = fileparts(writefileName) 
        mkdir(pathstr);
        
        fid = fopen(writefileName, 'a+');
        
        fprintf(fid,'\nproblem name = %s\t\t\n\n',problem_name(i1,:));
        fprintf(fid,'\n\ndimension =%d\t\t\n',dimension(i2));
        
        dim=dimension(i2);
        
        %===================Reference Set==========================================
        
        
       RefA=strcat(RefDir,problem_name(i1,:),'_',num2str(dim),'.pf');% a = wfg2_2.pf
      % RefA=strcat(RefDir,problem_name(i1,:),'_',num2str(dim),'D.pf');% a = wfg2_2.pf
        disp(RefA);
        Ref=load(RefA);   
        
      [rrow rcol]=size(Ref);
      Ref=Ref(1:min(10000,rrow),:);   %take 200
        
        
        for i3=1:1
            disp(size(Ref));
            r=1;
            for theSeedNum=seedNo
                theSeed=num2str(theSeedNum);                
                pfDirectory=strcat(genDirectory,theSeed,'\');
                a=strcat(pfDirectory,algo_name(i3,:),problem_name(i1,:),'_',num2str(dim),'.pf');% a = pwfg2_2.pf  
              %  a=strcat(pfDirectory,algo_name(i3,:),problem_name(i1,:),'(',num2str(dim),').ini.pf');% a = pwfg2_2.pf  
               
                
                disp(a);
                P1=load(a);
                P1=nondominated(P1);
                disp(size(P1));
                
                P1=readReferenceFile(a);
                disp(size(P1));
                [p1r, p1c]=size(P1);
                if p1r==0
                    IGD(r)=0;
                    
                    disp(IGD(r));
                    
                    GD(r)=0;
                    disp(GD(r));
                    
                    S(r)=0;
                    disp(S(r));

                    SU(r)=0;                    
                    disp(SU(r));

                    NP(r)=0;
                    disp(NP(r));
                else
                
                    IGD(r)=calculateIGD(Ref,P1);
                    %IGD(r)=0;
                    disp('IGD : ');
                    disp(IGD(r));

                    GD(r)=calculateGD(Ref,P1);
                   % GD(r)=0;
                    disp(GD(r));

                    S(r)=calculateDTLZHYPE(Ref,P1,i1);
                    %S(r)=0;
                    disp(S(r));

                    %SU(r)=0;
                    SU(r)=calculateSU(P1,dim);                
                    disp(SU(r));

                    NP(r)=0;
                    disp(NP(r));
                end              
                clear P1                         
                clear P1
                clear B1
                
                r=r+1;
                
            end
            
            
            disp('hyps')
            disp(S);
            
            disp('all gds')
            disp(GD);
            
            disp('all igds')
            disp(IGD);
            
            fprintf(fid,'\nNDs\t\t');
            fprintf(fid,'\t%d',NP);
            fprintf(fid,'\nGDs\t\t');
            fprintf(fid,'\t%.6f',GD);
            fprintf(fid,'\nIGDs\t\t');
            fprintf(fid,'\t%.6f',IGD);
            fprintf(fid,'\nSs\t\t');
            fprintf(fid,'\t%.6f',S);
            fprintf(fid,'\nSUs\t\t');
            fprintf(fid,'\t%.6f',SU);
            
            fprintf(fid,'\n NP ');
            fprintf(fid,'\t%d', mean(NP));
            fprintf(fid,'\t%d', std(NP));
            fprintf(fid,'\t%d', median(NP));
            fprintf(fid,'\t%d', max(NP));
            fprintf(fid,'\t%d', min(NP));
            
            
            fprintf(fid,'\n GD ');
            fprintf(fid,'\t%.6f', mean(GD));
            fprintf(fid,'\t%.6f', std(GD));
            fprintf(fid,'\t%.6f', median(GD));
            fprintf(fid,'\t%.6f', max(GD));
            fprintf(fid,'\t%.6f', min(GD));
            
            fprintf(fid,'\n IGD');
            
            %%{
            fprintf(fid,'\t%.6f', mean(IGD));
            fprintf(fid,'\t%.6f', std(IGD));
            fprintf(fid,'\t%.6f', median(IGD));
            fprintf(fid,'\t%.6f', max(IGD));
            fprintf(fid,'\t%.6f', min(IGD));
            
            fprintf(fid,'\n HYP ');
            
            
            fprintf(fid,'\t%.6f', mean(S));
            fprintf(fid,'\t%.6f', std(S));
            fprintf(fid,'\t%.6f', median(S));
            fprintf(fid,'\t%.6f', max(S));
            fprintf(fid,'\t%.6f', min(S));
            
            
            fprintf(fid,'\n SU');
            
            fprintf(fid,'\t%.6f', mean(SU));
            fprintf(fid,'\t%.6f', std(SU));
            fprintf(fid,'\t%.6f', median(SU));
            fprintf(fid,'\t%.6f', max(SU));
            fprintf(fid,'\t%.6f', min(SU));
            
            clear GD IGD S SU
            clear SU count P1 P NP
            
            fprintf(fid,'\n');
            
        end
        
        fclose(fid);
    end
    
end

f=0;

%end
end