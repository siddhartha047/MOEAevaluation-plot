function f=attainmentSurfacePlot()

    %{

    pfDir='E:\Thesis lab experiment documents\pf\RefMx300\dtlzlakh\';
    %pfDir='E:\Thesis lab experiment documents\algorithm\nsgaIII\nsgaIII\PF\';
    %genDir='E:\Thesis lab experiment documents\abcgenerations\100\0.5\';
    genDir='E:\Thesis lab experiment documents\abcgenerations\100\0.5\';
    %nsgadir='E:\Thesis lab experiment documents\algorithm\nsgaIII\generations\0.5\';
    nsgadir='E:\Thesis lab experiment documents\algorithm\nsgaIII\generations\0.5\';
    hypedir='E:\Thesis lab experiment documents\MOEAFramework-2.1 - Copy\hypeGenerations\0.5\';
    moeaddir='E:\Thesis lab experiment documents\MOEAFramework-2.1 - Copy\moeadGenerations\0.5\';
    gde3dir='E:\Thesis lab experiment documents\abcgenerations\sbx30\0.5\';
    %}

    
    pfDir='E:\Thesis lab experiment documents\pf\perfectWFG\';
    %pfDir='E:\Thesis lab experiment documents\pf\perfectDTLZ\';
    %genDir='E:\Thesis lab experiment documents\abcgenerations\perfectWFG-DTLZ\perfectMOEAminmax2\0.5\';
    genDir='E:\Thesis lab experiment documents\abcgenerations\perfectWFG-DTLZ\Analysis\0.5\';
    nsgadir='E:\Thesis lab experiment documents\abcgenerations\perfectWFG-DTLZ\perfectNSGAIII\0.5\';    
   % nsgadir='E:\Thesis lab experiment documents\abcgenerations\perfectWFG-DTLZ\perfectDTLZNSGAIII\0.5\';    
    hypedir='E:\Thesis lab experiment documents\abcgenerations\perfectWFG-DTLZ\CorrectGDIGDHYPE\perfectHYPEBoundSample\0.1\';
    moeaddir='E:\Thesis lab experiment documents\abcgenerations\perfectWFG-DTLZ\perfectMOEAD\0.5\';
    gde3dir='E:\Thesis lab experiment documents\abcgenerations\perfectWFG-DTLZ\perfectGDE3\0.5\';
    zhenandir='E:\Thesis lab experiment documents\abcgenerations\perfectWFG-DTLZ\perfectZhenan\0.5\';
    
    plotin=1;
   
    for i=6:6
        wfg= strcat('wfg',num2str(i),'_2.pf');
        pfFile=strcat(pfDir,wfg);
        ourGenFile=strcat(genDir,'sid',wfg);
        zhenanFile=strcat(zhenandir,'zhenan',wfg);
        nsgafile=strcat(nsgadir,'nsgaiii',wfg);
        hypefile=strcat(hypedir,'hype',wfg);
        moeadfile=strcat(moeaddir,'moead',wfg);
        gde3file=strcat(gde3dir,'gde3',wfg);
        
        
       %subplot(2,2,plotin);
        subplotData(pfFile,ourGenFile,zhenanFile,nsgafile,hypefile,moeadfile,gde3file);
        plotin=plotin+1;
        %magnifyOnFigure;
    end
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
    pfData=pfData(1:2000,:);
    
   % pfData=getNonDominatedSolution(pfData);
    
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
    legend(['*' '+' 'v','x','d','s','p'],{'True front','MOEAxxx','FD-nsgaII','nsgaiii','hype','moead','gde3'});
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







