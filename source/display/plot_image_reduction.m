function plot_image_reduction(rec_img, dataset)
    figure;
    l_star = size(rec_img, 3);
    Nc = length(dataset.size_cls);
    id = 1;
    for i = 1:Nc
        for l=1:l_star
            subplot(Nc, l_star+1, (i-1)*(l_star+1) + l + 1);
            imagesc(rec_img(:, :, l, i));
            colormap("gray");
            axis off;
            title(l);
        end
        subplot(Nc, l_star+1, (i-1)*(l_star+1) + 1);
        imagesc(reshape(dataset.images(:, id), dataset.dim_im));
        id = id + dataset.size_cls(i);
        colormap("gray");
        axis off;
        title("original");
    end
    sgtitle("Image reconstructions");
end
