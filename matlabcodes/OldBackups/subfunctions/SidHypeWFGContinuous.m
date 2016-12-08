function f=SidHypeWFGContinuous()

    seedNo=[.5]
    %seedNo=[0.05, 0.10, 0.15, 0.20, 0.25, 0.30, 0.35, 0.40, 0.45,0.50, 0.55, 0.60, 0.65, 0.70, 0.75, 0.80, 0.85 ,0.9,0.95,1]

    problem_name=['wfg1';'wfg2';'wfg3';'wfg4';'wfg5';'wfg6';'wfg7';'wfg8';'wfg9'];
    %problem_name=['dtlz1';'dtlz2';'dtlz3';'dtlz4';'dtlz7'];
    dimension=[2 3 5 7 10 12 15 20];%p2%
     algo_name=['sid'];%i3
    %algo_name=['zhenan'];%i3


    RefDir = 'E:\Thesis lab experiment Documents\pf\perfectWFG\';
    genDirectory='E:\Thesis lab experiment documents\abcgenerations\perfectWFG-DTLZ\generationwise\perfectMOEAgen\';

    %genDirectory='C:\Users\secret\Desktop\FDNSGAII\GDE3\';
    %genDirectory='C:\Users\secret\Desktop\FDNSGAII\hypeGenerations\';
    
    
    generationNo=250;
    div=10;
    
    for i1=[6] %%problem name
        for i2= 1:8 %%dimension
            
            
            IGDwritefileName=strcat(genDirectory,algo_name(1,:),problem_name(i1,:), num2str(dimension(i2)),'IGD.txt');
            GDwritefileName=strcat(genDirectory,algo_name(1,:),problem_name(i1,:), num2str(dimension(i2)),'GD.txt');
            HYPEwritefileName=strcat(genDirectory,algo_name(1,:),problem_name(i1,:), num2str(dimension(i2)),'HYPE.txt');

            
            display(IGDwritefileName);
            display(GDwritefileName);
            display(HYPEwritefileName);
            
            IGDfid = fopen(IGDwritefileName, 'w+');
            GDfid = fopen(GDwritefileName, 'w+');
            HYPEfid = fopen(HYPEwritefileName, 'w+');
            
           %% fprintf(IGDfid,'\nproblem name = %s\t\t\n\n',problem_name(i1,:));
           %% fprintf(IGDfid,'\n\ndimension =%d\t\t\n',dimension(i2));

            dim=dimension(i2);

            RefA=strcat(RefDir,problem_name(i1,:),'_',num2str(dim),'.pf');% a = wfg2_2.pf
            disp(RefA);
            Ref=load(RefA);
            disp(size(Ref));
            Ref=Ref(1:5000,:);
        
            [sM,sN]=size(seedNo);
            
            
            
            IGD=zeros(generationNo/div,sN);
            GD =zeros(generationNo/div,sN);
            HYPE=zeros(generationNo/div,sN);
            
            seedNumber=1;
            
            for theSeedNum=seedNo
                
                theSeed=num2str(theSeedNum);
                pfDirectory=strcat(genDirectory,theSeed,'\');
                a=strcat(pfDirectory,algo_name(1,:),problem_name(i1,:),'_',num2str(dim),'.pf');% a = pwfg2_2.pf
                disp(a);               
                
                r=1;
                
                for gen=0:div:generationNo
                    genFile=a;
                    if(gen~=generationNo)
                        genFile=strcat(a,num2str(gen));
                    end
                    display(genFile);
                    
                    P1=readReferenceFile(genFile);
                    disp(size(P1));
                    
                    
                    IGD(r,seedNumber)=calculateIGD(Ref,P1);
                    %IGD(r,seedNumber)=0;
                    disp(IGD(r,seedNumber));
                    
                    GD(r,seedNumber)=calculateGD(Ref,P1);
                    %GD(r,seedNumber)=0;
                    disp(GD(r,seedNumber));
                    
                    HYPE(r,seedNumber)=calculateHYPE(Ref,P1,i1);
                    %HYPE(r,seedNumber)=0;
                    disp(HYPE(r,seedNumber));
                    
                    
                     
                    clear P1
                    r=r+1;
                end
                
                seedNumber=seedNumber+1;
            end
            
            
            disp('all gds')
            disp(GD);
            
            disp('all igds')
            disp(IGD);
            
            disp('all HYPEs');
            disp(HYPE);
            
            for k=1:generationNo/div
                for j=1:sN
                    fprintf(IGDfid,'%.6f\t',IGD(k,j));
                end
                fprintf(IGDfid,'\n');
            end
            
            for k=1:generationNo/div
                for j=1:sN
                    fprintf(GDfid,'%.6f\t',GD(k,j));
                end
                fprintf(GDfid,'\n');
            end
            
            for k=1:generationNo/div
                for j=1:sN
                    fprintf(HYPEfid,'%.6f\t',HYPE(k,j));
                end
                fprintf(HYPEfid,'\n');
            end
            
            %%fprintf(IGDfid,'\t%.6f\n',IGD);
            
            clear IGD
            clear GD
            clear HYPE
            
            clear P1 P
            fprintf(IGDfid,'\n');
            fclose(IGDfid);
            
        end
    end
    f=0;
end
