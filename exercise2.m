clear all
close all
load('HandwrittenDigits.mat');


% Extract images for digits 0, 1, 3, and 7
digit_indices = find(I == 0 | I == 1 | I == 3 | I == 7);
digit_images = X(:, digit_indices);

% Select 5 samples from each subgroup
num_samples = 5;
samples = [];
for digit = [0, 1, 3, 7]
    digit_indices = find(I == digit);
    digit_images = X(:, digit_indices);
    samples = digit_images(:,1:5);


% Compute principal components of X
[U, ~, ~] = svd(digit_images);

% Compute approximations for each sample and plot results
ks = [5, 10, 15, 20, 25];
for i = 1:size(samples, 2)
    figure;
    for j = 1:length(ks)
        k = ks(j);
        % Compute approximation using k principal components
        z = U(:, 1:k)' * samples(:, i);
        approx = U(:, 1:k) * z;
        
        % Compute residual
        residual = samples(:, i) - approx;
        
        % Plot approximation and residual
        subplot(2, length(ks), j);
        imshow(reshape(approx, [16, 16])', []);
        title(sprintf('k = %d', k));
        
        subplot(2, length(ks), j + length(ks));
        imshow(reshape(residual, [16, 16])', []);
    end
end
end
% Initialize vector to store norms of errors
error_norms = zeros(length(ks), size(samples, 2));

% Compute errors for each sample and store norms
for i = 1:size(samples, 2)
    for j = 1:length(ks)
        k = ks(j);
        % Compute approximation using k principal components
        z = U(:, 1:k)' * samples(:, i);
        approx = U(:, 1:k) * z;
        
        % Compute residual and store norm
        residual = samples(:, i) - approx;
        error_norms(j, i) = norm(residual);
    end
end

% Plot norms of errors as a function of k
figure;
plot(ks, error_norms(:,1), '-o');
xlabel('k');
ylabel('Norm of error');
legend('residuo');