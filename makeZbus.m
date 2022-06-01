function [zbus] = makeZbus(branches)
% Algorithm for the formation of sequence Zbus matrices
% Engr. John Michael P. Corbeta, REE
    
    % Sort bus numbers
    branches(:,1:2) = sort(branches(:,1:2),2);
%     branches = sortrows(branches);
    n = max(branches(:,2));
    zbus = zeros(n,n); % Initialize zbus with zero elements

    %% Loop thru branch data
    while ~isempty(branches)
        br = branches(1,:);
        branches(1,:) = [];
        fb = br(1);
        tb = br(2);
        z = br(3);

        if abs(z)==0
            continue
        end

        if fb==0
            if abs(zbus(tb,tb))==0 %Type 1 mod
                zbus(tb,:) = 0;
                zbus(:,tb) = 0;
                zbus(tb,tb) = z;
            else %Type 3
                zbus = zbus - zbus(:,tb)*zbus(tb,:)./...
                    (z + zbus(tb,tb));
            end
            continue
        end

        if abs(zbus(fb,fb))==0 % fb is new bus
            fb = br(2);
            tb = br(1);
            if abs(zbus(fb,fb))==0 % both buses are new
                branches = [ branches; br ];
                continue
            end
        end

        if abs(zbus(tb,tb))==0 %Type 2 mod
            zbus(tb,:) = zbus(fb,:);
            zbus(:,tb) = zbus(:,fb);
            zbus(tb,tb) = z + zbus(fb,fb);
            continue
        end

        zft = zbus(:,fb) - zbus(:,tb);
        zbus = zbus - (zft*zft.')./... % dot complement ughhh
            (z + zbus(fb,fb) + zbus(tb,tb) -...
            2*zbus(fb,tb));
    end

end