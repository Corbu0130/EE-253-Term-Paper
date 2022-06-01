function VSM = l2l(psm,Zf)
% Generate VSM from line-to-line fault
% Engr. John Michael P. Corbeta, REE
    
    % prepare variables
    global a;
    zbus0 = psm.zbus0;
    zbus1 = psm.zbus1;
    zbus2 = psm.zbus2;
    E = psm.E;
    bus = psm.bus;

    % Calculate Zf in per unit
    Zbase = bus.NomKV.^2./100;
    Zf = Zf./Zbase;

    %% Calculate Fault Currents
    m = length(E);
    Z1 = diag(eye(m).*zbus1);
    Z2 = diag(eye(m).*zbus2);
    If = E./(Z1+Z2+Zf);
    If = [ zeros(1,m); If.'; -If.' ];
    
    %% Calculate VSM
    V0 = -zbus0.*If(1,:);
    V1 = E-zbus1.*If(2,:);
    V2 = -zbus2.*If(3,:);
    Vb = V0 + a^2.*V1 + a*V2;
    VSM = abs(Vb);

end