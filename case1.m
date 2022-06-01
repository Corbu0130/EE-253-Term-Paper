function [AoVI,AAI] = case1(psm)
    Zf = 0;
    VSM = slg(psm,Zf);
    [AoVI,AAI] = calcindex(psm,VSM);
end