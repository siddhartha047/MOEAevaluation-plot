function f=twopointDraw()

    mainDir='D:\FDEA2016\Codes\abcgenerations\recompileWFG-DTLZ\FDEA\backups\10real\2\0.05\';

    ref=strcat(mainDir,'2referencepoints.ref');
    active=strcat(mainDir,'2activePoints.ref');
    reduced=strcat(mainDir,'2reducedPoints.ref');
    solution=strcat(mainDir,'2dlinear1_2.pf');
    fuzzy=strcat(mainDir,'2dlinearfuzzy1_2.pf');
    final =strcat(mainDir,'2dlinearsol1_2.pf');
    clustersolution=strcat(mainDir,'2clusterpoints.refsol');
    clusterfuzzysolution=strcat(mainDir,'2clusterfuzzypoints.refsol');
    
    figure;
    
    hold on;
    %axis([-0.05 1 -0.05 1]);
   
    %{
    plotXY(solution,'d','blue');
    plotXY(fuzzy,'^','green');
    legend('Combined Population','Normalized solutions');
    axis([0 1.4 0 1.4]);
    %}
    %{
    figure;
    
    plotXYReference(ref,'o',[0.5 0.5 0.5]);    
    legend('R^g/R^s','Vector From Point');
    %}
    
    %{
    h=plotXY(fuzzy,'^',[0 1 0]);        
    plotXYRef(ref,active,'o',[0.5 0.5 0.5]);        
    
    legend('Normalized Solutions','R^g','Selected Reference Vectors');
    uistack(h,'top');
    %}
   
    
    plotXYselect(active,reduced,'o',[0.5 0.5 0.5]);
    legend('Preferred Active Points','Removed Active Points');
    xlabel('f_1');
    ylabel('f_2','rotation',0);
    %}
        
   
    figure;
    plotXYselectPreferred(active,reduced,'o',[0.5 0.5 0.5]);
    legend('Preferred Active Points');
    
           
    xlabel('f_1');
    ylabel('f_2','rotation',0);
    
    %}
    
    %{
    plotXYclusterPoint(clusterfuzzysolution,'o',[1 0 0]);
    legend('Normalized Solutions within Cluster')
    %}
    
    %{
    plotXYsolutionclusterPoint(clustersolution,'o',[1 0 0]);
    %legend('Cluster Solution','Reference Point');
    %}
    
   %{
    plotXYsolutionclusterPointCluster(clustersolution,'o',[1 0 0]);
    %legend('Cluster Solution','Reference Point');
    %}
    
    hold off;
    
end

function s=plotXY(filename,marker,color)
    a= load(filename);    
    [m,n]=size(a);
    x=a(1:m,1);
    y=a(1:m,2);            
    s=scatter(x,y,'b',marker,'MarkerEdgeColor',[0 0 0],'MarkerFaceColor',color);
    grid off;
       
    xlabel('f_1');
    ylabel('f_2','rotation',0);
end


function s=plotXYReference(filename,marker,color)
    a= load(filename);    
    [m,n]=size(a);
    x=a(1:m,1);
    y=a(1:m,2);            
    scatter(x,y,'b',marker,'MarkerEdgeColor',[0 0 0],'MarkerFaceColor',color);
    grid off;        
   %{
    for i=1:m
        plot_arrow( 0,0,x(i,1)*0.99,y(i,1)*0.99,'linewidth',1.25,'headwidth',0.02,'headheight',0.03 );         
    end
    %}
    
    xlabel('f_1');
    ylabel('f_2','rotation',0);
end

function s=plotXYRef(ref,active,marker,color)
    a= load(ref);    
    [m,n]=size(a);
    x=a(1:m,1);
    y=a(1:m,2);      
    scatter(x,y,'b',marker,'MarkerEdgeColor',[0 0 0],'MarkerFaceColor',color);
    
    b= load(active);    
    [m,n]=size(b);
    x=b(1:m,1);
    y=b(1:m,2);
    
    for i=1:m
        plot_arrow( 0,0,x(i,1),y(i,1),'linewidth',1.25,'headwidth',0.02,'headheight',0.03 );         
    end
    
end


function s=plotXYselectPreferred(active,reduced,marker,color)
    b= load(reduced);    
    [mb,nb]=size(b);
    x=b(1:mb,1);
    y=b(1:mb,2);
        
    a= load(active);    
    [m,n]=size(a);
    x1=a(1:m,1);
    y1=a(1:m,2); 
    
    c=[];
    
    markercolor=zeros(m,3);    
    
    count=1;
    for i=1:m
        if check(a(i,:),b)==1                       
           markercolor(i,:)=[0.5 0.5 0.5];             
        else            
           markercolor(i,:)=[1 1 1];           
           c(count,:)=a(i,:);
           count=count+1;
        end
        
    end
    
    [mc,nc]=size(c);
    xc=c(1:mc,1);
    yc=c(1:mc,2);
    
    
    
    markercolor
    
    scatter(x,y,'o','filled','MarkerFaceColor',[0.5 0.5 0.5],'MarkerEdgeColor',[0 0 0]);    
    
