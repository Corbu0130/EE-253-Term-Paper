function [AoVI,AAI] = calcindex(psm,VSM,Vth)
    n = psm.n;
    dline = psm.dline;
    dsys = sum(dline(:,3));

    for i=1:n
        AoV = find(VSM(i,:)<=Vth);
        AA = find(VSM(:,i)'<=Vth);
        
        a1 = zeros(length(dline),1);
        a2 = zeros(length(dline),1);
        for j=1:length(AoV)
            a1 = a1 + (dline(:,1)==AoV(j));
            a2 = a2 + (dline(:,2)==AoV(j));
        end
        daov = sum(a1.*a2.*dline(:,3));
        AoVI(i,1) = daov/dsys;

        a1 = zeros(length(dline),1);
        a2 = zeros(length(dline),1);
        for j=1:length(AA)
            a1 = a1 + (dline(:,1)==AA(j));
            a2 = a2 + (dline(:,2)==AA(j));
        end
        daa = sum(a1.*a2.*dline(:,3));
        AAI(i,1) = daa/dsys;
    end
end