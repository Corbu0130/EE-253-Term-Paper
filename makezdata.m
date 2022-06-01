function psm = makezdata(psm)
% Generate sequence impedance data, new buses, segmenting lines
% Engr. John Michael P. Corbeta, REE
    
    % Unpack data structure
    n = psm.n;
    E = psm.E;
    gen = psm.gen;
    branch = psm.branch;
    bus = psm.bus;
    segments = psm.segments;
    p = 1/segments; % segment coefficient

    dline = []; % Initialize distances
    
    %% Start sequence impedance data from generator data
    zdata0 = [ zeros(size(gen,1),1) gen.NumberOfBus ...
        gen.R0+1i.*gen.X0+3.*gen.N.*(gen.Rn+1i.*gen.Xn) ];
    zdata1 = [ zeros(size(gen,1),1) gen.NumberOfBus ...
        gen.R1+1i.*gen.X1 ];
    zdata2 = [ zeros(size(gen,1),1) gen.NumberOfBus ...
        gen.R2+1i.*gen.X2 ];
    
    %% Adding branch data while segmenting lines
    m = n;
    for k=1:size(branch,1)
        fb = branch.FromNumber(k);
        tb = branch.ToNumber(k);
        z0 = branch.R0(k) + 1i*branch.X0(k);
        z1 = branch.R(k) + 1i*branch.X(k);
        z2 = z1;

        % If branch is transformer
        if branch.Xfrmr(k)=="YES"
            zdata0 = [ zdata0;
                fb  tb  z0 ];
            zdata1 = [ zdata1;
                fb  tb  z1 ];
            zdata2 = [ zdata2;
                fb  tb  z2 ];
            continue
        end
        
        % For lines
        dz0 = p*z0;
        dz1 = p*z1;
        dz2 = p*z2;
        dx = p*branch.Distance(k);
        dE = p*(E(tb) - E(fb));
        nV = bus.NomKV(fb);
        
        % segment lines and add ZIB
        for s=1:segments
            if s<segments
                m = m+1;
                tb = m;
                E(m) = E(fb) + dE;
            else
                tb = branch.ToNumber(k);
            end
            
            % Add impedance sequence data of line segments
            zdata0 = [ zdata0;
                fb  tb  dz0 ];
            zdata1 = [ zdata1;
                fb  tb  dz1 ];
            zdata2 = [ zdata2;
                fb  tb  dz2 ];

            % Add line segment distance
            dline = [ dline;
                fb tb dx ];

            Vm = abs(E(m));
            Va = angle(E(m))*180/pi;
            
            % Update bus table
            if s<segments
                bus.Number(end+1) = m;
                bus.NomKV(end) = nV;
                bus.Vm(end) = Vm;
                bus.Va(end) = Va;
            end
            
            fb = tb;
        end
    end
    
    %% Update power system model data
    psm.E = E;
    psm.bus = bus;
    psm.dline = dline;
    psm.zdata0 = zdata0;
    psm.zdata1 = zdata1;
    psm.zdata2 = zdata2;

end