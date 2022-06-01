function psm = makezdata(psm)
    n = psm.n;
    E = psm.E;
    gen = psm.gen;
    branch = psm.branch;
    segments = psm.segments;
    p = 1/segments;

    dline = [];

    zdata0 = [ zeros(size(gen,1),1) gen.NumberOfBus ...
        gen.R0+1i.*gen.X0+3.*gen.N.*(gen.Rn+1i.*gen.Xn) ];
    zdata1 = [ zeros(size(gen,1),1) gen.NumberOfBus ...
        gen.R1+1i.*gen.X1 ];
    zdata2 = [ zeros(size(gen,1),1) gen.NumberOfBus ...
        gen.R2+1i.*gen.X2 ];
    
    m = n;
    for k=1:size(branch,1)
        fb = branch.FromNumber(k);
        tb = branch.ToNumber(k);
        z0 = branch.R0(k) + 1i*branch.X0(k);
        z1 = branch.R(k) + 1i*branch.X(k);
        z2 = z1;
        if branch.Xfrmr(k)=="YES"
            zdata0 = [ zdata0;
                fb  tb  z0 ];
            zdata1 = [ zdata1;
                fb  tb  z1 ];
            zdata2 = [ zdata2;
                fb  tb  z2 ];
            continue
        end

        dz0 = p*z0;
        dz1 = p*z1;
        dz2 = p*z2;
        dx = p*branch.Distance(k);
        dE = p*(E(tb) - E(fb));

        for s=1:segments
            if s<segments
                m = m+1;
                tb = m;
                E(m) = E(fb) + dE;
            else
                tb = branch.ToNumber(k);
            end
            
            zdata0 = [ zdata0;
                fb  tb  dz0 ];
            zdata1 = [ zdata1;
                fb  tb  dz1 ];
            zdata2 = [ zdata2;
                fb  tb  dz2 ];
            dline = [ dline;
                fb tb dx ];
            
            fb = tb;
        end
    end
    
    psm.E = E;
    psm.dline = dline;
    psm.zdata0 = zdata0;
    psm.zdata1 = zdata1;
    psm.zdata2 = zdata2;
end