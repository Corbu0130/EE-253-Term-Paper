function [AoVI,AAI] = case3(psm)
    N = psm.N;
    m = length(psm.E);

    mu = 5;
    s = 1;
    Zfs = (s*randn(N,1) + mu)/100;
    
    fi = rand(N,1);
    ftype = 4.*ones(N,1);
    ftype(fi<=0.95) = 3;
    ftype(fi<=0.85) = 2;
    ftype(fi<=0.7) = 1;
    
    VSM = zeros(m);
    for i=1:N
        Zf = Zfs(i);
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

    VSM = VSM/N;
    [AoVI,AAI] = calcindex(psm,VSM);
end