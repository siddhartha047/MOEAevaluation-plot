function f=attainmentSurfacePlotParallelMedian()

    pfDir='D:\FDEA2016\Codes\pf\perfectWFG\';
    
    genDir='D:\FDEA2016\Codes\abcgenerations\recompileWFG-DTLZ\FDEA\FDEAwfggaussian\2';    
    nsgadir='D:\FDEA2016\Codes\abcgenerations\perfectWFG-DTLZ\perfectNSGAIII';       
    %nsgadir='D:\FDEA2016\Codes\abcgenerations\abcgenerations\perfectWFG-DTLZ\perfectDTLZNSGAIII';       
    hypedir='D:\FDEA2016\Codes\abcgenerations\perfectWFG-DTLZ\perfectHYPEBoundSample';
    %hypedir='D:\FDEA2016\Codes\abcgenerations\perfectWFG-DTLZ\perfectHYPEDTLZBoundSample';
    moeaddir='D:\FDEA2016\Codes\abcgenerations\perfectWFG-DTLZ\perfectMOEAD';
    gde3dir='D:\FDEA2016\Codes\abcgenerations\perfectWFG-DTLZ\perfectGDE3';
    zhenandir='D:\FDEA2016\Codes\abcgenerations\perfectWFG-DTLZ\perfectZhenan';
    piceagdir='D:\FDEA2016\Codes\abcgenerations\recompileWFG-DTLZ\perfectPICEAG';
    sdedir='D:\FDEA2016\Codes\abcgenerations\recompileWFG-DTLZ\perfectSDEwfg';
    
    type='wfg';
    basedon='Ss';
    
    
    
    for i=2:2
        for j=15
            
            
            obj=num2str(j);
            genDir=getmedianresult(strcat(genDir,'\sid',type,num2str(1),obj,'.txt'),basedon)
            nsgadir=getmedianresult(strcat(nsgadir,'\nsgaiii',type,num2str(1),obj,'.txt'),basedon)
            %nsgadir=getmedianresult(strcat(nsgadir,'\nsgaiiiexp',type,num2str(1),obj,'.txt'),basedon)
            hypedir=getmedianresult(strcat(hypedir,'\hype',type,num2str(1),obj,'.txt'),basedon)
            moeaddir=getmedianresult(strcat(moeaddir,'\moead',type,num2str(1),obj,'.txt'),basedon)
            gde3dir=getmedianresult(strcat(gde3dir,'\gde3',type,num2str(1),obj,'.txt'),basedon)
            zhenandir=getmedianresult(strcat(zhenandir,'\zhenan',type,num2str(1),obj,'.txt'),basedon)
            piceagdir=getmedianresult(strcat(piceagdir,'\p',type,num2str(1),obj,'.txt'),basedon)
            sdedir=getmedianresult(strcat(sdedir,'\sde',type,num2str(1),obj,'.txt'),basedon)
            %}
              %{
            pfDir='E:\Thesis lab experiment documents\pf\perfectWFG\';
            genDir='E:\Thesis lab experiment documents\abcgenerations\perfectWFG-DTLZ\perfectMOEAminmax2\0.5\';
            nsgadir='E:\Thesis lab experiment documents\abcgenerations\perfectWFG-DTLZ\perfectNSGAIII\0.5\';    
            %nsgadir='E:\Thesis lab experiment documents\abcgenerations\perfectWFG-DTLZ\perfectDTLZNSGAIII\0.5\';    
            hypedir='E:\Thesis lab experiment documents\abcgenerations\perfectWFG-DTLZ\perfectHYPE\0.5\';
            moeaddir='E:\Thesis lab experiment documents\abcgenerations\perfectWFG-DTLZ\perfectMOEAD\0.5\';
            gde3dir='E:\Thesis lab experiment documents\abcgenerations\perfectWFG-DTLZ\perfectGDE3\0.5\';
            zhenandir='E:\Thesis lab experiment documents\abcgenerations\perfectWFG-DTLZ\perfectZhenan\0.5\';
            %}
            
            wfg= strcat('wfg',num2str(i),'_',num2str(j),'.pf');
            pfFile=strcat(pfDir,wfg);
            ourGenFile=strcat(genDir,'sid',wfg);
            zhenanFile=strcat(zhenandir,'zhenan',wfg);
            nsgafile=strcat(nsgadir,'nsgaiii',wfg);
            hypefile=strcat(hypedir,'hype',wfg);
            moeadfile=strcat(moeaddir,'moead',wfg);
            gde3file=strcat(gde3dir,'gde3',wfg);
            piceagfile=strcat(piceagdir,'p',wfg);
            sdefile=strcat(sdedir,'sde',wfg);

            subplotData(pfFile,ourGenFile,zhenanFile,nsgafile,hypefile,moeadfile,gde3file,piceagfile,sdefile);            
            
        end
    end

    f=0;
