function p=plot_performance_score(wfgobjectivewise)

    
    objective=wfgobjectivewise(1:8,1)    
    gde3=wfgobjectivewise(1:8,2)
    hype=wfgobjectivewise(1:8,3)
    moead=wfgobjectivewise(1:8,4)
    zhenan=wfgobjectivewise(1:8,5)
    nsgaiii=wfgobjectivewise(1:8,6)
    moeaxxx=wfgobjectivewise(1:8,7)
    
    hold on;
    scatter(objective,moeaxxx,'b','o','LineWidth',1);
    
    scatter(objective,zhenan,'k','v','LineWidth',1);
    scatter(objective,nsgaiii,'g','*','LineWidth',1);    
    scatter(objective,hype,'m','d','LineWidth',1);
    scatter(objective,moead,'y','s','LineWidth',1);
    scatter(objective,gde3,'c','p','LineWidth',1);
    
    legend(['o' 'v','*','d','s','p'],{'F-DEA','FD-NSGAII','NSGAIII','HypE','MOEA/D','GDE3'});

    line(objective,moeaxxx,'Color',[0.1922,0.3255,0.6431],'LineWidth',1);
    
    set(gca,'XTick',objective );
    
    hold off;
    
    xlabel('No. of objectives (m)');
    ylabel('Average Performance Score','Rotation',90);
    
    p=0;
end