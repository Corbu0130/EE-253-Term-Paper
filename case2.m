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
                VSM = VSM + slg(psm,Zf);
            case(2)
                VSM = VSM + l2l(psm,Zf);
            case(3)
                VSM = VSM + dlg(psm,Zf);
            case(4)
                VSM = VSM + blf(psm,Zf);
        end
    end
    
    %% Calculate mean VSM
    VSM = VSM/N;
    [AoVI,AAI] = calcindex(psm,VSM);
    result = table(AoVI,AAI);
    
end