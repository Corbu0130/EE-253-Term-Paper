function result = case1(psm)
% Case 1: Bolted SLG Fault
% Engr. John Michael P. Corbeta, REE

    Zf = 0;
    VSM = slg(psm,Zf);
    [AoVI,AAI] = calcindex(psm,VSM);
    result = table(AoVI,AAI);
    
end