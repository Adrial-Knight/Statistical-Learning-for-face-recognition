function W = center_project_firsts(images, U, l)
    N = size(images, 2);
    W = zeros(l, N);
    X_mean = mean(images, 2);
    for i = 1:N
        X = images(:, i) - X_mean;
        W(:, i) = X' * U(:, 1:l);
    end
end