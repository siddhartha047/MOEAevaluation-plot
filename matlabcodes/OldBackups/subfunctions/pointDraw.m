function f=pointDraw()

    %reffile='E:\Thesis lab experiment documents\abcgenerations\perfectWFG-DTLZ\Analysis\estimatingbestK\3\050g\2\0.5\referencepoints.ref';
    %reffile='E:\Thesis lab experiment documents\abcgenerations\perfectWFG-DTLZ\Analysis\estimatingbestK\3\050g\2\0.5\activePoints.ref';
    %reffile='E:\Thesis lab experiment documents\abcgenerations\perfectWFG-DTLZ\Analysis\estimatingbestK\3\050g\2\0.5\reducedPoints.ref';
    %reffile='E:\Thesis lab experiment documents\abcgenerations\perfectWFG-DTLZ\Analysis\estimatingbestK\3\050g\2\0.5\solutions.sol';
    reffile ='E:\Thesis lab experiment documents\abcgenerations\perfectWFG-DTLZ\Analysis\estimatingbestK\3\050g\2\0.5\finalsolution.sol';
    
    a= load(reffile);
    %{   
        hold on;    
        drawLine();        
        [r,c]=size(a);       
        b=getbounds('wfg',4,c);
        for i=1:c
            a(1:r,i)=normal(a(1:r,i),b(1,i));
        end
    %}        
    [m,n]=size(a);
    x=a(1:m,1);
    y=a(1:m,2);
    z=a(1:m,3);
    
    scatter3(x,y,z,'b','o','MarkerEdgeColor',[0 0 0],'MarkerFaceColor',[0.5 0.5 0.5]);
    %scatter3(x,y,z,'b','o','MarkerEdgeColor',[0 0 0],'MarkerFaceColor',[1 0 0]);
    grid off;
    
    view([80,20]);           
    xlabel('f_1');
    ylabel('f_2','Rotation',0);
    zlabel('f_3','Rotation',0);    
end

function norm=normal(I,b)
    norm = I./b;
end

function s=drawLine()   
    f = 'x^2+y^2+z^2-1'; 
    s=ezimplot3(f,[0 1 0 1 0 1])
    hold on;   
end

function s=drawplane()   
    f = 'x+y+z-1'; 
    s=ezimplot3(f,[0 1 0 1 0 1])
    hold on;   
end