function result = case2(psm)
% Case 2: Bolted Random Fault Type
% Engr. John Michael P. Corbeta, REE

    N = psm.N;
    m = length(psm.E);
    Zf = 0;
    
    %% Generate random fault types
    fi = rand(N,1);
    ftype = 4.*ones(N,1);
    ftype(fi<=0.95) = 3;
    ftype(fi<=0.85) = 2;
    ftype(fi<=0.7) = 1;
    
    %% Start Monte Carlo simulation
    VSM = zeros(m);
    for i=1:N
        switch(ftype(i))
            case(1)
                vsm = slg(psm,Zf);
            case(2)
                vsm = l2l(psm,Zf);
            case(3)
                vsm = dlg(psm,Zf);
            case(4)
                vsm = blf(psm,Zf);
        end
        VSM = VSM + vsm;
    end
    
    %% Calculate mean VSM
    VSM = VSM/N;
    result = calcindex(psm,VSM);
    result.tab = table(result.AoVI,result.AAI);
    
end