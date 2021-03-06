function [ S ] = calculateHYPE( Ref, P1,i1 )
    [row,dim]=size(P1);    
    disp(dim);

    if i1<4
        nadir=max(Ref);
        nadir=nadir+1.25;
        bounds=1.1*nadir;                    
    else 
        nadir=getbounds('wfg',i1,dim);                
        bounds=1.1*(nadir); 
    end                



    disp(bounds);

    samplingPoints=1000000;

    [m,n]=size(P1);                
    disp('P1:');
    disp(m);
    NP1=removenotdominatebounds(P1,bounds);
    [m,n]=size(NP1);
    disp('NP1');
    disp(m);

    if m==0
        hvvalue=0;
    else

        [rm,rn]=size(Ref);                
        NP1=gdivide(NP1,nadir);
        bounds=gdivide(bounds,nadir);

        if dim<5
            hvr=hypeIndicatorExact(NP1,bounds,m);
        else 
            hvr=hypeIndicatorSampled(NP1,bounds,m,samplingPoints);
        end

        %hvrtrue=hypeIndicatorExact(Ref,bounds,rm);                                                
        %hvr=hypeIndicatorSampled(NP1,bounds,m,samplingPoints);
        %hvrtrue=hypeIndicatorSampled(Ref,bounds,rm,samplingPoints);

        %disp('true');
        %disp(sum(hvrtrue));

        hvvalue=sum(hvr);
    end


    %hvr=hypeIndicatorSampled(P1,bounds,1,samplingPoints);               

    disp('HVR')
    disp(hvvalue);

    S=hvvalue;
    
end


