function s=continusPlot()
    
    dir='E:\Thesis lab experiment documents\abcgenerations\perfectWFG-DTLZ\generationwise\perfectMOEAgen\';
    
    type='HYPE';
    problem='WFG6';
    
    objNo=[2 3 5 7 10 12 15 20];
    color=['y';'m';'c';'r';'g';'b';'g';'k'];   
   % marker=['+';'o';'*';'\.';'x';'s';'d';'^';'v';'>';'<';'p';'n'];
    marker=['o';'p';'h';'s';'d';'v';'>';'<'];
    
    gen=0:10:240;
    
    cnt=1;
    
    for i=objNo
        dim=i;
        ourFile=strcat(dir,'sid',problem,num2str(dim),type,'.txt');
        our=load(ourFile);        
        plot(gen,our,color(cnt,1),'Marker',marker(cnt,1),'MarkerFaceColor',color(cnt,1));
        %plot(gen,our,color(cnt,1),'Marker',marker(cnt,1));
        hold on;                       
        cnt=cnt+1;
    end 
    
    xlabel('Generation');
    ylabel('HV');
    
    hold off;    
    legend('m = 2','m = 3','m = 5','m = 7','m = 10','m = 12','m = 15','m = 20');
    
    s=0;
end