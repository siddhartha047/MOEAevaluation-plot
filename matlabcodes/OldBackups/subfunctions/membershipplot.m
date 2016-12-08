function m=membershipplot()
    
    position = [ 400 0 600 258];
    set(0, 'DefaultFigurePosition', position);
    
   %{ 
    
    mean=1.0210556816923215
    var=0.9587824557069236
    alpha=-4.792661591566717
    hold on;
    x = -2.5:0.001:2.5;    
    y = sigmf(x,[alpha mean]);
    plot(x,y,'LineWidth',1.25)    
    plot([mean mean], [0 1],'--r','LineWidth',2)
    plot([mean+var mean+var], [0 1],'-.g','LineWidth',1.5)
    plot([mean-var mean-var], [0 1],'-.g','LineWidth',1.5)
    h=legend('$(\alpha_3,\mu_3) = [-4.79\ 1.02]$','$\mu_3$','$\mu_3\pm\sigma_3$');
    set(h,'Interpreter','latex');
    xlabel('$f_3(x^a)-f_3(x^b)$','Interpreter','latex');
    ylabel('$\gamma_3(f_3(x^a)-f_3(x^b))$','Interpreter','latex');
    
    %ylim([-0.05 1.05])
    hold off;
%}

hold on;
    x = -1:0.001:1;
    y = gaussmf(x,[.5 -1]);
    mean=0.22871629180080288;
    
    plot(x,y,'LineWidth',1.25)    
    plot([mean mean], [0 1],'--r','LineWidth',2)
    %h=legend('$gaussian(\mu=-1, \sigma =0.5) and (\forall (\tilde{f}_3(x^a)-\tilde{f}_3(x^b))<-1\rightarrow \gamma(\tilde{f}_3(x^a)-\tilde{f}_3(x^b))=1)$','$\tilde{\mu}=0.2287$');
    h=legend('$gaussian(\mu=-1, \sigma =0.5)\ and\ (\forall (\tilde{f}_3(x^a)-\tilde{f}_3(x^b))<-1)\rightarrow \gamma_3(\tilde{f}_3(x^a)-\tilde{f}_3(x^b))=1)$','$Mean\ Normalized\ objective\ difference\ \tilde{\mu}=0.2287$');
    set(h,'Interpreter','latex');
    xlabel('$\tilde{f}_3(x^a)-\tilde{f}_3(x^b)$','Interpreter','Latex');
    ylabel('$\gamma_3(\tilde{f}_3(x^a)-\tilde{f}_3(x^b))$','Interpreter','Latex');
    m=0;
    hold off;
%}
end