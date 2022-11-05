function plot_gaussian_component(dataset, face_id, w, mu)
    w_f = zeros(3, size(w, 1), min(dataset.size_cls));
    mu = mu(:, face_id);
    for i = 1:3
        w_f(i, :, :) = w(:, dataset.border(face_id(i)): dataset.border(face_id(i)+1)-1);
    end
    figure;
    for i = 1:4
        subplot(2, 2, i);
        plot_couple(w_f, mu, i, i+1);
    end
    hold off;
    
    sgtitle("Principal components");
end

function plot_couple(w, mu, a, b)
    N = size(w, 3);
    colors = ["r", "g", "b"];

    for i = 1:3
        X_w = reshape(w(i, a, :), [N, 1]);
        Y_w = reshape(w(i, b, :), [N, 1]);
        plot(X_w, Y_w, "*" + colors(i)); hold on;
    end
    for i = 1:3
        plot(mu(a, i), mu(b, i), "s", "MarkerEdgeColor", "k", "MarkerFaceColor", colors(i)); hold on;
    end
    title("(" + a + "," + b + ")");
end
