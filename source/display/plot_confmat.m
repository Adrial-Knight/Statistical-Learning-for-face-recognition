function plot_confmat(confmat)
    figure;
    imagesc(confmat);
    colormap("gray");
    title("Matrice de confusion");
    caxis([0, 1]);
    colorbar;
end
