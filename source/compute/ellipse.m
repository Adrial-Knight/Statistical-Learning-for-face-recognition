function [E, V_sorted, lambda_sorted] = ellipse(data, t, centre)
    data_norm = data-mean(mean(data));
    cov_data = cov(data_norm);
    
    [V, Lambda] = eig(cov_data);
    lambda = diag(Lambda);
    [lambda_sorted, position] = sort(lambda, 'descend');
    V_sorted = -V(:, position);
    
    ellipse = V_sorted*[2*sqrt(lambda_sorted(1, 1))*cos(t); 2*sqrt(lambda_sorted(2, 1))*sin(t)];
    
    E = [ellipse(1, :)+centre(1, 1); ellipse(2, :)+centre(2, 1)];
end

