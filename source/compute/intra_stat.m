function [mu, sigma] = intra_stat(dataset, w)
    border = dataset.border;
    l = size(w, 1);
    m = dataset.Nc;
    [~, order] = sort(dataset.label);
    w = w(:, order);
    
    % mean
    mu = zeros(l, m);
    for j = 1:m
        mu(:, j) = mean(w(:, border(j):border(j+1)-1), 2);
    end

    % variance
    sigma = zeros(l, l);
    for j = 1:m
        Wj = w(:, border(j):border(j+1)-1);
        Wj = Wj - mu(:, j);
        for i = 1:dataset.size_cls(j)
            sigma = sigma + Wj(:, i) * Wj(:, i)';
        end
    end
    sigma = sigma / dataset.N;
end
