function f=sidFinalIGDWFG()

    %seedNo=[0.1,0.3,0.5,0.7,0.9,1.0];
    seedNo=[0.1,0.3,0.5,.7,.9]
    %seedNo=[0.05, 0.10, 0.15, 0.20, 0.25, 0.30, 0.35, 0.40, 0.45,0.50, 0.55, 0.60, 0.65, 0.70, 0.75, 0.80, 0.85 ,0.9,0.95,1]

    problem_name=['wfg1';'wfg2';'wfg3';'wfg4';'wfg5';'wfg6';'wfg7';'wfg8';'wfg9']; %p1
    dimension=[5 7 10 13 19];%p2%
    algo_name=['sid'];%i3


    RefDir = 'E:\Thesis lab experiment Documents\pf\RefMx300\'
    genDirectory='E:\Thesis lab experiment Documents\abcGenerations\100\';
  
    generationNo=1;
    
    for i1=7:7 %%problem name
        for i2= 1:5 %%dimension

            writefileName=strcat(genDirectory,algo_name(1,:),problem_name(i1,:), num2str(dimension(i2)),'.txt');

            display(writefileName);
            fid = fopen(writefileName, 'a+');
           %% fprintf(fid,'\nproblem name = %s\t\t\n\n',problem_name(i1,:));
           %% fprintf(fid,'\n\ndimension =%d\t\t\n',dimension(i2));

            dim=dimension(i2);

            RefA=strcat(RefDir,problem_name(i1,:),'_',num2str(dim),'.pf');% a = wfg2_2.pf
            disp(RefA);
            Ref=load(RefA);
            disp(size(Ref));
        
            [sM,sN]=size(seedNo);
            
            IGD=zeros(generationNo,sN);
            GD =zeros(generationNo,sN);
            
            
            seedNumber=1;
            
            for theSeedNum=seedNo
                
                theSeed=num2str(theSeedNum);
                pfDirectory=strcat(genDirectory,theSeed,'\');
                a=strcat(pfDirectory,algo_name(1,:),problem_name(i1,:),'_',num2str(dim),'.pf');% a = pwfg2_2.pf
                disp(a);               
                
                r=1;
                
                for gen=0:(generationNo-1)
                    genFile=a;
                    if(gen~=(generationNo-1))
                        genFile=strcat(a,num2str(gen));
                    end
                    display(genFile);
                    
                    P1=readReferenceFile(genFile);
                    disp(size(P1));
                    
                    
                    IGD(r,seedNumber)=calculateIGD(Ref,P1);
                    disp(IGD(r,seedNumber));
                    
                    GD(r,seedNumber)=calculateGD(Ref,P1);
                    disp(GD(r,seedNumber));
                    
                    
                     
                    clear P1
                    r=r+1;
                end
                
                seedNumber=seedNumber+1;
            end
            
            
            disp('all gds')
            disp(GD);
            
            disp('all igds')
            disp(IGD);
            
            for k=1:generationNo
                for j=1:sN
                    fprintf(fid,'%.6f\t',IGD(k,j));
                end
                fprintf(fid,'\n');
            end
            
            %%fprintf(fid,'\t%.6f\n',IGD);
            
            clear IGD
            clear GD
            
            clear P1 P
            fprintf(fid,'\n');
            fclose(fid);
            
        end
    end
    f=0;
end