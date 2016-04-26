function f=otherAlgHypeEvaluation()


seedNo=[0.05, 0.10, 0.15, 0.20, 0.25, 0.30, 0.35, 0.45,0.50, 0.55, 0.60, 0.65, 0.70, 0.75, 0.80, 0.85 ,0.90,0.95,1.00]
%seedNo= [0.1];

problemtype='wfg';
problem_name=['wfg1';'wfg2';'wfg3';'wfg4';'wfg5';'wfg6';'wfg7';'wfg8';'wfg9']; %p1
dimension=[2 3 5 7 10 12 15 20];%p2%
algo_name=['zhenan'];%i3
RefDir = 'E:\Thesis lab experiment Documents\pf\perfectWFG\';
%genDirectory='E:\Thesis lab experiment documents\abcgenerations\WFGonUpdatedHYP\NSGAIII\';
%genDirectory='E:\Thesis lab experiment documents\Results\abcGenerations\WfgRerun\Zhenan fuzzy\';
genDirectory='E:\Thesis lab experiment documents\abcgenerations\perfectWFG-DTLZ\perfectZhenan\';
baseDirectory=genDirectory;

for i1=1:3
       
    for i2= 1:8
        
        %===================Dimension name=========================================
        
        writefileName=strcat(genDirectory,algo_name(1,:),problem_name(i1,:), num2str(dimension(i2)),'.txt');
        display(writefileName);
        
        fid = fopen(writefileName, 'a+');
        
        fprintf(fid,'\nproblem name = %s\t\t\n\n',problem_name(i1,:));
        fprintf(fid,'\n\ndimension =%d\t\t\n',dimension(i2));
        
        dim=dimension(i2);
        
        %===================Reference Set==========================================
        
        
        RefA=strcat(RefDir,problem_name(i1,:),'_',num2str(dim),'.pf');% a = wfg2_2.pf
        disp(RefA);
        Ref=load(RefA);   
        
        for i3=1:1
            disp(size(Ref));
            r=1;
            for theSeedNum=seedNo
                theSeed=num2str(theSeedNum);
                %theSeed=num2str(theSeedNum,2);
                pfDirectory=strcat(genDirectory,theSeed,'\');
                basePfDirectory=strcat(baseDirectory,theSeed,'\');
                
                a=strcat(pfDirectory,algo_name(i3,:),problem_name(i1,:),'_',num2str(dim),'.pf');% a = pwfg2_2.pf
                basefile=strcat(basePfDirectory,'sid',problem_name(i1,:),'_',num2str(dim),'.pf');% a = pwfg2_2.pf
                
                disp(a);
                P1=load(a);
                P1=nondominated(P1);
                disp(size(P1));
               %{ 
                disp(basefile);
                B1=load(basefile);
                B1=nondominated(B1);
                disp(size(B1));
                %}
                
                %=======================compute metric=====================================
                
                %===============Generational Distance metric (GD)==========================
                
                %% GD Calculation
                
                if strcmpi(problem_name(i1,:), 'dtlz1')==1
                    temp=abs(sum(P1,2)-0.5);
                    temp=temp/sqrt(size(P1,2));
                    GD(r)=mean(temp);
                elseif strcmpi(problem_name(i1,:), 'dtlz7')==1
                    GD2=0;
                    for i=1:size(P1,1)
                        temp2=bsxfun(@minus,P1(i,:),Ref);
                        temp2=power(temp2,2);
                        temp2=sum(temp2,2);
                        temp2=sqrt(temp2);
                        GD2=GD2+min(temp2);
                    end
                    GD(r)=GD2/size(P1,1);
                else                    
                    disp('Calculating GD');

                    GD2=0;
                    mn = min(Ref);
                    mx = max(Ref);
                    %disp(mn);
                    %disp(mx);
                    
                    
                    normalized_P1 = gdivide((gsubtract(P1,mn)),(mx - mn));
                    %disp(max(normalized_P1));
                    %disp(min(normalized_P1));
                    normalized_Ref = gdivide((gsubtract(Ref,mn)),(mx - mn));
                    
                    for i=1:size(P1,1)
                        temp2=bsxfun(@minus,normalized_P1(i,:),normalized_Ref);
                        temp2=power(temp2,2);
                        temp2=sum(temp2,2);
                        temp2=sqrt(temp2);
                        GD2=GD2+power(min(temp2),2);
                    end
                    
                    GD(r)=sqrt(GD2)/size(P1,1);
                    
                    disp(GD(r));
                    
                end
                %===================IGD-metric- Inverse Generational Distance==============
                
                %% IGD calculation
                disp('Calculating IGD');
                
                IGD2=0;
                mn = min(Ref);
                mx = max(Ref);
                %disp(mn);
                %disp(mx);
                
                
                normalized_P1 = gdivide((gsubtract(P1,mn)),(mx - mn));
                %disp(max(normalized_P1));
                %disp(min(normalized_P1));
                normalized_Ref = gdivide((gsubtract(Ref,mn)),(mx - mn));
                
                for i=1:size(Ref,1)
                    temp2=bsxfun(@minus,normalized_Ref(i,:),normalized_P1);
                    temp2=power(temp2,2);
                    temp2=sum(temp2,2);
                    temp2=sqrt(temp2);
                    IGD2=IGD2+power(min(temp2),2);
                end
                
                IGD(r)=sqrt(IGD2)/size(Ref,1);
                
                disp(IGD(r));
                
                
                
                
                %==================S-metric or hypervolume measure=========================
                %% hypervolume calculation                                
                dim = dimension(i2);                
                disp(dim);
                
                if i1<4
                    nadir=max(Ref);
                    nadir=nadir+1.25;
                    bounds=1.1*nadir;                    
                else 
                    nadir=getbounds(problemtype,i1,dim);                
                    bounds=1.1*(nadir); 
                end                
                
                               
                
                disp(bounds);
                
                samplingPoints=1000000;
                
                [m,n]=size(P1);                
                disp('P1:');
                disp(m);
                NP1=removenotdominatebounds(P1,bounds);
                [m,n]=size(NP1);
                disp('NP1');
                disp(m);
                
                if m==0
                    hvvalue=0;
                else
                
                    [rm,rn]=size(Ref);                
                    NP1=gdivide(NP1,nadir);
                    bounds=gdivide(bounds,nadir);

                    if dim<5
                        hvr=hypeIndicatorExact(NP1,bounds,m);
                    else 
                        hvr=hypeIndicatorSampled(NP1,bounds,m,samplingPoints);
                    end

                    %hvrtrue=hypeIndicatorExact(Ref,bounds,rm);                                                
                    %hvr=hypeIndicatorSampled(NP1,bounds,m,samplingPoints);
                    %hvrtrue=hypeIndicatorSampled(Ref,bounds,rm,samplingPoints);

                    %disp('true');
                    %disp(sum(hvrtrue));
                    
                    hvvalue=sum(hvr);
                end
                
                
                %hvr=hypeIndicatorSampled(P1,bounds,1,samplingPoints);               
                
                disp('HVR')
                disp(hvvalue);
                
                S(r)=hvvalue;
                NP(r)=m;
                
                
                
                %==========================Space Uniformity (SU metric)====================
                
                %% spacing Calculation
                
                fmax=max(P1,[],1);
                %if(~all(fmax))
                fmax=fmax+.000001;
                %end
                fmin=min(P1);
                C2=rand(10000,dim);
                C2=bsxfun(@times,C2,(fmax-fmin));
                C2=bsxfun(@rdivide,C2,(fmax-fmin));
                
                P2=bsxfun(@minus,P1,fmin);
                P2=bsxfun(@rdivide,P2,(fmax-fmin));
                SU2=0;
                
                for i=1:size(C2,1)
                    temp2=bsxfun(@minus,C2(i,:),P2);
                    temp2=power(temp2,2);
                    temp2=sum(temp2,2);
                    temp2=sqrt(temp2);
                    SU2=SU2+min(temp2);
                end
                SU(r)=SU2/size(C2,1);
                                
                clear P1
                clear B1
                
                r=r+1;
                
            end
            
            
            disp('hyps')
            disp(S);
            %S=sort(S,2);
            %S=S(1,1:end);
            %{
GD=0;
IGD=0;
SU=0;
            %}
            
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