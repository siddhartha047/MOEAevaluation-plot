function m=membershipplot()
    
    position = [ 400 0 600 258];
    set(0, 'DefaultFigurePosition', position);
    
    member='D:\FDEA2016\Codes\abcgenerations\recompileWFG-DTLZ\FDEA\backups\10real\2\0.05\2dmembership.func';
    membership=load(member);

    
    obj=2;
    
    alpha=membership(obj,3)
    mean=membership(obj,1)
    var=membership(obj,2)
    maxvalue=membership(obj,4)
    
    
    %mean=1.0210556816923215
    %var=0.9587824557069236
    %alpha=-4.792661591566717
    figure;
    hold on;
    x = -maxvalue:0.001:maxvalue;    
   % y = sigmf(x,[alpha mean]);
    y = sigmf(x,[alpha  0]);
    plot(x,y,'LineWidth',1.25)    
    plot([mean mean], [0 1],'--r','LineWidth',2)
    plot([mean+1*var mean+1*var], [0 1],'-.g','LineWidth',2)
    if obj==1
        h=legend('\alpha_1 = [ -1.93 ]','\mu_1 = [ 1.33]','(-\mu_1-\sigma_1,\mu_1+\sigma_1)\rightarrow(-2.38,+2.38)','Interpreter','tex');
    else
        h=legend('\alpha_2 = [ -1.93 ]','\mu_2 = [ 1.33]','(-\mu_2-\sigma_2,\mu_2+\sigma_2)\rightarrow(-2.38,+2.38)','Interpreter','tex');
    end
    plot([-mean -mean], [0 1],'--r','LineWidth',2)       
    plot([-mean-1*var -mean-1*var], [0 1],'-.g','LineWidth',2)
    
    -mean-var
    mean+var
    
    axis([-maxvalue maxvalue 0 1]);
    %plot([mean+var mean+var], [0 1],'-.g','LineWidth',1.5)
    %plot([mean-var mean-var], [0 1],'-.g','LineWidth',1.5)
    %h=legend('$(\alpha_1,\mu_1) = [-4.79\ 1.02]$','$\mu_1$','$\mu_1\pm\sigma_1$');    
    
    set(h,'Interpreter','latex');
    if obj==1
        xlabel('f_1(x^a)-f_1(x^b)','Interpreter','tex');
        ylabel('\gamma_1(f_1(x^a)-f_1(x^b))','Interpreter','tex');
    else
        xlabel('f_2(x^a)-f_2(x^b)','Interpreter','tex');
        ylabel('\gamma_2(f_2(x^a)-f_2(x^b))','Interpreter','tex');
    end
    
    %ylim([-0.05 1.05])
    hold off;
%}
%{
hold on;
    x = -1:0.001:1;
    y = gaussmf(x,[.5 -1]);
    %mean=0.22871629180080288;
    mean=mean/maxvalue
    
    plot(x,y,'LineWidth',1.25)    
    plot([mean mean], [0 1],'--r','LineWidth',2)
    plot([-mean -mean], [0 1],'--r','LineWidth',2)
    %h=legend('$gaussian(\mu=-1, \sigma =0.5) and (\forall (\tilde{f}_3(x^a)-\tilde{f}_3(x^b))<-1\rightarrow \gamma(\tilde{f}_3(x^a)-\tilde{f}_3(x^b))=1)$','$\tilde{\mu}=0.2287$');
    h=legend('$gaussian(\mu=-1, \sigma =0.5)\ and\ (\forall (\tilde{f}_3(x^a)-\tilde{f}_3(x^b))<-1)\rightarrow \gamma_3(\tilde{f}_3(x^a)-\tilde{f}_3(x^b))=1)$','$Mean\ Normalized\ objective\ difference\ \tilde{\mu}=0.268$');
    set(h,'Interpreter','latex');
    xlabel('$\tilde{f}_3(x^a)-\tilde{f}_3(x^b)$','Interpreter','Latex');
    ylabel('$\gamma_3(\tilde{f}_3(x^a)-\tilde{f}_3(x^b))$','Interpreter','Latex');
    m=0;
    hold off;
%}
end