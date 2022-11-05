function [l_star, kappa] = facespace_energy(vp, ratio)
    N = length(vp);
    kappa = zeros(1, N);
    kappa(1) = vp(1);
    for i = 2:N
        kappa(i) = kappa(i-1) + vp(i);
    end
    kappa = kappa / sum(vp);
    l_star = find(kappa >= ratio, 1);
end
