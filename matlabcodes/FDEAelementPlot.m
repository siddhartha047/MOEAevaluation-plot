function f=FDEAgenerationPlot()

directory='D:\FDEA2016\Codes\abcgenerations\recompileWFG-DTLZ\FDEA\backups\10real\2\0.05'
%directory='D:\FDEA2016\Codes\abcgenerations\recompileWFG-DTLZ\perfectSDEwfg\0.05\';

paretoDirectory='D:\FDEA2016\Codes\NSGAIII\DTLZfront\DTLZfront\PF\dtlzuniform';

algoName='2d';
problemName='linear';
dim=2;
problem=1;

paretoFileName=strcat(paretoDirectory,'\',problemName,num2str(problem),'_',num2str(dim),'.pf');
fileName=strcat(directory,'\',algoName,problemName,num2str(problem),'_',num2str(dim),'.pf');

position = [ 400 0 400 400];
set(0, 'DefaultFigurePosition', position);

display(paretoFileName);
display(fileName);

drawFinalGeneration(paretoFileName,fileName);
%drawProgress(paretoFileName,fileName,250);

    
f=0;

end

function s=drawFinalGeneration(paretoFileName,fileName)

    %pfData=load(paretoFileName);
    %pfData=pfData(1:2000,:);
    %pfData=getNonDominatedSolution(pfData);

    ourData=load(fileName);
    %ourData=getNonDominatedSolution(ourData);

   % drawScatter(pfData,'r','*');
    figure
    hold on;
    drawScatter(ourData,'r','s');    
    hold off;

end

function s=drawScatter(pfData,color,marker)

    %%Reference Point array
    
    %refpoint='D:\FDEA2016\Codes\abcgenerations\recompileWFG-DTLZ\FDEA\backups\10real\2\0.05\2referencepoints.ref';
    refpoint='D:\FDEA2016\Codes\abcgenerations\recompileWFG-DTLZ\FDEA\backups\10real\2\0.05\2reducedPoints.ref';
    refpoints=load(refpoint);
       %{
    for i=1:size(refpoints,1)
        
        plot_arrow( 0,0,1.8*refpoints(i,1),1.8*refpoints(i,2),'linewidth',1.25,'headwidth',0.02,'headheight',0.03 );         
    end
    %}

    %%all
    
   
    
    
    hold on;
    [row,col]=size(pfData);
    pfX=pfData(1:row,1);
    pfY=pfData(1:row,2);
   
    scatter(pfData(row:row,1),pfData(row:row,2),'r','s','filled');
    scatter(pfData(8:8,1),pfData(8:8,2),'b','d','filled');
    
    for i=1:row-1
        if i==8
            continue;
        end
        scatter(pfData(i:i,1),pfData(i:i,2),'b','d','filled');
    end
    legend(['s','d'],{'Selected solutions','Unseleted solutions'});
    %}
   %scatter(pfX,pfY,'b','o','filled');
    
    
    %s=scatter(refpoints(:,1),refpoints(:,2),'k','*');
    %}
    %{
    for k=1:row
      text(pfX(k),pfY(k),['   (' num2str(pfX(k),'%0.2f') ',' num2str(pfY(k),'%0.2f') ')'])
    end
    %}
    
    % axis([min(pfX),max(pfX),min(pfY),max(pfY)]); % axis([xmin, xmax, ymin, ymax])
    axis([0,1.4,0,1.4]); % axis([xmin, xmax, ymin, ymax])
    xlabel('f_1');
    ylabel('f_2','Rotation',0);
   % legend(['o','*'],{'Solutions','Cluster Centroid'});
   
    Kcl=6;
   
    figure
    
    [idx,C] = kmeans(pfData,Kcl)
    
    hold on;
    for i=1:Kcl
        scatter(pfData(idx==i,1),pfData(idx==i,2),'filled');
    end
    scatter(C(:,1),C(:,2),'*');
     axis([0,1.4,0,1.4]);
    %}
    figure
    [idx,C] = kmeans(pfData,Kcl,'Distance', 'cosine');
    hold on;
    for i=1:Kcl
        scatter(pfData(idx==i,1),pfData(idx==i,2),'filled');
    end
    scatter(C(:,1),C(:,2),'*');
     axis([0,1.4,0,1.4]);
    
    %%split 
    figure
    
    
    [row,col]=size(pfData);
    pfX=pfData(1:row,1);
    pfY=pfData(1:row,2);
    
    %concave
    %fit=[0.1840    0.3280    0.4840    0.6160    0.6830    0.7050    0.7050    0.6830    0.6160    0.4840    0.3280    0.1840];
    
    %convex
    %fit=[0.8160    0.6720    0.5160    0.3840    0.3170    0.2950    0.2950     0.3170    0.3840    0.5160    0.6720    0.8160];
    
    %line
    %fit=[ 0.499999 0.500008 0.499999 0.499999 0.499999 0.499998 0.499998 0.499998 0.499998 0.499998 0.499998 0.500008];
    
    %two concave
    %fit=[ 0.1733 0.2742 0.3927 0.4964 0.5721 0.6136 0.6136 0.5721 0.4964 0.3927 0.2742 0.1733 0.2732 0.4567 0.5935 0.6808 0.7287 0.7448 0.7448 0.7287 0.6808 0.5935 0.4567 0.2732]; 
    hold on;
    fitnessFile='D:\FDEA2016\Codes\abcgenerations\recompileWFG-DTLZ\FDEA\backups\10real\2\0.05\2dfitnessval.sol';
    fit= load(fitnessFile);
    fit=fit';
    
    
    for i=1:size(pfData,1)
        if pfData(i,1)>0 && pfData(i,2)>0
           %rectangle('position',[0 0 pfData(i,1) pfData(i,2)]);
        end
    end
    
    

    %two concave modi    
    [pData,qData]=separate(pfData,fit,size(fit,2)/2);
    
    
   
    [pr,pc]=size(pData);
    pX=pData(1:pr,1);
    pY=pData(1:pr,2);
    ps=scatter(pX,pY,'r','s','filled');
    
    [qr,qc]=size(qData)
    qX=qData(1:qr,1);
    qY=qData(1:qr,2);
    qs=scatter(qX,qY,'b','d','filled');
    %}
       
   %{
    for k=1:row
      text(pfX(k),pfY(k),['   (' num2str(fit(1,k),'%0.3f') ')'])
    end
    %}
    %{
    for k=1:row
      text(pfX(k),pfY(k),['   (' num2str(pfX(k),'%0.2f') ',' num2str(pfY(k),'%0.2f') ')'])
    end
    %}
    axis([0 1.4 0 1.4]); 
    % axis([xmin, xmax, ymin, ymax])
    xlabel('f_1');
    ylabel('f_2','Rotation',0);
    legend(['s','*'],{'Selected solutions','Unseleted solutions'});
    
    intercept=   -1.270761568431922;
   % intercept=-0.880890850973281;
    
     
    for i=1:size(pfData,1)
        x1=pfData(i,1)
        y1=pfData(i,2);
        
        yneed=y1+intercept*(-x1);
        xneed=x1+(-y1)/(intercept);        
        %line([xneed 0],[0,yneed],'LineWidth',1);
        
    end
    %}
    
    %}
    hold off;
    
