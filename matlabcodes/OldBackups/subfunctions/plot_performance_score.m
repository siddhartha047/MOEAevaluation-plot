function p=plot_performance_score(wfgobjectivewise)

    
    problems=[{'W1'};{'W2'};{'W3'};{'W4'};{'W5'};{'W6'};{'W7'};{'W8'};{'W9'};{'D1'};{'D2'};{'D3'};{'D4'};{'D7'}]    
    
    objective=[1:1:14]
    gde3=wfgobjectivewise(1:14,1)
    hype=wfgobjectivewise(1:14,2)
    moead=wfgobjectivewise(1:14,3)
    zhenan=wfgobjectivewise(1:14,4)
    nsgaiii=wfgobjectivewise(1:14,5)
    moeaxxx=wfgobjectivewise(1:14,6)
    
    hold on;
    scatter(objective,moeaxxx,'filled','b','o','LineWidth',1);    
    scatter(objective,zhenan,'filled','k','v','LineWidth',1);
    scatter(objective,nsgaiii,'filled','g','^','LineWidth',1);    
    scatter(objective,hype,'filled','m','d','LineWidth',1);
    scatter(objective,moead,'filled','y','s','LineWidth',1);
    scatter(objective,gde3,'filled','r','>','LineWidth',1);
    
    legend(['o' 'v','*','d','s','p'],{'F-DEA','FD-NSGAII','NSGAIII','HypE','MOEA/D','GDE3'});

    line(objective,moeaxxx,'Color',[0.1922,0.3255,0.6431],'LineWidth',1);
    
    ax=gca;
    set(ax,'XTick',objective,'XTickLabel',problems);
   
    
    hold off;
    
    xlabel('Problem Name');
    ylabel('Average Performance Score for 5-20 objective','Rotation',90);
    
    p=0;
end