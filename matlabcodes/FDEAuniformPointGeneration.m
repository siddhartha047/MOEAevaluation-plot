function f=FDEAgenerationPlot3d()
    
   % generatedCurve();
   % generateLine();
   % randomSolution()
   
   %randomDomianting();
    
    f=0
   %generateCircle();
   generateCase();
end

function f=generateCircle()
    base=0;
    points=29;
    angle=360/points;
    
    theta=0;
    r=1;
    rad=pi/180;
    
    for i=1:points+1
        x=r*cos(theta*rad);
        y=r*sin(theta*rad);
        theta=theta+angle;
        obj1=strcat('objectives[',num2str(base+i-1),'][0]=',num2str(x+2),';');
        obj2=strcat('objectives[',num2str(base+i-1),'][1]=',num2str(y+2),';');
        disp(obj1);
        disp(obj2);
    end

end

function f=randomDomianting()
    base=8;
    points=7;
    r=1;
    dx=1/points;       
        
    val=0;
    for i=1:points+1
        x=rand()*.5+0.5;
        y=rand()*(x-(1-x))+(1-x);
        
        val=val+dx;
        obj1=strcat('objectives[',num2str(base+i-1),'][0]=',num2str(x),';');
        obj2=strcat('objectives[',num2str(base+i-1),'][1]=',num2str(y),';');
        disp(obj1);
        disp(obj2);
    end

end

function f=randomSolution()
    base=0;
    points=7;
    r=1;
    dx=1/points;       
        
    val=0;
    for i=1:points+1
        x=rand()*1;
        y=rand()*3;
        val=val+dx;
        obj1=strcat('objectives[',num2str(base+i-1),'][0]=',num2str(x),';');
        obj2=strcat('objectives[',num2str(base+i-1),'][1]=',num2str(y),';');
        disp(obj1);
        disp(obj2);
    end

end

function f=generateLine()
    base=0;
    points=29;
    r=1;
    dx=1/points;       
        
    val=0;
    for i=1:points+1
        x=val;
        y=1-x/2;
        val=val+dx;
        obj1=strcat('objectives[',num2str(base+i-1),'][0]=',num2str(x),';');
        obj2=strcat('objectives[',num2str(base+i-1),'][1]=',num2str(y),';');
        disp(obj1);
        disp(obj2);
    end

end


function f=generatedCurve()
    base=0;
    points=7;
    angle=90/points;
    
    theta=0;
    r=1;
    rad=pi/180;
    
    for i=1:points+1
        x=r*cos(theta*rad);
        y=r*sin(theta*rad);
        theta=theta+angle;
        obj1=strcat('objectives[',num2str(base+i-1),'][0]=',num2str(1-x),';');
        obj2=strcat('objectives[',num2str(base+i-1),'][1]=',num2str(1-y),';');
        disp(obj1);
        disp(obj2);
    end

end



function f=generateCase()
    base=0;
    points=6;
    angle=18;
    
    theta=0;
    r=1;
    rad=pi/180;
    
    index=0;
    for i=1:points                
        
        if i==1
            dx=[-4.2 +4.2];
            temp=theta+angle/2;
            
            for j=1:2
                
                dm=1;
                for k=1:1
                    dmx=0.1*rand();
                    if dm>1.1
                        randa=temp-3+rand()*6;
                        x=dm*cos(randa*rad);
                        y=dm*sin(randa*rad);
                    else
                        x=dm*cos((temp+dx(j))*rad);
                        y=dm*sin((temp+dx(j))*rad);
                    end
                    obj1=strcat('objectives[',num2str(index),'][0]=',num2str(x),';');
                    obj2=strcat('objectives[',num2str(index),'][1]=',num2str(y),';');
                    index=index+1;
                    dm=dm+dmx;
                    disp(obj1);
                    disp(obj2);
                end
                
            end
        elseif i==2 || i==points-1
            theta=theta+angle;
            continue;
        
        elseif i==points
            dx=[-4.2 +4.2];
            temp=theta-angle/2;
            
           for j=1:2
                
                 dm=1;
                for k=1:1
                    dmx=0.1*rand();
                    if dm>1.1
                        randa=temp-3+rand()*6;
                        x=dm*cos(randa*rad);
                        y=dm*sin(randa*rad);
                    else
                        x=dm*cos((temp+dx(j))*rad);
                        y=dm*sin((temp+dx(j))*rad);
                    end
                    obj1=strcat('objectives[',num2str(index),'][0]=',num2str(x),';');
                    obj2=strcat('objectives[',num2str(index),'][1]=',num2str(y),';');
                    index=index+1;
                    dm=dm+dmx;
                    disp(obj1);
                    disp(obj2);
                end
                
            end
            
        else 
            dx=[+2.0 -2.0];
            temp=theta;
            
            for j=1:2
                
                   dm=1;
                for k=1:2
                    dmx=0.1*rand();
                    if dm>1.1
                        randa=temp-3+rand()*6;
                        x=dm*cos(randa*rad);
                        y=dm*sin(randa*rad);
                    else
                        x=dm*cos((temp+dx(j))*rad);
                        y=dm*sin((temp+dx(j))*rad);
                    end
                    obj1=strcat('objectives[',num2str(index),'][0]=',num2str(x),';');
                    obj2=strcat('objectives[',num2str(index),'][1]=',num2str(y),';');
                    index=index+1;
                    dm=dm+dmx;
                    disp(obj1);
                    disp(obj2);
                end
                
            end
        end

        theta=theta+angle;
    end

end
