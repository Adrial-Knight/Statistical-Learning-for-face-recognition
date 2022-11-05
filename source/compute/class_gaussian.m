function classifieur = class_gaussian(w_tests, labels, mu, sigma)
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
        [~, classifieur(id)] = max(vraissemblance);
    end
    classifieur = labels(classifieur);
end
