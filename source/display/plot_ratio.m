function plot_ratio(kappa, l_star)
    figure;
    plot([0, 1], [0, kappa(1)], "b-"); hold on;
    plot(kappa, "b-s"); hold on;
    plot([l_star, l_star], [0, kappa(l_star)], "r-"); hold on;
    plot([0, l_star], [kappa(l_star), kappa(l_star)], "r--"); hold off;
    title("ratio de reconstruction");
    xlabel("l"); ylabel("$\kappa$", "interpreter", "latex")
end
