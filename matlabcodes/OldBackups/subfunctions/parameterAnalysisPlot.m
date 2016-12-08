function f=parametersensitivityplot()
    
    dir='E:\Thesis lab experiment documents\abcgenerations\perfectWFG-DTLZ\Analysis\estimatingbestK\3\';
    %folder=['2g';'3g';'4g';'5g';'6g';'7g';'8g';'9g'];
    %folder=['0204g';'0500g';'0750g';'1000g';'2000g';];
    folder=['050g';'100g';'125g';'150g';'200g'];
    onAvg=[2];
    
    [fr,fc]=size(folder);
    [ar,ac]=size(onAvg);
    
    data=zeros(fr,ac);
    
    problem='sidwfg93.txt'
    type='HYP';
    
    
    for i=1:fr
       fold=folder(i,:); 
       for j=1:ac
           av=onAvg(1,j);           
           prbdir=strcat(dir,fold,'\',num2str(av),'\',problem);
           
           result=getperformanceData(prbdir,type);
           
           data(i,j)=result(1,1);
           
           %disp(prbdir);
           
       end
    end
    format short;
    
    data
    
    color=['y';'m';'c';'r';'g';'b';'r';'k'];   
    marker=['s';'o';'*';'.';'x';'+';'d';'^';'v';'>';'<';'p';'n'];
    xax=[2 3 5 7 10 12 15 20 ]
    
    cnt=1;
    
    for i=1:fr        
        plot(xax,data(i,:),color(i,1),'Marker',marker(i,1),'MarkerFaceColor',color(i,1));
        hold on;                       
        cnt=cnt+1;
    end 
    legend
    %legend('p=2','p=3','p=4','p=5','p=6','p=7','p=8','p=9');
    hold off;    
    

    f=0;
end