end

function s=plotXYselect(active,reduced,marker,color)
    b= load(reduced);    
    [mb,nb]=size(b);
    x=b(1:mb,1);
    y=b(1:mb,2);
        
    a= load(active);    
    [m,n]=size(a);
    x1=a(1:m,1);
    y1=a(1:m,2); 
    
    c=[];
    
    markercolor=zeros(m,3);    
    
    count=1;
    for i=1:m
        if check(a(i,:),b)==1                       
           markercolor(i,:)=[0.5 0.5 0.5];             
        else            
           markercolor(i,:)=[1 1 1];           
           c(count,:)=a(i,:);
           count=count+1;
        end
        
    end
    
    [mc,nc]=size(c);
    xc=c(1:mc,1);
    yc=c(1:mc,2);
    
    
    
    markercolor
    
    scatter(x,y,'o','filled','MarkerFaceColor',[0.5 0.5 0.5],'MarkerEdgeColor',[0 0 0]);
    scatter(xc,yc,'s','MarkerEdgeColor',[0 0 0]);
    
    for i=1:mb
      %  plot_arrow( 0,0,x(i,1),y(i,1),'linewidth',1.25,'headwidth',0.02,'headheight',0.03 );         
    end
end

function s=check(a,b)    
    [m,n]=size(b);
    
    s=0;
    
    for i=1:m
       b1=b(i,:);       
       if (b1(1,1)== a(1,1)) && (b1(1,2)==a(1,2))           
           s=1;
            break;
       end
       
    end
    
end

function s=plotXYclusterPoint(filename,marker,color)
    a= load(filename);    
    
   [m,n]=size(a);
   
   p=a(1,:);    
   mcolor=zeros(2,3);
   mcolor(1,:)=[0.5 0.5 0.5];
   count=1;
    isref=0;
    for i=2:m             
        sol=a(i,:);         
        if isref==1          
            count=1;
            p=sol;
            mcolor=zeros(2,3);
            mcolor(1,:)=[0.5 0.5 0.5]; 
            isref=0;
        elseif sol(1,1)==-1 && sol(1,2)==-1 
            p
            mcolor
            [mp,np]=size(p);
            xp=p(1:mp,1);
            yp=p(1:mp,2);   
            scatter(xp,yp,[],mcolor,marker,'filled','MarkerEdgeColor',[0 0 0]);                        
            isref=1;
            
            minx=min(xp);
            miny=min(yp);
            
            maxx=max(xp);
            maxy=max(yp);
            
            dx=max(abs(maxx-minx),0.05);
            dy=max(abs(maxy-miny),0.05);
            
            if dx==0.05 && dy==0.05
               minx=minx-dx/2
               miny=miny-dy/2
            else
                dx=dx+0.05;
                dy=dy+0.05;
                minx=minx-0.025
                miny=miny-0.025
            end
            
            rectangle('Position',[minx miny dx dy]);
            
            plot_arrow( 0,0,p(1,1),p(1,2),'linewidth',1,'headwidth',0.02,'headheight',0.03 );         
            
        else
            p=cat(1,p,sol);        
            count=count+1;
            mcolor(count,:)=[1 0 0];
        end
    end
    
    
    grid off;
       
    xlabel('f_1');
    ylabel('f_2','rotation',0);
end

