function f=FDEArectanglePlot()


%fileName='D:\FDEA2016\Codes\abcgenerations\recompileWFG-DTLZ\FDEA\specialProblem\paretoBox\2\0.05\RecInstanceI_4.pfvar';
%fileName='D:\FDEA2016\Codes\abcgenerations\recompileWFG-DTLZ\FDEA\specialProblem\paretoBox\2\0.5\0.5\SDERecInstanceIII_4';
fileName='D:\FDEA2016\Codes\abcgenerations\recompileWFG-DTLZ\FDEA\specialProblem\paretoBox\2\0.05\NSGAIIIRecInstanceII_4.pf';
figure;
display(fileName);
position = [ 400 0 400 300];
drawFinalGeneration(fileName);
    
f=0;

end

function s=drawFinalGeneration(fileName)

    ourData=load(fileName);
%   ourData=getNonDominatedSolution(ourData);

   %drawScatter(pfData,'r','*');
    hold on;
    drawScatter(ourData,'r','o');    
    hold off;

end

function s=drawScatter(pfData,color,marker)
    
    [row,col]=size(pfData);
    pfX=pfData(1:row,1);
    pfY=pfData(1:row,2);
    s=scatter(pfX,pfY,color,marker,'MarkerEdgeColor',[0 0 0],'MarkerFaceColor',[1 0 0]);    
    
    %axis([min(pfX),max(pfX),min(pfY),max(pfY)]); % axis([xmin, xmax, ymin, ymax])
    %axis([-20,120,-20,120]); % axis([xmin, xmax, ymin, ymax])
    
    rectangle('Position',[0 0 100 100]);
    xlabel('x_1');
    ylabel('x_2','Rotation',0);
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

