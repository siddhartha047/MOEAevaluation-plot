function f=twopointDraw()

    ref='E:\Thesis lab experiment documents\abcgenerations\perfectWFG-DTLZ\Analysis\estimatingbestK\3\050g\2\0.5\2referencepoints.ref';
    active='E:\Thesis lab experiment documents\abcgenerations\perfectWFG-DTLZ\Analysis\estimatingbestK\3\050g\2\0.5\2activePoints.ref';
    reduced='E:\Thesis lab experiment documents\abcgenerations\perfectWFG-DTLZ\Analysis\estimatingbestK\3\050g\2\0.5\2reducedPoints.ref';
    solution='E:\Thesis lab experiment documents\abcgenerations\perfectWFG-DTLZ\Analysis\estimatingbestK\3\050g\2\0.5\2solutions.sol';
    fuzzy='E:\Thesis lab experiment documents\abcgenerations\perfectWFG-DTLZ\Analysis\estimatingbestK\3\050g\2\0.5\2fuzzysolutions.sol';
    final ='E:\Thesis lab experiment documents\abcgenerations\perfectWFG-DTLZ\Analysis\estimatingbestK\3\050g\2\0.5\2finalsolution.sol';
    clustersolution='E:\Thesis lab experiment documents\abcgenerations\perfectWFG-DTLZ\Analysis\estimatingbestK\3\050g\2\0.5\2clusterpoints.refsol';
    clusterfuzzysolution='E:\Thesis lab experiment documents\abcgenerations\perfectWFG-DTLZ\Analysis\estimatingbestK\3\050g\2\0.5\2clusterfuzzypoints.refsol';
        
    hold on;
     
    %{
    plotXY(solution,'o',[0 1 0]);
    plotXY(fuzzy,'^',[1 0 0]);
    legend('Combined Population','Normalized solutions');
    %}
    
    
    plotXYReference(ref,'o',[0.5 0.5 0.5]);    
    legend('R^g/R^s','Vector From Point');
    %}
    %{
    plotXY(fuzzy,'o',[1 0 0]);
    plotXYRef(ref,active,'.',[1 0 0]);    
    legend('Normalized Solutions','Global Reference Points','Selected Reference Vectors');
    %}
   
    %{
    plotXYselect(active,reduced,'o',[0.5 0.5 0.5]);
    legend('Removed Points From Total Active Points')
    %}
    
    %{
    plotXYclusterPoint(clusterfuzzysolution,'o',[1 0 0]);
    legend('Normalized Solutions within Cluster')
    %}
    
    %{
    plotXYsolutionclusterPoint(clustersolution,'o',[1 0 0]);
    legend('Cluster Solution','Reference Point');
    %}
    
    hold off;
    
end

function s=plotXY(filename,marker,color)
    a= load(filename);    
    [m,n]=size(a);
    x=a(1:m,1);
    y=a(1:m,2);            
    scatter(x,y,'b',marker,'MarkerEdgeColor',[0 0 0],'MarkerFaceColor',color);
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

function s=plotXYselect(active,reduced,marker,color)
    b= load(reduced);    
    [mb,nb]=size(b);
    x=b(1:mb,1);
    y=b(1:mb,2);
        
    a= load(active);    
    [m,n]=size(a);
    x1=a(1:m,1);
    y1=a(1:m,2); 
        
    markercolor=zeros(m,3);
    
    for i=1:m
        if check(a(i,:),b)==1                       
           markercolor(i,:)=[0.5 0.5 0.5];
        else            
           markercolor(i,:)=[0 0 1];
        end
        
    end
    
    
    
    markercolor
    scatter(x1,y1,[],markercolor,marker,'filled','MarkerEdgeColor',[0 0 0]);
    
    for i=1:mb
        plot_arrow( 0,0,x(i,1),y(i,1),'linewidth',1.25,'headwidth',0.02,'headheight',0.03 );         
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
            
            [mp,np]=size(p);
            xp=p(1:mp,1);
            yp=p(1:mp,2);   
            scatter(xp,yp,[],mcolor,marker,'filled','MarkerEdgeColor',[0 0 0]);                        
            isref=1;
            
            scatter(c(1:1,1),c(1:1,2),[],ccolor,marker,'filled','MarkerEdgeColor',[0 0 0]);                        
            
            minx=min(xp);
            miny=min(yp);
            
            maxx=max(xp);
            maxy=max(yp);
            
            dx=max(abs(maxx-minx),0.1);
            dy=max(abs(maxy-miny),0.2);
            
            if dx==0.1 && dy==0.2
               minx=minx-dx/2
               miny=miny-dy/2
            else
                dx=dx+0.15;
                dy=dy+0.15;
                minx=minx-0.1
                miny=miny-0.1
            end
            
            
            
            rectangle('Position',[minx miny dx dy]);
            
            plot_arrow( c(1,1),c(1,2),minx,miny,'linewidth',1,'headwidth',0.02,'headheight',0.03 );         
            
        else
            p=cat(1,p,sol);        
            count=count+1;
            mcolor(count,:)=[0 1 0];
        end
    end
    
    
    grid off;
       
    xlabel('f_1');
    ylabel('f_2','rotation',0);
end