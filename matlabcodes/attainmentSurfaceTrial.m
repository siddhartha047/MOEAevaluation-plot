function f=attainmentSurfaceTrial()
     
    pfDir='E:\Thesis lab experiment documents\pf\perfectWFG\';
    %pfDir='E:\Thesis lab experiment documents\pf\perfectDTLZ\';
    
    
    i=4;
    type='wfg';
    %type='DTLZ';
    basedon='Ss';
    
    
    genDir='E:\Thesis lab experiment documents\abcgenerations\perfectWFG-DTLZ\perfectMOEAminmax2';    
    nsgadir='E:\Thesis lab experiment documents\abcgenerations\perfectWFG-DTLZ\perfectNSGAIII';       
    %nsgadir='E:\Thesis lab experiment documents\abcgenerations\perfectWFG-DTLZ\perfectDTLZNSGAIII\';          
    hypedir='E:\Thesis lab experiment documents\abcgenerations\perfectWFG-DTLZ\perfectHYPEBoundSample';
    %hypedir='E:\Thesis lab experiment documents\abcgenerations\perfectWFG-DTLZ\perfectHYPE\';
    moeaddir='E:\Thesis lab experiment documents\abcgenerations\perfectWFG-DTLZ\perfectMOEAD';
    gde3dir='E:\Thesis lab experiment documents\abcgenerations\perfectWFG-DTLZ\perfectGDE3';
    zhenandir='E:\Thesis lab experiment documents\abcgenerations\perfectWFG-DTLZ\perfectZhenan';
    
    genDir=getmedianresult(strcat(genDir,'\sid',type,num2str(1),'3.txt'),basedon)
    nsgadir=getmedianresult(strcat(nsgadir,'\nsgaiii',type,num2str(1),'3.txt'),basedon)
    %nsgadir=getmedianresult(strcat(nsgadir,'\nsgaiiiexp',type,num2str(1),'3.txt'),basedon)
    hypedir=getmedianresult(strcat(hypedir,'\hype',type,num2str(1),'3.txt'),basedon)    
    moeaddir=getmedianresult(strcat(moeaddir,'\moead',type,num2str(1),'3.txt'),basedon)
    gde3dir=getmedianresult(strcat(gde3dir,'\gde3',type,num2str(1),'3.txt'),basedon)
    zhenandir=getmedianresult(strcat(zhenandir,'\zhenan',type,num2str(1),'3.txt'),basedon)
    
    
    wfg=strcat(type,num2str(i),'_3.pf')
    nsgaiiiwfg= wfg;
    %nsgaiiiwfg= strcat('exp',type,num2str(i),'(3).ini.pf')
    pfFile=strcat(pfDir,type,num2str(i),'_3.pf')
    ourGenFile=strcat(genDir,'sid',wfg)
    zhenanFile=strcat(zhenandir,'zhenan',wfg)
    nsgafile=strcat(nsgadir,'nsgaiii',nsgaiiiwfg)
    hypefile=strcat(hypedir,'hype',wfg)
    moeadfile=strcat(moeaddir,'moead',wfg)
    gde3file=strcat(gde3dir,'gde3',wfg)

    
    %subplotData(pfFile,ourGenFile,zhenanFile,nsgafile,hypefile,moeadfile,gde3file);
    subplotData(pfFile,gde3file);
    
    
   
    f=0;
end

function s=subplotData(pfFile,ourGenFile)

    position = [ 400 200 500 400];
    set(0, 'DefaultFigurePosition', position);
      
    pfData=load(pfFile);      
    pfData=pfData(1:5000,:);
   % pfData=getNonDominatedSolution(pfData);
    
    ourData=load(ourGenFile);
    ourData=getNonDominatedSolution(ourData);
    
    drawLine(pfData,'r','*');    
    hold on;
    
    [r,c]=size(ourData);   
    
    b=getbounds('wfg',4,c);
    for i=1:c
        ourData(1:r,i)=normal(ourData(1:r,i),b(1,i));
    end
    
    [sep1, sep2]=spilitData(ourData);
    
    disp(size(sep1));
    disp(size(sep2));
    
    if isempty(sep1)==0
        drawScatter2(sep1,'r','d');  
        hold on;
    end
    if isempty(sep2)==0 
        drawScatter1(sep2,'b','o');                
    end
    
    
    xlabel('f1');
    ylabel('f2','Rotation',0);
    zlabel('f3','Rotation',0);    
    hold off;     
end

function v=evaluate(data)
    
    [r,c]=size(data);
    
    v=-1;
    
    for  i=1:c
        v=v+data(1,i)^2;
    end

    if v<0.025
        v=0;
    end
end

function [sep1, sep2]=spilitData(ourData)
    %a= [b;a];
    [r,c]=size(ourData);
    sep1=[];
    sep2=[];
    for i=1:r
        data=ourData(i,:);
        if evaluate(data)==0
            sep1=[sep1;data];
        else
            sep2=[sep2;data];
        end
    end

end

function s=drawScatter1(pfData,color,marker)
    
    [row,col]=size(pfData);
    pfX=pfData(1:row,1);
    pfY=pfData(1:row,2);
    pfZ=pfData(1:row,3);
    s=scatter3(pfX,pfY,pfZ,color,marker,'MarkerEdgeColor',[0 0 0],'MarkerFaceColor',[.5 .5 .5]);
    
end

function s=drawScatter2(pfData,color,marker)
    
    [row,col]=size(pfData);
    pfX=pfData(1:row,1);
    pfY=pfData(1:row,2);
    pfZ=pfData(1:row,3);
    s=scatter3(pfX,pfY,pfZ,color,marker,'MarkerEdgeColor',[0 0 0],'MarkerFaceColor',[1 0 0]);
    
end



function norm=normal(I,b)
    norm = I./b;
end

function s=drawLine(pfData,color,alpha)
   
    f = 'x^2+y^2+z^2-1'; 
    s=ezimplot3(f,[0 1 0 1 0 1])
    hold on;
   
end