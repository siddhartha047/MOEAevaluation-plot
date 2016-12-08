function s=plothype()
    
    dir='E:\Thesis lab experiment documents\abcgenerations\100\';
    
    dim='19';
    type='GD';
    problem='WFG4';
    ourFile=strcat(dir,'sid',problem,dim,type,'.txt');
    zhenanFile=strcat(dir,'zhenan',problem,dim,type,'.txt');
    
    
    our=load(ourFile);
    zhenan=load(zhenanFile);
    

    plot(our,'r');
    hold on;
    plot(zhenan,'g');
    hold off;
    legend('MOEAXXX','FD-NSGAIII');
    
end