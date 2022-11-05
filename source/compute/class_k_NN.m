function classifieur = class_k_NN(w_train, w_tests, label_train, k)
    N_tests = length(w_tests);
    N_train = length(w_train);
    classifieur = zeros(N_tests, 1);
    for id = 1:N_tests
        voisinage = zeros(N_train, 1);
        w = w_tests(:, id);
        for i = 1:N_train
            voisinage(i) = norm(w - w_train(:, i));
        end
        [~, order] = sort(voisinage);
        voisins = label_train(order(1:k));
        classifieur(id) = mode(voisins);
    end
end
