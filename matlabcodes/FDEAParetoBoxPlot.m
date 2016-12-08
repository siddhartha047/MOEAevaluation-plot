function f=FDEAParetoBoxPlot()


fileName='D:\FDEA2016\Codes\abcgenerations\recompileWFG-DTLZ\FDEA\specialProblem\paretoBox\2\0.5\ParetoBoxProblem_10.pfvar';
figure;
display(fileName);

drawFinalGeneration(fileName);
    
f=0;

end

function s=drawFinalGeneration(fileName)

    ourData=load(fileName);
%    ourData=getNonDominatedSolution(ourData);

   %drawScatter(pfData,'r','*');
    hold on;
    drawScatter(ourData,'b','o');    
    hold off;

end

function s=drawScatter(pfData,color,marker)
    
    [row,col]=size(pfData);
    pfX=pfData(1:row,1);
    pfY=pfData(1:row,2);
    s=scatter(pfX,pfY,color,marker,'filled');
    
    axis([min(pfX),max(pfX),min(pfY),max(pfY)]); % axis([xmin, xmax, ymin, ymax])
    %axis([-150,150,-150,150]); % axis([xmin, xmax, ymin, ymax])
    
    %%rectangle('Position',[0 0 100 100]);
    
    xpoints=[18,30,50,70,80,80,70,50,30,18,18];
    ypoints=[38,20,12,20,38,62,80,88,80,62,38];
    line(xpoints,ypoints);
    
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

