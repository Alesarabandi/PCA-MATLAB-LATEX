close all
clear all
load('IrisDataAnnotated.mat');

% Center the data
p = size(X,2);
X_mean = 1/p * sum(X,2);
X_centered= X - X_mean * ones(1,p);


% Perform PCA
[U, S, V] = svd(X_centered);

% Project the data onto the first two principal components
Z = U(:,1:2)' * X_centered ;

% Plot the data in the new 2D space
figure;
plot(Z(1,:), Z(2,:),'k.','MarkerSize',10);
xlabel('PC1');
ylabel('PC2');
title('Iris dataset projected onto the first two principal components');


