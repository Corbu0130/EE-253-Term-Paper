function VSM = dlg(psm,Zf)
    global a;
    zbus0 = psm.zbus0;
    zbus1 = psm.zbus1;
    zbus2 = psm.zbus2;
    E = psm.E;

    m = length(E);
    Z0 = diag(eye(m).*zbus0)+3*Zf;
    Z1 = diag(eye(m).*zbus1);
    Z2 = diag(eye(m).*zbus2);
    If1 = E./(Z1 + Z2.*Z0./(Z2 + Z0));
    If0 = -(E-Z1.*If1)./Z0;
    If2 = -(E-Z1.*If1)./Z2;
    If = [ If0.'; If1.'; If2.' ];
    
    V0 = -zbus0.*If(1,:);
    V1 = E-zbus1.*If(2,:);
    V2 = -zbus2.*If(3,:);
    Vb = V0 + a^2.*V1 + a*V2;
    VSM = abs(Vb);
end