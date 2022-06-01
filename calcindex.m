function [AoVI,AAI] = calcindex(psm,VSM)
% Calculate AoV and AAI from VSM
% Engr. John Michael P. Corbeta, REE
    
    % Unpack system data structure
    n = psm.n;
    Vth = psm.Vth;
    dline = psm.dline;
    dsys = sum(dline(:,3));
    
    %% Loop over system buses on VSM
    for i=1:n
        % Fetching buses with voltage sags
        AoV = find(VSM(i,:)<Vth);
        AA = find(VSM(:,i)'<Vth);
        
        %% Fetching lines segments inside AoV contour
        a1 = zeros(length(dline),1);
        a2 = zeros(length(dline),1);
        for j=1:length(AoV)
            a1 = a1 + (dline(:,1)==AoV(j));
            a2 = a2 + (dline(:,2)==AoV(j));
        end
        daov = sum(a1.*a2.*dline(:,3));
        AoVI(i,1) = daov/dsys; % calculate AoVI

        %% Fetching lines segments inside AA contour
        a1 = zeros(length(dline),1);
        a2 = zeros(length(dline),1);
        for j=1:length(AA)
            a1 = a1 + (dline(:,1)==AA(j));
            a2 = a2 + (dline(:,2)==AA(j));
        end
        daa = sum(a1.*a2.*dline(:,3));
        AAI(i,1) = daa/dsys; % calculate AAI
    end

end