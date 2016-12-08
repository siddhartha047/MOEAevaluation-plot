function f=igdCalculation()

    %seedNo=[0.1,0.3,0.5,0.7,0.9,1.0];
    seedNo=[0.1]
    %seedNo=[0.05, 0.10, 0.15, 0.20, 0.25, 0.30, 0.35, 0.40, 0.45,0.50, 0.55, 0.60, 0.65, 0.70, 0.75, 0.80, 0.85 ,0.9,0.95,1]

    problem_name=['DTLZ1';'DTLZ2';'DTLZ3';'DTLZ4';'DTLZ7'];
    dimension=[5 7 10 13 19];%p2%
    algo_name=['sid'];%i3


    RefDir = 'E:\Thesis lab experiment Documents\sidCleanJmetal\jmetal\pf\RefMx300\dtlzlakh\';
    genDirectory='E:\Thesis lab experiment Documents\sidCleanJmetal\jmetal\abcGenerations\100\';

    %genDirectory='C:\Users\secret\Desktop\FDNSGAII\GDE3\';
    %genDirectory='C:\Users\secret\Desktop\FDNSGAII\hypeGenerations\';

    for i1=4:4 %%problem name
        for i2= 3:3 %%dimension

            writefileName=strcat(genDirectory,algo_name(1,:),problem_name(i1,:), num2str(dimension(i2)),'.txt');

            display(writefileName);
            fid = fopen(writefileName, 'a+');
            fprintf(fid,'\nproblem name = %s\t\t\n\n',problem_name(i1,:));
            fprintf(fid,'\n\ndimension =%d\t\t\n',dimension(i2));

            dim=dimension(i2);

            RefA=strcat(RefDir,problem_name(i1,:),'_',num2str(dim),'D.pf');% a = wfg2_2.pf
            disp(RefA);
            Ref=load(RefA);
            disp(size(Ref));

            r=1;

            for theSeedNum=seedNo
                
                theSeed=num2str(theSeedNum);
                pfDirectory=strcat(genDirectory,theSeed,'\');
                a=strcat(pfDirectory,algo_name(1,:),problem_name(i1,:),'_',num2str(dim),'.pf');% a = pwfg2_2.pf
                disp(a);               
                
                P1=readReferenceFile(a);
                disp(size(P1));
               
                IGD(r)=calculateIGD(Ref,P1);
                disp(IGD(r));
                
                clear P1
                r=r+1;

            end
            
            
            disp('all igds')
            disp(IGD);
            
            fprintf(fid,'\t%.6f\n',IGD);
            
            clear IGD
            clear P1 P
            fprintf(fid,'\n');
            fclose(fid);
            
        end
    end
    f=0;
end