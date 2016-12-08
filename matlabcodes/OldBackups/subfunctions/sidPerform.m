function f=sidPerform()

seedNo=[0.1,0.5,0.9];

for theSeedNum=seedNo
    
    theSeed=num2str(theSeedNum);


%% loading Settings

%Specify problem name, number of dimension, data set of algorithm
run=10;
pop=250;


%genDirectory='gen\';
%genDirectory='C:\Users\secret\Desktop\sidCleanJmetal\jmetal\abcGenerations\0.5\';
genDirectory=strcat('C:\Users\secret\Desktop\sidCleanJmetal\jmetal\abcGenerations\',theSeed,'\');
%genDirectory=strcat('C:\Users\secret\Desktop\sidCleanJmetal\jmetal\abcGenerations\old result\',theSeed,'\');

problem_name=['wfg2';'wfg3';'wfg4';'wfg5';'wfg6';'wfg7';'wfg8';'wfg9']; %p1
dimension=[2  4 7 10 ];%p2%
%algo_name=['p'];%i3
algo_name=['sid'];%i3

%GenerationDirectory='piceagGeneration';


RefDir = 'C:\Users\secret\Desktop\sidCleanJmetal\jmetal\pf\RefMx300\';
%RefDir = 'C:\Users\secret\Desktop\Untitled Folder\MOEA_2.0-master\MOEA\';


%writefileName=strcat(genDirectory,theSeed, 'wfgResultupdatedCWFG.txt');
writefileName=strcat(genDirectory, 'singleTEst.txt');

fid = fopen(writefileName, 'a+');

for i1=4:4
%for i1=1:8
%===================Problem name===========================================

fprintf(fid,'\nproblem name = %s\t\t\n\n',problem_name(i1,:));

for i2=4:4
%for i2=1:3
%===================Dimension name=========================================


fprintf(fid,'\n\ndimension =%d\t\t\n',dimension(i2));
dim=dimension(i2);

%===================Reference Set==========================================

 




for i3=1:1

RefA=strcat(RefDir,problem_name(i1,:),'_',num2str(dim),'.pf');% a = wfg2_2.pf
disp(RefA);
Ref=load(RefA);

Ref=Ref(1:1000,:);   %take 200

disp(size(Ref));
%Ref=nondominated(Ref);
disp(size(Ref));

%Ref=Ref(1:Take,:);   %take 200

%disp(size(Ref,1));
 
a=strcat(genDirectory,algo_name(i3,:),problem_name(i1,:),'_',num2str(dim),'.pf');% a = pwfg2_2.pf
disp(a);
fid2 = fopen(a,'r');  % Open text file

InputText=textscan(fid2,'%s','delimiter','\n'); 

cell=InputText{1};
%disp(cell(:,:));


[m,n]=size(InputText{1});%m=num of row


j1=1;
r=1;
format long;
while(j1<=m)
    P1=[];
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
     
  %  disp(P1(:,:));
   
    
    P1=nondominated(P1);
  
    disp(size(P1));
   
    
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
        %{
        temp=abs(sqrt(sum(power(P1,2),2))-1);
        GD(r)=mean(temp);
        %}
        
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

  
    %if i1<3 %means wfg2 wfg3 hypervolume calculation wont be perfect
    
    ub = (max(Ref',[],2));
    lb = (min(Ref',[],2));
    
    disp(size(Ref));
    
    %ub=[2,4,6,8,10,12,14,16,18,20];
    %ub=ub';
    
    disp(ub);
    disp(lb);
    
    format short;
    ub=ub+0.1;
   %   ub=ub+(ub-lb)*.1;
    
    
    disp(ub);
    
    
    
   % disp('pass');
   % disp(ub);
    
  %  [sidm sidn]=size(Ref);
    
  %  disp(sidm);
  %  disp(sidn);
    
    hyp1=approximate_hypervolume_ms(Ref',ub,10000);
    disp(hyp1);
    hyp2=approximate_hypervolume_ms(P1',ub,10000);    
    disp(hyp2);
    
    S(r)=hyp2/hyp1;
    
    disp('HYP ratio: ')    
    disp(hyp2/hyp1);


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

    clear P1
    r=r+1;
end
   
%disp('dude\n');
%disp(S);

S=sort(S,2);
%disp('dude\n');
%disp(S);
S=S(1,1:end);
%disp('dude\n');
%disp(S);
%disp('hey dude\n');
%disp(mean(GD));

fprintf(fid,'\n GD ');

fprintf(fid,'\t%.6f', mean(GD));
fprintf(fid,'\t%.6f', std(GD));
fprintf(fid,'\t%.6f', median(GD));

fprintf(fid,'\n IGD');

%%{
fprintf(fid,'\t%.6f', mean(IGD));
fprintf(fid,'\t%.6f', std(IGD));
fprintf(fid,'\t%.6f', median(IGD));

fprintf(fid,'\n HYP ');

fprintf(fid,'\t%.6f', mean(S));
fprintf(fid,'\t%.6f', std(S));
fprintf(fid,'\t%.6f', median(S));

fprintf(fid,'\n SU');

fprintf(fid,'\t%.6f', mean(SU));
fprintf(fid,'\t%.6f', std(SU));
fprintf(fid,'\t%.6f', median(SU));

clear GD IGD S SU
clear SU count P1 P 

fprintf(fid,'\n');
fclose(fid2);
end
fprintf(fid,'\n\t\t\t\t\t\t\t\t\t\t\t\t');
fprintf(fid,'\n\t\t\t\t\t\t\t\t\t\t\t\t');
fprintf(fid,'\n');
end
fprintf(fid,'\n\t\t\t\t\t\t\t\t\t\t\t\t');
fprintf(fid,'\n\t\t\t\t\t\t\t\t\t\t\t\t');
fprintf(fid,'\n');
end
fclose(fid);
f=0;

end
end