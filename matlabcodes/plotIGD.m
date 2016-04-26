function s=plotIGD()
    
    dir='E:\Thesis lab experiment documents\abcgenerations\100\';
    
    dim=[5 10 19];
    type='HYPE';
    problem='WFG4';
    
    for i=dim
        ourFile=strcat(dir,'sid',problem,num2str(i),type,'.txt');
        our=load(ourFile);
        color='o';
        if(i==5)color='+';end;
        if(i==10)color='-';end;
        if(i==19)color='o';end;
            
        plot(our,color);
        hold on;
    end
    
    legend('5','10','19');
    
    %{
    zhenanFile=strcat(dir,'zhenan',problem,dim,type,'.txt');
    
    
    our=load(ourFile);
    zhenan=load(zhenanFile);
    

    plot(our,'r');
    hold on;
    plot(zhenan,'g');
    hold off;
    legend('MOEAXXX','FD-NSGAIII');
    %}
end