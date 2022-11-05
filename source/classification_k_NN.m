%% init
close all; clear; clc;
addpath("compute", "display", "inputs");

%% Parameters
l = 8;
k = 9;

%% dataset extraction
train = data_extraction('../database/training1/');
tests = data_extraction('../database/test1/');

%% Compute
[U, ~] = eigenfaces(train.images);

% image projection on the main eigen faces
w_train = center_project_firsts(train.images, U, l);
w_tests = center_project_firsts(tests.images, U, l);

% classification
label_est = class_k_NN(w_train, w_tests, train.label, k);

% evaluation
confusion = confmat(label_est, tests.label);
err_score = global_error(confusion, []);

%% Display
plot_confmat(confusion);
display(err_score);
