function zbus = y2z(tab)
% Generate Zbus from Ybus data
    ybus = zeros(size(tab));
    for k = 1:numel(tab)
        s = tab{k};
        if ismissing(s)
            continue
        end
        s(s=='j') = '';
        s = s+"j";
        ybus(k) = eval(s);
    end
    zbus = inv(ybus);
end