function VSM = slg(psm,Zf)
% Generate VSM from single-line to ground fault
% Engr. John Michael P. Corbeta, REE
    
    % Unpack system data structure
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
    Z0 = diag(eye(m).*zbus0);
    Z1 = diag(eye(m).*zbus1);
    Z2 = diag(eye(m).*zbus2);
    If = E./(Z0+Z1+Z2+3.*Zf);
    If = [ If.'; If.'; If.' ];
    
    %% Calculate VSM
    V0 = -zbus0.*If(1,:);
    V1 = E-zbus1.*If(2,:);
    V2 = -zbus2.*If(3,:);
    Va = V0 + V1 + V2;
    VSM = abs(Va);

end