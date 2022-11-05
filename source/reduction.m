%% Init
close all; clear; clc;
addpath("compute", "display", "inputs");

%% Parameters
ratio = 0.9;

%% Dataset extraction
train = data_extraction('../database/training1/');

%% Compute
[U, D] = eigenfaces(train.images);

% needed dimensions to reach the needed ratio
[l_star, kappa] = facespace_energy(D, ratio);

% Image reconstructions
images = image_reduction(train, U, l_star);

%% Display
plot_ratio(kappa, l_star);
plot_eigenfaces(U, train);
plot_image_reduction(images, train);
