function f=parametersensitivityplot()
    
    position = [ 400 0 600 350];
    set(0, 'DefaultFigurePosition', position);


    dir='E:\Thesis lab experiment documents\abcgenerations\perfectWFG-DTLZ\Analysis\estimatingbestK\15\';
    %folder=['2g';'3g';'4g';'5g';'6g';'7g';'8g';'9g'];
    %folder=['02g';'03g';'04g';'05g';'06g';'07g';'08g';'09g';'10g'];
    %folder=['2g';'3g';'4g';'5g'];
    folder=['2g';'3g';'4g';'5g';'6g';'7g'];
    onAvg=[2 3 4 5 6 7 8 9 10];
    
    [fr,fc]=size(folder);
    [ar,ac]=size(onAvg);
    
    data=zeros(fr,ac);
    
    problem='sidwfg615.txt'
    type='HYP';
    
    
    for i=1:fr
       fold=folder(i,:); 
       for j=1:ac
           av=onAvg(1,j);           
           prbdir=strcat(dir,fold,'\',num2str(av),'\',problem);
           disp(prbdir);
           result=getperformanceData(prbdir,type);
           
           data(i,j)=result(1,1);
           
           
           
       end
    end
    format short;
    
    data
    
    color=['y';'m';'c';'r';'g';'b';'r';'k';'g';'m'];   
    marker=['s';'o';'*';'.';'x';'+';'d';'^';'v';'>';'<';'p';'n'];
    xax=[2 3 4 5 6 7 8 9 10]
    
    cnt=1;
    
    for i=1:fr        
        plot(xax,data(i,:),color(i,1),'Marker',marker(i,1),'MarkerFaceColor',color(i,1));
        hold on;                       
        cnt=cnt+1;
    end 
    
    legend('\lambda=2','\lambda=3','\lambda=4','\lambda=5','\lambda=6','\lambda=7','\lambda=8','\lambda=9','\lambda=10');
    hold off;    
    
    xlabel('Expected number of solutions in a cluster, \it{\chi = 2N/p}');
    ylabel('Hypervolume (HV)');
    f=0;
    fclose('all');
end