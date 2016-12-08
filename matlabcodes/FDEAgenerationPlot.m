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
    ourData=getNonDominatedSolution(ourData);

   % drawScatter(pfData,'r','*');
    figure
    hold on;
    drawScatter(ourData,'r','*');    
    hold off;

end

function s=drawScatter(pfData,color,marker)
    
    [row,col]=size(pfData);
    pfX=pfData(1:row,1);
    pfY=pfData(1:row,2);
    s=scatter(pfX,pfY,color,marker);
    
    for k=1:row
      text(pfX(k),pfY(k),['   (' num2str(pfX(k),'%0.2f') ',' num2str(pfY(k),'%0.2f') ')'])
    end
    
    % axis([min(pfX),max(pfX),min(pfY),max(pfY)]); % axis([xmin, xmax, ymin, ymax])
    axis([0,1.25,0,1.25]); % axis([xmin, xmax, ymin, ymax])
    xlabel('f_1');
    ylabel('f_2','Rotation',0);
    legend(['*'],{'Solutions'});
    
    %{
    [row,col]=size(pfData);
    pfX=pfData(1:row,1);
    pfY=pfData(1:row,2);
    
    fit=[0.1840    0.3280    0.4840    0.6160    0.6830    0.7050    0.7050    0.6830    0.6160    0.4840    0.3280    0.1840];
    [pData,qData]=separate(pfData,fit,6)
    %s=scatter(pfX,pfY,color,marker);
    
    
     
    
    for k=1:row
      text(pfX(k),pfY(k),['   (' num2str(fit(1,k),'%0.3f') ')'])
    end
    
    axis([0,1.25,0,1.25]); % axis([xmin, xmax, ymin, ymax])
    xlabel('f_1');
    ylabel('f_2','Rotation',0);
    legend(['*'],{'Solutions'});
    
    %}

    
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




