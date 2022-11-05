%% init
close all; clear; clc;
addpath("compute", "display", "inputs");

%% Parameters
l = 8;
hiden_face = [5, 6];

%% dataset extraction
train = data_extraction('../database/training1/');
tests = data_extraction('../database/test1/');

[train, tests] = remove_face(train, tests, hiden_face);

%% Compute
[U, ~] = eigenfaces(train.images);

w_train = center_project_firsts(train.images, U, l);
w_tests = center_project_firsts(tests.images, U, l);

[train.mu, train.sigma] = intra_stat(train, w_train);
mean_pixel_test = (1/tests.N)*sum(tests.images(:, :), 2);

X_test = NaN*ones(tests.P, tests.N);
for j = 1:tests.N
    X_test(:, j) = (1/sqrt(tests.N))*(tests.images(:, j)-mean_pixel_test);
end

means_test = NaN*ones(l, tests.Nc);
for j = 1:tests.Nc
    means_test(:, j) = (1/tests.size_cls(j))*sum(w_tests(:, tests.border(j):tests.border(j)+tests.size_cls(j)-1), 2);
end

sigma = zeros*ones(l);
for j = 1:train.Nc
    for i = tests.border(j):tests.border(j)+tests.size_cls(j)-1
        sigma = sigma+(w_tests(:, i)-mean_pixel_test(j))*(w_tests(:, i)-mean_pixel_test(j))';
    end
end
sigma = sigma/tests.N;


N_pts = 1e3;
t = 0:2*pi/N_pts:2*pi-2*pi/N_pts;

mean_pixel_train = NaN*ones(l, train.Nc);
for j = 1:train.Nc
    mean_pixel_train(:, j) = (1/train.size_cls(j))*sum(w_train(1:l, train.border(j):train.border(j)+train.size_cls(j)-1), 2);
end

ellipses((train.Nc-1)*(l-1)) = struct("classe", [], "couple", [], "courbe", [], "V", [], "lambda", []);
for n = 1:train.Nc-1
    for i = 1:l-1
        data = w_train(i:i+1, train.border(n):train.border(n)+train.size_cls(n)-1)';
        centre = mean_pixel_train(i:i+1, n);
        [E, V, lambda] = ellipse(data, t, centre);
        ellipses((n-1)*(l-1)+i).classe = n;
        ellipses((n-1)*(l-1)+i).couple = i;
        ellipses((n-1)*(l-1)+i).courbe = E;
        ellipses((n-1)*(l-1)+i).V = V;
        ellipses((n-1)*(l-1)+i).lambda = lambda;
    end
end

scores = zeros(tests.N, train.Nc-1);
for i = 1:tests.N
    for j = 1:train.Nc-1
        sum = 0;
        for k = 1:l-1
            boolean = in_ellipse(w_tests(k:k+1, i), mean_pixel_train(k:k+1, j), ellipses((j-1)*(l-1)+k).V, ellipses((j-1)*(l-1)+k).lambda);
            sum = sum+boolean;
        end
        scores(i, j) = sum;
    end
end

est_lb_gaussien_bonus = Inf * ones(tests.N, 1);
all_cls = unique(train.label);
for i = 1:tests.N
    [M, index] = max(scores(i, :));
    if M >= 5
        est_lb_gaussien_bonus(i, 1) = all_cls(index);
    end
end

confusion = confmat(est_lb_gaussien_bonus, tests.label);
plot_confmat(confusion)

clearvars -except tests train confusion est_lb_gaussien_bonus