function f=attainmentSurfacePlot()
    
    %pfDir='E:\Thesis lab experiment documents\pf\perfectWFG\';
    pfDir='E:\Thesis lab experiment documents\pf\perfectDTLZ\';
    genDir='E:\Thesis lab experiment documents\abcgenerations\perfectWFG-DTLZ\perfectMOEAminmax2\0.5\';
   
    plotin=1;
    
    
    
    %{
    for i=2:2
        
        wfg= strcat('wfg',num2str(i),'_3.pf');
        pfFile=strcat(pfDir,wfg);
        ourGenFile=strcat(genDir,'sid',wfg);
        zhenanFile=strcat(genDir,'zhenan',wfg);
        
     %   subplot(2,2,plotin);
        subplotData(pfFile,ourGenFile,zhenanFile);
        plotin=plotin+1;
    end
    
    %}
    
   
    for i=[7]
        grid off;
        dtlz= strcat('DTLZ',num2str(i),'_3D.pf');
       % dtlz='DTLZ7(3)-PF.txt';
        dtlzpf=strcat('DTLZ',num2str(i),'_3.pf');
        pfFile=strcat(pfDir,dtlz);
        ourGenFile=strcat(genDir,'sid',dtlzpf);
        zhenanFile=strcat(genDir,'zhenan',dtlzpf);
        
        %subplot(2,2,plotin);
        subplotData(pfFile,ourGenFile,zhenanFile);
        plotin=plotin+1;
    end
    
   %}
    
    f=0
end

function s=drawScatter(pfData,color,marker)
    
    [row,col]=size(pfData);
    pfX=pfData(1:row,1);
    pfY=pfData(1:row,2);
    pfZ=pfData(1:row,3);
    s=scatter3(pfX,pfY,pfZ,color,marker,'MarkerEdgeColor',[0 0 0],'MarkerFaceColor',[.5 .5 .5]);
    
end


function s=drawScatterZhenan(pfData,color,marker)
    
    [row,col]=size(pfData);
    pfX=pfData(1:row,1);
    pfY=pfData(1:row,2);
    pfZ=pfData(1:row,3);
    s=scatter3(pfX,pfY,pfZ,color,marker,'MarkerEdgeColor',[0 0 0],'MarkerFaceColor',[0 1 0]);
    
end

function s=drawScatterPareto(pfData,color,marker)
    
    [row,col]=size(pfData);
    pfX=pfData(1:row,1);
    pfY=pfData(1:row,2);
    pfZ=pfData(1:row,3);
    s=scatter3(pfX,pfY,pfZ,color,marker,'MarkerEdgeColor',[0 0 0],'MarkerFaceColor',[1 0 0]);
    
end

function s=drawLine(pfData,color,alpha)
    
    [row,col]=size(pfData);
    
    pfX=pfData(1:row,1);
    pfY=pfData(1:row,2);
    pfZ=pfData(1:row,3);
    
    %{
    griddatan(x,y,z);
    
    [qx,qy] = meshgrid(x,y);
    F = TriScatteredInterp(x,y,z);
    qz = F(qx,qy);
    surf(qx,qy,qz)
    %}
    %plot3(x,y,z,'-');
    %{
    [x,y] = meshgrid(pfX,pfY);
    tri = delaunay(x,y);
    z=griddata(pfX,pfY,pfZ,x,y);
    hSurface=trisurf(tri,x,y,z)
    set(hSurface,'linewidth',1);
    set(hSurface,'FaceColor',[1 0 0],'FaceAlpha',0.0);
    %}
    
    
    dx=0.05;
    dy=0.05;
    x_edge=[floor(min(pfX)):dx:ceil(max(pfX))];
    y_edge=[floor(min(pfY)):dy:ceil(max(pfY))];
    
    [X,Y]=ndgrid(x_edge,y_edge);
    Z=griddata(pfX,pfY,pfZ,X,Y);
    
    hSurface=surf(X,Y,Z)
    
    set(hSurface,'linewidth',1);
    set(hSurface,'FaceColor',[1 0 0],'FaceAlpha',0.0);
   % box on;
   % BoxStyle='back';
    grid off;
    %view(135,44);
    view(63,38);
   % view(70,22);
   % axis manual;
    %}
    
end

function s=subplotData(pfFile,ourGenFile,zhenanFile)
    pfData=load(pfFile);   
    %extra=[0.5,0,0;0,.5,0;0,0,.5];
    %pfData=[extra;pfData];
    pfData=pfData(1:5000,:);
   % pfData=getNonDominatedSolution(pfData);
    
    ourData=load(ourGenFile);
    ourData=getNonDominatedSolution(ourData);
    
   % zhenanData=load(zhenanFile);
   % zhenanData=getNonDominatedSolution(zhenanData);
    
    drawLine(pfData,'r','*');
    %drawScatterPareto(pfData,'b','o');
    hold on;
    drawScatter(ourData,'b','o');    
    %drawScatterZhenan(zhenanData, 'g','o');    
    xlabel('f1');
    ylabel('f2','Rotation',0);
    zlabel('f3','Rotation',0);
    %legend(['*' '+' 'o'],{'True front','Our','zhenan'});
    hold off; 
    

end

