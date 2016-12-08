function f=sidFinalRun()

%seedNo=[0.1,0.3,0.5,0.7,0.9,1.0]; 

seedNo=[0.1,0.3,0.5,0.7,0.9]
%seedNo=[0.05, 0.10, 0.15, 0.20, 0.25, 0.30, 0.35, 0.40, 0.45,0.50, 0.55, 0.60, 0.65, 0.70, 0.75, 0.80, 0.85 ,0.9,0.95,1]

%for theSeedNum=seedNo
    
    %theSeed=num2str(theSeedNum);


%% loading Settings

%Specify problem name, number of dimension, data set of algorithm
run=10;
pop=250;


%genDirectory='gen\';
%genDirectory='C:\Users\secret\Desktop\sidCleanJmetal\jmetal\abcGenerations\0.5\';
%genDirectory=strcat('C:\Users\secret\Desktop\sidCleanJmetal\jmetal\abcGenerations\',theSeed,'\');
%genDirectory=strcat('C:\Users\secret\Desktop\sidCleanJmetal\jmetal\abcGenerations\old result\',theSeed,'\');

problem_name=['DTLZ1';'DTLZ2';'DTLZ3';'DTLZ4';'DTLZ7'];
dimension=[5 7 10 13 19];%p2%
%algo_name=['p'];%i3
%algo_name=['gde3'];%i3
%algo_name=['moead'];%i3
algo_name=['sid'];%i3
%algo_name=['moead'];%i3


%GenerationDirectory='piceagGeneration';


RefDir = 'E:\Thesis lab experiment Documents\pf\RefMx300\dtlzlakh\';
%RefDir = 'C:\Users\secret\Desktop\Untitled Folder\MOEA_2.0-master\MOEA\';


%writefileName=strcat(genDirectory,theSeed,'wfgResultupdatedCWFG.txt');
%writefileName=strcat(genDirectory, 'singleTEst.txt');
 
%genDirectory='gen\';
genDirectory='E:\Thesis lab experiment Documents\abcGenerations\100\';

%genDirectory='C:\Users\secret\Desktop\FDNSGAII\GDE3\';
%genDirectory='C:\Users\secret\Desktop\FDNSGAII\hypeGenerations\';

%for i1 =[1 2 4]   
for i1=1:5
%===================Problem name===========================================

for i2= 1:5
%for i2=1:3
%===================Dimension name=========================================

writefileName=strcat(genDirectory,algo_name(1,:),problem_name(i1,:), num2str(dimension(i2)),'.txt');
writefileName

fid = fopen(writefileName, 'a+');

fprintf(fid,'\nproblem name = %s\t\t\n\n',problem_name(i1,:));
fprintf(fid,'\n\ndimension =%d\t\t\n',dimension(i2));
                 
dim=dimension(i2);

%===================Reference Set==========================================




for i3=1:1

RefA=strcat(RefDir,problem_name(i1,:),'_',num2str(dim),'D.pf');% a = wfg2_2.pf
disp(RefA);
Ref=load(RefA);


%Ref=Ref(1:1000,:);   %take 200

disp(size(Ref));
%Ref=nondominated(Ref);
disp(size(Ref));

%Ref=Ref(1:Take,:);   %take 200

%disp(size(Ref,1));

r=1;


for theSeedNum=seedNo
%for theSeedNum=[0.05:0.05:1]
   
theSeed=num2str(theSeedNum);
pfDirectory=strcat(genDirectory,theSeed,'\');
 
a=strcat(pfDirectory,algo_name(i3,:),problem_name(i1,:),'_',num2str(dim),'.pf');% a = pwfg2_2.pf
disp(a);
fid2 = fopen(a,'r');  % Open text file

InputText=textscan(fid2,'%s','delimiter','\n'); 

cell=InputText{1};
%disp(cell(:,:));


[m,n]=size(InputText{1});%m=num of row




j1=1;



format long;

    P1=[];
    
    %%
    
    while j1<=m
        s=InputText{1}(j1);
        %{
            if j1==2
                disp(s(:,:));
            end
        %}
        
        b=cell2mat(s);
        %disp(b);
        if(strcmp(b,'')==false)
            c=[];
            while true
                [str b]= strtok(b);
                
                %disp(str);
                %disp(b);
                
                if(strcmp(b,'')==true),  break;  end
                
                v=str2double(str);
                c=cat(2,c,v);
            end
            
           % disp(c);
            
            P1=cat(1,P1,c);
            j1=j1+1;
        else
            j1=j1+1;
            break;
        end     
        
        if((i3==1 || i3==6) && mod(j1,pop)==1 && j1>1)
            break;
        end        
        
    end
    
    %format short;     
    %disp(P1(:,:));
       
    P1=nondominated(P1);
    disp(size(P1));
   %%
    
%=======================compute metric=====================================

%===============Generational Distance metric (GD)==========================

    %% GD Calculation
    
    disp('Calculating GD');

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
        %{
        temp=abs(sqrt(sum(power(P1,2),2))-1);
        GD(r)=mean(temp);
        %}
        
       
         
      
        
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
                
        
        
    end
    
    disp(GD(r));
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

  
    %if i1<3 %means wfg2 wfg3 hypervolume calculation wont be perfect
    %{
    ub = (max(Ref',[],2));
    lb = (min(Ref',[],2));
    
    disp(size(Ref));
    
    %ub=[2,4,6,8,10,12,14,16,18,20];
    %ub=ub';
    
    disp(ub);
    disp(lb);
    
    format short;
    %ub=ub+0.1;
    
    val=max((ub-lb)*.1,0.1);
    
    disp('normal');
    disp((ub-lb)*.1);
    disp('max');
    disp(val);
    
    
    ub=ub+val;
    
    
    disp(ub);
    
    
    
   % disp('pass');
   % disp(ub);
    
  %  [sidm sidn]=size(Ref);
    
  %  disp(sidm);
  %  disp(sidn);
    
    hyp1=approximate_hypervolume_ms(Ref',ub,20000);
    disp(hyp1);
    hyp2=approximate_hypervolume_ms(P1',ub,20000);    
    disp(hyp2);
    
    S(r)=hyp2/hyp1;
    
    disp('HYP ratio: ')    
    disp(hyp2/hyp1);
%}
   
    %hypervolume calculation with Nadir of
    %Obtained and reference front+delta
    
    ubRef = (max(Ref',[],2));
    ubP1 = (max(P1',[],2));
       
    disp(ubRef);
    disp(ubP1);
    
    format short;
    
    worstValue=max(ubRef,ubP1);    
    disp(worstValue);    
    
    delta=0.1;    
    ub=worstValue+delta;    
    disp(ub);
    
    samplingPoints=50000;
    
    
    
    
    hvr=sid_approximate_hypervolume_ms(Ref',P1',ub,samplingPoints); 
    
    disp('HVR')   
    disp(hvr);
    
    S(r)=hvr;
    
     
    

%{    
disp('andy');
    v=hypervolume(P1,Ref,40000);
    disp(v);
    disp('andy');
    fN=false(size(C,1),1);
  
    for c1=1:size(C,1)
        f=all(bsxfun(@ge, C(c1,:), P1), 2);
        f=any(f,1);
        fN(c1)=f;
    end
    %disp(fN(1:25,:));
    S(r)=sum(fN)/size(fN,1);
    %disp(sum(fN));
    %disp(size(fN,1));
    %disp(S(r));
%}
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
    
    %%
    
fclose(fid2);
clear P1
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

fprintf(fid,'\nGDs\t\t');
fprintf(fid,'\t%.6f',GD);
fprintf(fid,'\nIGDs\t\t');
fprintf(fid,'\t%.6f',IGD);
fprintf(fid,'\nSs\t\t');
fprintf(fid,'\t%.6f',S);
fprintf(fid,'\nSUs\t\t');
fprintf(fid,'\t%.6f',SU);


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
clear SU count P1 P 

fprintf(fid,'\n');

end

fclose(fid);
end

end

f=0;

%end
end