function s=plotXYsolutionclusterPoint(filename,marker,color)
   
    refpoint='D:\FDEA2016\Codes\abcgenerations\recompileWFG-DTLZ\FDEA\backups\10real\2\0.05\2referencepoints.ref';
    refpoints=load(refpoint);
       
    for i=1:size(refpoints,1)        
        plot_arrow( 0,0,refpoints(i,1),refpoints(i,2),'linewidth',1.25,'headwidth',0.02,'headheight',0.03 );         
    end

    a= load(filename);    
    
   [m,n]=size(a);
   
   p=a(1,:);    
   mcolor=zeros(2,3);
   mcolor(1,:)=[0.5 0.5 0.5];
   count=1;
    isref=0;
    for i=2:m             
        sol=a(i,:);         
        if isref==1          
            count=1;
            p=sol;
            mcolor=zeros(2,3);
            mcolor(1,:)=[0.5 0.5 0.5]; 
            isref=0;
        elseif sol(1,1)==-1 && sol(1,2)==-1 
            p
            mcolor
            
            [mp,np]=size(p);
            
            c=p(1,:);
            p=p(2:mp,:);
            
            ccolor=mcolor(1,:);
            mcolor=mcolor(2:mp,:);
            mcolor(1,:)=[rand(),rand(),rand()];
            for ss=2:size(mcolor,1)
                mcolor(ss,:)=mcolor(1,:);
            end
            
            [mp,np]=size(p);
            xp=p(1:mp,1);
            yp=p(1:mp,2);   
           % scatter(xp,yp,[],mcolor,'d','filled');                        
            isref=1;
            
            %scatter(c(1:1,1),c(1:1,2),[],ccolor,marker,'filled','MarkerEdgeColor',[0 0 0]);                        
            
            minx=min(xp);
            miny=min(yp);
            
            maxx=max(xp);
            maxy=max(yp);
            
            dx=max(abs(maxx-minx),0.05);
            dy=max(abs(maxy-miny),0.05);
            
            %dx=max(abs(maxx-minx),0.1);
            %dy=max(abs(maxy-miny),0.2);
            %{
            if dx==0.1 && dy==0.2
               minx=minx-dx/2
               miny=miny-dy/2
            else
                dx=dx+0.15;
                dy=dy+0.15;
                minx=minx-0.1
                miny=miny-0.1
            end
            %}
            
            rectangle('Position',[minx miny dx dy]);
            
           % plot_arrow( c(1,1),c(1,2),minx,miny,'linewidth',1,'headwidth',0.02,'headheight',0.03 );         
            
        else
            p=cat(1,p,sol);        
            count=count+1;
            mcolor(count,:)=[0 1 0];
        end
    end
    
    
    grid off;
       
    xlabel('f_1');
    ylabel('f_2','rotation',0);
    axis([0,2,0,4]);
    % axis([xmin, xmax, ymin, ymax])
end

function s=plotXYsolutionclusterPointCluster(filename,marker,color)
   
    %{
    refpoint='D:\FDEA2016\Codes\abcgenerations\recompileWFG-DTLZ\FDEA\backups\10real\2\0.05\2referencepoints.ref';
    refpoints=load(refpoint);
       
    for i=1:size(refpoints,1)        
        plot_arrow( 0,0,refpoints(i,1),refpoints(i,2),'linewidth',1.25,'headwidth',0.02,'headheight',0.03 );         
    end
    %}
    a= load(filename);    
    
   [m,n]=size(a);
   
   p=a(1,:);    
   mcolor=zeros(2,3);
   mcolor(1,:)=[0.5 0.5 0.5];
   count=1;
    isref=0;
    for i=2:m             
        sol=a(i,:);         
        if isref==1          
            count=1;
            p=sol;
            mcolor=zeros(2,3);
            mcolor(1,:)=[0.5 0.5 0.5]; 
            isref=0;
        elseif sol(1,1)==-1 && sol(1,2)==-1 
            p
            mcolor
            
            [mp,np]=size(p);
            
            c=p(1,:);
            p=p(2:mp,:);
            
            ccolor=mcolor(1,:);
            mcolor=mcolor(2:mp,:);
            mcolor(1,:)=[rand(),rand(),rand()];
            for ss=2:size(mcolor,1)
                mcolor(ss,:)=mcolor(1,:);
            end
            
            [mp,np]=size(p);
            xp=p(1:mp,1);
            yp=p(1:mp,2);   
           % scatter(xp,yp,[],mcolor,'d','filled');                        
            isref=1;
            
            %scatter(c(1:1,1),c(1:1,2),[],ccolor,marker,'filled','MarkerEdgeColor',[0 0 0]);                        
            scatter(c(1:1,1),c(1:1,2),[],'k','*');                        
            
            minx=min(xp);
            miny=min(yp);
            
            maxx=max(xp);
            maxy=max(yp);
            
            dx=max(abs(maxx-minx),0.01);
            dy=max(abs(maxy-miny),0.01);
            
            %dx=max(abs(maxx-minx),0.1);
            %dy=max(abs(maxy-miny),0.2);
            %{
            if dx==0.1 && dy==0.2
               minx=minx-dx/2
               miny=miny-dy/2
            else
                dx=dx+0.15;
                dy=dy+0.15;
                minx=minx-0.1
                miny=miny-0.1
            end
            %}
            
            rectangle('Position',[minx miny dx dy]);
            
            %plot_arrow( c(1,1),c(1,2),minx,miny,'linewidth',1,'headwidth',0.02,'headheight',0.03 );         
            line( [c(1,1),minx],[c(1,2),miny],'color','k');         
            
        else
            p=cat(1,p,sol);        
            count=count+1;
            mcolor(count,:)=[0 1 0];
        end
    end
    
    
    grid off;
       
    xlabel('f_1');
    ylabel('f_2','rotation',0);
    axis([0,1.4,0,1.4]); % axis([xmin, xmax, ymin, ymax])
end