end

function s=subplotData(pfFile,ourGenFile,zhenanFile,nsgafile,hypefile,moeadfile,gde3file,piceagfile,sdefile);
    pfData=load(pfFile);
    pfData=pfData(1:500,:);
    
    ourData=load(ourGenFile);
    ourData=getNonDominatedSolution(ourData);
    
    zhenanData=load(zhenanFile);
    zhenanData=getNonDominatedSolution(zhenanData);
    
    nsgadata=load(nsgafile);
    nsgadata=getNonDominatedSolution(nsgadata);
    
    hypedata=load(hypefile);
    hypedata=getNonDominatedSolution(hypedata);
    
    
    moeaddata=load(moeadfile);
    moeaddata=getNonDominatedSolution(moeaddata);
    
    gde3data=load(gde3file);
    gde3data=getNonDominatedSolution(gde3data);
    
    piceagdata=load(piceagfile);
    piceagdata=getNonDominatedSolution(piceagdata);
    
    sdedata=load(sdefile);
    sdedata=getNonDominatedSolution(sdedata);
    
    %plotparallel(pfData);
    %plotparallel(ourData);
    %plotparallel(zhenanData);
    %plotparallel(nsgadata);
    %plotparallel(moeaddata);
    %plotparallel(gde3data);
    %plotparallel(hypedata);
    %plotparallel(piceagdata);
    %plotparallel(sde);
    
    
    
    
end

function setGlobalx(val)
    global x
    x = val;
end

function r = getGlobalx
    global x
    r = x;
end

function plot=plotparallel(ourData) 
    
      position = [ 0 0 500 600];
      set(0, 'DefaultFigurePosition', position);

   

    r=0.025;
    setGlobalx(r);
    

    [sep1, sep2]=separateData(ourData);
    disp(size(sep1));
    disp(size(sep2));

    subplot(3,1,1);
    parallelcoords(sep1,'Color',[1, 0, 0],'LineWidth',1);
    xlabel('Objective No');
    ylabel('Objective Value');
    title('Solutions with normalized distance threshold <= 0.025');    
    
    subplot(3,1,2);
    parallelcoords(sep2,'Color',[0.1922,0.3255,0.6431],'LineWidth',1);    
    xlabel('Objective No');
    ylabel('Objective Value');
    title('Solutions with normalized distance threshold > 0.025');
    
    subplot(3,1,3);
    parallelcoords(sep2,'Color',[0.1922,0.3255,0.6431],'LineWidth',1);    
    xlabel('Objective No');
    ylabel('Objective Value');
    title('Zoomed Solutions with normalized distance threshold > 0.025');
    
    
    
%   parallelcoords(ourData,'Color',[0.1922,0.3255,0.6431],'LineWidth',1);
end

function norm=normal(I,b)
    
    norm=I./b;
    %norm = (I-min(I(:))) ./ (max(I(:)-min(I(:))));
end

function [sep1, sep2]=separateData(ourData)
    
    [r,c]=size(ourData);
    normData=zeros(r,c);
    b=getbounds('wfg',4,c);
    for i=1:c
        normData(1:r,i)=normal(ourData(1:r,i),b(1,i));
    end
    
    [sep1, sep2]=spilitData(normData,ourData);
end

function v=evaluate(data)
    
    [r,c]=size(data);
    
    v=-1;
    
    for  i=1:c
        v=v+data(1,i)^2;
    end

    if v<=getGlobalx
        v=0;
    end
end


function [sep1, sep2]=spilitData(ourData,mainData)
    %a= [b;a];
    [r,c]=size(ourData);
    sep1=[];
    sep2=[];
    for i=1:r
        data=ourData(i,:);
        main=mainData(i,:);
        if evaluate(data)==0
            sep1=[sep1;main];
        else
            sep2=[sep2;main];
        end
    end

end

