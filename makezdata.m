function psm = makezdata(psm)
    gen = psm.gen;
    branch = psm.branch;

    lines = find(branch.Xfrmr=="NO");
    dline = [ branch.FromNumber(lines) ...
        branch.ToNumber(lines) branch.Distance(lines) ];

    zdata0 = [ zeros(size(gen,1),1) gen.NumberOfBus ...
        gen.R0+1i.*gen.X0+3.*gen.N.*(gen.Rn+1i.*gen.Xn);
        branch.FromNumber branch.ToNumber ...
        branch.R0+1i.*branch.X0 ];
    zdata1 = [ zeros(size(gen,1),1) gen.NumberOfBus ...
        gen.R1+1i.*gen.X1;
        branch.FromNumber branch.ToNumber ...
        branch.R+1i.*branch.X ];
    zdata2 = [ zeros(size(gen,1),1) gen.NumberOfBus ...
        gen.R2+1i.*gen.X2;
        branch.FromNumber branch.ToNumber ...
        branch.R+1i.*branch.X ];
    
    psm.dline = dline;
    psm.zdata0 = zdata0;
    psm.zdata1 = zdata1;
    psm.zdata2 = zdata2;
end