function classifieur = class_gaussian_plus(w_tests, labels, mu, sigma)
    labels = unique(labels);
    m = size(mu, 2);
    N_tests = size(w_tests, 2);
    classifieur = zeros(N_tests, 1);
    sigma_demi = mpower(sigma, -0.5);
    for id = 1:N_tests
        vraissemblance = zeros(m, 1);
        w = w_tests(:, id);
        for j = 1:m
            vraissemblance(j) = - norm(sigma_demi * (w - mu(:, j)));
        end
        [maxv, i_max] = max(vraissemblance);
        if exp(abs(maxv)) < abs(mu(i_max))
            classifieur(id) = i_max;
        else
            classifieur(id) = 0;
        end
    end
    not_present = classifieur == 0;
    classifieur = labels(classifieur + not_present);
    classifieur(not_present) = 0;
end
