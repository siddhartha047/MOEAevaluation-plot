function f=attainmentSurfaceFromEquation()
    

    genDir='E:\Thesis lab experiment documents\abcgenerations\perfectWFG-DTLZ\perfectMOEAminmax2\0.5\';
    
    %{
    
    for i=4:4
        
        wfg= strcat('wfg',num2str(i),'_3.pf');
        pfFile=strcat(pfDir,wfg);
        ourGenFile=strcat(genDir,'sid',wfg);        
        subplotData(pfFile,ourGenFile,zhenanFile);
        plotin=plotin+1;
    end
    %}
    
    f = 'x^2+y^2+z^2-1'; 
    s=ezimplot3(f,[0 1 0 1 0 1])
       

    %{
    [x,y,z] = meshgrid( linspace( 0,1, 10) );
    f = x.^2+y.^2+z.^2;
    isosurface(x, y, z, f, 1)  
    %}
    
    f=0;
end