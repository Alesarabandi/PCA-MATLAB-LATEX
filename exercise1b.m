% Load the data
load('ModelReductionData.mat');

% Center the data by subtracting the mean of each row (dimension) from each data point
X_centered = X - mean(X,2);

% Compute the SVD of the centered data
[U,S,V] = svd(X_centered);

% Plot singular values

sing_values = diag(S);

plot(sing_values,'Ko','LineWidth',3,'MarkerSize',10)

set(gca,'FontSize',12);

xlabel('Principal Components')

ylabel('Singular Values')

title('Behaviour of singular values')

grid on

% Scatterplot of first two principal components

Z = U(:,1:2)' * X_centered;

figure(2)

plot(Z(1,:),Z(2,:),'k.','MarkerSize',3)

set(gca,'FontSize',18)