function [U, D] = eigenfaces(images)
    % arrange data
    N = size(images, 2);
    X_mean = mean(images, 2);
    X = 1/sqrt(N) * (images - repmat(X_mean, [1, N]));
    
    % eigen values & eigen vectors
    [V, D] = eigen_Gram(X);
    V = V(:, 1:end-1);
    D = D(1:end-1);
    
    % eigen faces
    XV = X * V;
    U  = XV * (XV' * XV)^-0.5;
end

function [V, vp] = eigen_Gram(X)
    Gram = X' * X;
    [V, D] = eig(Gram);
    
    N = size(X, 2);
    vp = zeros(N, 1);
    for i = 1:N
        vp(i) = D(i,i);
    end
    [vp, order] = sort(vp, 'descend');
    V = V(:, order);
end