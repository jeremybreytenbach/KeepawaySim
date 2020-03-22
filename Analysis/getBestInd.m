function ind = getBestInd(data)

    [~,indMax] = max(data);
    ind = false(size(data));
    ind(indMax,1) = true;