end

function [pData,qData]=separate(pfData,fit,count)
    [row, col]=size(pfData);
    cnt=0;
    mark=zeros(1,row);
    indexs=zeros(1,count);
    while cnt<count        
        maxValue=1000;
        index=-1;
        
        for i=1:row
            if fit(1,i)<maxValue && mark(1,i)==0
                maxValue=fit(1,i);
                index=i;
            end
        end
        
        cnt=cnt+1;
        mark(1,index)=1;        
    end
    pData=[];
    qData=[];
    for i=1:row
        if mark(1,i)==1
            pData=[pData;pfData(i,:)];
        else
            qData=[qData;pfData(i,:)];
        end
        
    end
    
end

function s=drawProgress(paretoFileName,fileName,maxGen)

    pfData=load(paretoFileName);
    %pfData=pfData(1:2000,:);
    %pfData=getNonDominatedSolution(pfData);

        
    
    for i=0:maxGen-2
        genFile=strcat(fileName,num2str(i))
        ourData=load(genFile);
        ourData=getNonDominatedSolution(ourData);  
        
        drawScatter(pfData,'r','*');
        hold on;
        
        drawScatter(ourData,'b','+');
        hold off;
        
        pause(0.01);
        
    end
    
    ourData=load(fileName);
    ourData=getNonDominatedSolution(ourData);        
    drawScatter(ourData,'b','+');    
    hold off;

end




