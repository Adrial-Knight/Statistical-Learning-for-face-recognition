function images = image_reduction(dataset, U, l_star)
    X_mean = mean(dataset.images, 2);
    images = zeros(dataset.P, l_star, dataset.Nc);
    id = 1;
    for i = 1:dataset.Nc
        im = dataset.images(:, id) - X_mean;
        id = id + dataset.size_cls(i);
        images(:, 1, i) = (im' * U(:, 1)) * U(:, 1);
        for l=2:l_star
            images(:, l, i) = images(:, l-1, i) + (im' * U(:, l)) * U(:, l);
        end
    end
    images = images + X_mean;
    images = reshape(images, [dataset.dim_im, l_star, dataset.Nc]);
end
