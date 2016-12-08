    member='D:\FDEA2016\Codes\abcgenerations\recompileWFG-DTLZ\FDEA\backups\10real\2\0.05\2dmembership.func';
    membership=load(member);
    
    objno=size(membership,1);
    obj=1;
    alpha1=membership(obj,3);
	mean1=membership(obj,1);
	var1=membership(obj,2);
    obj=2;
    alpha2=membership(obj,3);
	mean2=membership(obj,1);
	var2=membership(obj,2);
        
    %x1=0.5;
    
    
    data=zeros(1000,2);
    count=1;
    limit=1;
    for x1 = -limit:0.01:limit;
        
        val= sigmf(-x1,[alpha1 0])/sigmf(x1,[alpha1 0]);
        syms x2
        result=vpasolve(sigmf(x2,[alpha2 0])/sigmf(-x2,[alpha2 0])-val==0,x2,x1);
       
        if size(result,2)==1
            data(count,1)=x1;
            data(count,2)=result;
            count=count+1;
        end
    end
    
    data=data(1:count-1,:);
    
    figure;
    x=data(:,1);
    y=data(:,2);
   
    hold on;
     
    plot(x,y,'LineWidth',2);
    axis([-limit,limit,-limit,limit]); % axis([xmin, xmax, ymin, ymax])
    
    
    line([0 0],[-limit limit],'LineWidth',2,'Color','black');
    line([-limit limit],[0 0],'LineWidth',2,'Color','black');
    xlabel('f_1');
    ylabel('f_2','Rotation',0);
       
    h=legend('Nondomination Curve');
    
    hold off;
    
    %mdl = LinearModel.fit(x,y)
    polyfit(x,y,1)
