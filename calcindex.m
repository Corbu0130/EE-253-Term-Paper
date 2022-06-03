function result = calcindex(psm,VSM)
% Calculate AoV and AAI from VSM
% Engr. John Michael P. Corbeta, REE
    
    % Unpack system data structure
    n = psm.n;
    Vth = psm.Vth;
    dline = psm.dline;
    dsys = sum(dline(:,3));
    
    %% Loop over system buses on VSM
    BoV = cell(n,1);
    AB = cell(n,1);
    for k=1:n
        % Fetching buses with voltage sags
        bov = find(VSM(k,:)<Vth);
        ab = find(VSM(:,k)'<Vth);
        
        %% Fetching lines segments inside AoV contour
        a1 = zeros(length(dline),1);
        a2 = zeros(length(dline),1);
        for j=1:length(bov)
            a1 = a1 + (dline(:,1)==bov(j));
            a2 = a2 + (dline(:,2)==bov(j));
        end
        daov = sum(a1.*a2.*dline(:,3));
        AoVI(k,1) = daov/dsys; % calculate AoVI

        %% Fetching lines segments inside AA contour
        a1 = zeros(length(dline),1);
        a2 = zeros(length(dline),1);
        for j=1:length(ab)
            a1 = a1 + (dline(:,1)==ab(j));
            a2 = a2 + (dline(:,2)==ab(j));
        end
        daa = sum(a1.*a2.*dline(:,3));
        AAI(k,1) = daa/dsys; % calculate AAI

        BoV{k} = bov;
        AB{k} = ab;
    end
    
    result.BoV = BoV;
    result.AB = AB;
    result.AoVI = AoVI;
    result.AAI = AAI;

end