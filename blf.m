function VSM = blf(psm,Zf)
    zbus = psm.zbus1;
    E = psm.E;
    
    m = length(E);
    Z = diag(ones(m).*zbus) + Zf;
    I = diag(-E./Z);
    dV = zbus*I;
    VSM = abs(E + dV);
end