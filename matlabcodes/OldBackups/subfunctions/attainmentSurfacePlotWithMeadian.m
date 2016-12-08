function f=attainmentSurfacePlotWithMedian()

  
    %pfDir='E:\Thesis lab experiment documents\pf\perfectWFG\';
    pfDir='E:\Thesis lab experiment documents\pf\perfectDTLZ\';
    
    
    i=7;
    %type='wfg';
    type='DTLZ';
    basedon='Ss';
    
    
    genDir='E:\Thesis lab experiment documents\abcgenerations\perfectWFG-DTLZ\perfectMOEAminmax2\';    
    %nsgadir='E:\Thesis lab experiment documents\abcgenerations\perfectWFG-DTLZ\perfectNSGAIII\';       
    nsgadir='E:\Thesis lab experiment documents\abcgenerations\perfectWFG-DTLZ\perfectDTLZNSGAIII\';       
    %hypedir='E:\Thesis lab experiment documents\abcgenerations\perfectWFG-DTLZ\perfectHYPE\';
    hypedir='E:\Thesis lab experiment documents\abcgenerations\perfectWFG-DTLZ\perfectHYPEDTLZBoundSample\';
    moeaddir='E:\Thesis lab experiment documents\abcgenerations\perfectWFG-DTLZ\perfectMOEAD\';
    gde3dir='E:\Thesis lab experiment documents\abcgenerations\perfectWFG-DTLZ\perfectGDE3\';
    zhenandir='E:\Thesis lab experiment documents\abcgenerations\perfectWFG-DTLZ\perfectZhenan\';
    
    genDir=getmedianresult(strcat(genDir,'\sid',type,num2str(1),'2.txt'),basedon)
    %nsgadir=getmedianresult(strcat(nsgadir,'\nsgaiii',type,num2str(1),'2.txt'),basedon)
    nsgadir=getmedianresult(strcat(nsgadir,'\nsgaiiiexp',type,num2str(1),'2.txt'),basedon)
    hypedir=getmedianresult(strcat(hypedir,'\hype',type,num2str(1),'2.txt'),basedon)
    moeaddir=getmedianresult(strcat(moeaddir,'\moead',type,num2str(1),'2.txt'),basedon)
    gde3dir=getmedianresult(strcat(gde3dir,'\gde3',type,num2str(1),'2.txt'),basedon)
    zhenandir=getmedianresult(strcat(zhenandir,'\zhenan',type,num2str(1),'2.txt'),basedon)
    
    
    wfg= strcat(type,num2str(i),'_2.pf')
   % nsgaiiiwfg= wfg;
    nsgaiiiwfg= strcat('exp',type,num2str(i),'(2).ini.pf')
    pfFile=strcat(pfDir,type,num2str(i),'_2D.pf')
    ourGenFile=strcat(genDir,'sid',wfg)
    zhenanFile=strcat(zhenandir,'zhenan',wfg)
    nsgafile=strcat(nsgadir,'nsgaiii',nsgaiiiwfg)
    hypefile=strcat(hypedir,'hype',wfg)
    moeadfile=strcat(moeaddir,'moead',wfg)
    gde3file=strcat(gde3dir,'gde3',wfg)

    subplotData(pfFile,ourGenFile,zhenanFile,nsgafile,hypefile,moeadfile,gde3file);

    
    
   %}
    %{   
    for i=[3]
        dtlz= strcat('DTLZ',num2str(i),'_2D.pf');
        dtlzns= strcat('DTLZ',num2str(i),'(2).ini.pf');
        dtlzpf=strcat('DTLZ',num2str(i),'_2.pf');
        pfFile=strcat(pfDir,dtlz);
        ourGenFile=strcat(genDir,'sid',dtlzpf);
        zhenanFile=strcat(zhenandir,'zhenan',dtlzpf);       
        nsgafile=strcat(nsgadir,'nsgaiiiexp',dtlzns);
        hypefile=strcat(hypedir,'hype',dtlzpf);
        moeadfile=strcat(moeaddir,'moead',dtlzpf);
        gde3file=strcat(gde3dir,'gde3',dtlzpf);
        
      %  subplot(2,2,plotin);
        subplotData(pfFile,ourGenFile,zhenanFile,nsgafile,hypefile,moeadfile,gde3file);
        plotin=plotin+1;
    end
    %}
    
    f=0
end

function s=subplotData(pfFile,ourGenFile,zhenanFile,nsgafile,hypefile,moeadfile,gde3file);
    pfData=load(pfFile);
    pfData=pfData(1:3000,:);
    
    %pfData=getNonDominatedSolution(pfData);
    
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
    
    drawScatter(pfData,'r','*');
    hold on;
    drawScatter(ourData,'b','+');    
    drawScatterzhenan(zhenanData, 'k','v');    
    drawScatterzhenan(nsgadata, 'g','x');
    drawScatterzhenan(hypedata, 'm','d');
    drawScatterzhenan(moeaddata, 'y','s');
    drawScatterzhenan(gde3data, 'c','p');
    
    xlabel('f1');
    ylabel('f2','Rotation',0);
    legend(['*' '+' 'v','x','d','s','p'],{'True PF','F-DEA','FD-NSGAII','NSGAIII','HypE','MOEA/D','GDE3'});
    hold off; 

end

function s=drawScatter(pfData,color,marker)
    
    [row,col]=size(pfData);
    pfX=pfData(1:row,1);
    pfY=pfData(1:row,2);
    s=scatter(pfX,pfY,color,marker);
    
end


function s=drawScatterzhenan(pfData,color,marker)
    
    [row,col]=size(pfData);
    pfX=pfData(1:row,1);
    pfY=pfData(1:row,2);
    s=scatter(pfX,pfY,color,marker);
    
end

function s=drawScatternsga(pfData,color,marker)
    
    [row,col]=size(pfData);
    pfX=pfData(1:row,1);
    pfY=pfData(1:row,2);
    s=scatter(pfX,pfY,color,marker,'filled');
    
end







