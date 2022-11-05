function plot_eigenfaces(U, dataset)
    figure;
    j_max = max(dataset.size_cls);
    N = dataset.N-1;
    for i = 1:dataset.Nc
        for j = 1:j_max
            if ((i-1)*j_max + j == N)
                break;
            end
            subplot(dataset.Nc, j_max, (i-1)*j_max + j);
            imagesc(reshape(U(:, (i-1)*j_max + j), dataset.dim_im));
            colormap("gray");
            axis off;
        end
    end
    sgtitle("Eigen faces");
end
