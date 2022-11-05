%% init
close all; clear; clc;
addpath("compute", "display", "inputs");

%% Parameters
l = 8; % l > 4 ou commenter plot_gaussian_component(...);

%% dataset extraction
train = data_extraction('../database/training1/');
tests = data_extraction('../database/test1/');

%% Compute
[U, ~] = eigenfaces(train.images);

% image projection on the main eigen faces
w_train = center_project_firsts(train.images, U, l);
w_tests = center_project_firsts(tests.images, U, l);

% classification
[mu, sigma] = intra_stat(train, w_train);
label_est = class_gaussian(w_tests, train.label, mu, sigma);

% evaluation
confusion = confmat(label_est, tests.label);
err_score = global_error(confusion, []);

%% Display
plot_gaussian_component(train, [1, 2, 3], w_train, mu);
plot_confmat(confusion);
display(err_score);
