function VSM = blf(psm,Zf)
% Generate VSM from balanced fault
% Engr. John Michael P. Corbeta, REE
    
    % prepare variables
    zbus = psm.zbus1;
    E = psm.E;
    bus = psm.bus;
    
    % Calculate Zf in per unit
    Zbase = bus.NomKV.^2./100;
    Zf = Zf./Zbase;
    
    %% Calculate VSM
    m = length(E);
    Z = diag(ones(m).*zbus) + Zf;
    I = diag(-E./Z);
    dV = zbus*I;
    VSM = abs(E + dV);
    
end