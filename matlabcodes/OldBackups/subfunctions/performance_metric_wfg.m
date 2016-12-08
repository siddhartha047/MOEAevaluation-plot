function f=performance_metric_wfg()


%Specify problem name, number of dimension, data set of algorithm
run=10;
pop=100;

problem_name=['wfg2';'wfg3';'wfg4';'wfg5';'wfg6';'wfg7';'wfg8';'wfg9']; %p1
dimension=[2 4 7 10];%p2
algo_name=['p'];%i3

fid = fopen('wfg23456789.txt', 'w');

for i1=1:6
%===================Problem name===========================================

fprintf(fid,'\nproblem name = %s\t\t\n\n',problem_name(i1,:));

for i2=1:5
%===================Dimension name=========================================

%fprintf(fid,'\n\ndimension =%d\t\t\n',dimension(i2));
dim=dimension(i2);

%===================Reference Set==========================================
%{
if strcmpi(problem_name(i1,:), 'dtlz1')==1
    a=strcat('Reference Set\ref_dtlz1_',num2str(dim),'.txt');
    Ref=load(a);
elseif strcmpi(problem_name(i1,:), 'dtlz5')==1 ||strcmpi(problem_name(i1,:), 'dtlz6')==1
    a=strcat('Reference Set\ref_dtlz5_',num2str(dim),'.txt');
    Ref=load(a);
elseif strcmpi(problem_name(i1,:), 'dtlz7')==1
    a=strcat('Reference Set\ref_dtlz7_',num2str(dim),'.txt');
    Ref=load(a);
else
    a=strcat('Reference Set\ref_dtlz2_',num2str(dim),'.txt');
    Ref=load(a);
end
%}

%Ref=Ref(1:10000,:);

%{
if strcmpi(problem_name(i1,:), 'dtlz1')==1
    C=Ref+0.2*rand(size(Ref,1),dim); % Here, reference point r=0.7;
else
    C=Ref+0.1*rand(size(Ref,1),dim); % Here, reference point r=1.1;
end
%}
for i3=1:1

a=strcat(algo_name(i3,:),problem_name(i1,:),'_',num2str(dim),'.pf');% a = pwfg2_2.pf

a

fid2 = fopen(a,'r');  % Open text file

InputText=dlmread(a,'\t');

[m,n]=size(InputText);%m=num of row
m
n
j1=1;
r=1;
format long;
while(j1<=m)
    P1=[];
    while j1<=m
        s=InputText{1}(j1);
        b=cell2mat(s);
        if(strcmp(b,'')==false)
            c=[];
            while true
                [str b]= strtok(b);
                if(strcmp(b,'')==true),  break;  end
                v=str2double(str);
                c=cat(2,c,v);
            end
            P1=cat(1,P1,c);
            j1=j1+1;
        else
            j1=j1+1;
            break;
        end     
        if((i3==1 || i3==6) && mod(j1,100)==1 && j1>1)
            break;
        end
    end
    
    %Find Pareto front
    %{
    fN=true(size(P1,1),1);
    for c1=1:size(P1,1)
        f=all(bsxfun(@ge, P1(c1,:), P1),2);
        f=f(c1+1:end);
        f=any(f,1);
        f=~f;   %0 for those which satisfy this condition
        fN(c1)=f;
    end
    P1=P1(fN,:);
    %}
    
%=======================compute metric=====================================


%===============Generational Distance metric (GD)==========================

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
        temp=abs(sqrt(sum(power(P1,2),2))-1);
        GD(r)=mean(temp);
    end
    
    
%===================IGD-metric- Inverse Generational Distance==============

    IGD2=0;
    for i=1:size(Ref,1)
       temp2=bsxfun(@minus,Ref(i,:),P1);
       temp2=power(temp2,2);
       temp2=sum(temp2,2);
       temp2=sqrt(temp2);
       IGD2=IGD2+min(temp2);   
    end
    IGD(r)=IGD2/size(Ref,1);
%==================S-metric or hypervolume measure=========================
%{    
fN=false(size(C,1),1);
    for c1=1:size(C,1)
        f=all(bsxfun(@ge, C(c1,:), P1), 2);
        f=any(f,1);
        fN(c1)=f;
    end
  
    S(r)=sum(fN)/size(fN,1);
    %}
%==========================Space Uniformity (SU metric)====================
%{
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
%}
    clear P1
    r=r+1;
end
   



%S=sort(S,2);
%S=S(1,3:end);


fprintf(fid,'%.6f', mean(GD));
fprintf(fid,'\t%.6f', std(GD));
fprintf(fid,'\t%.6f', median(GD));

%%{
fprintf(fid,'\t%.6f', mean(IGD));
fprintf(fid,'\t%.6f', std(IGD));
fprintf(fid,'\t%.6f', median(IGD));

%{
fprintf(fid,'\t%.6f', mean(S));
fprintf(fid,'\t%.6f', std(S));
fprintf(fid,'\t%.6f', median(S));
%}
%{
fprintf(fid,'\t%.6f', mean(SU));
fprintf(fid,'\t%.6f', std(SU));
fprintf(fid,'\t%.6f', median(SU));
%}
clear GD IGD S SU
%clear SU count P1 P 
%}
fprintf(fid,'\n');
fclose(fid2);
end
%fprintf(fid,'\n\t\t\t\t\t\t\t\t\t\t\t\t');
%fprintf(fid,'\n\t\t\t\t\t\t\t\t\t\t\t\t');
%fprintf(fid,'\n');
end
fprintf(fid,'\n\t\t\t\t\t\t\t\t\t\t\t\t');
fprintf(fid,'\n\t\t\t\t\t\t\t\t\t\t\t\t');
fprintf(fid,'\n');
end
fclose(fid);
f=0;
end
