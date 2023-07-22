
load Yale_64x64.mat
faceW = 64;
faceH = 64;
numPerLine = 11;
ShowLine = 2;
% Display original faces
Y = zeros(faceH*ShowLine,faceW*numPerLine); 
for i=0:ShowLine-1
    for j=0:numPerLine-1 
        Y(i*faceH+1:(i+1)*faceH,j*faceW+1:(j+1)*faceW) = reshape(fea(i*numPerLine+j+1,:),[faceH,faceW]);
    end 
end
figure; imagesc(Y);colormap(gray); axis off;

% Principal Component Analysis
X = fea';
X_mean = mean(X,2);
X_cen = X - X_mean;
r = 10; % Choose as you wish
[U,D,V] = svds(X_cen,r);
X_r = U*D*V' + X_mean;

% Plot 5 different columns of the matrix X_r as gray scale images
figure;
cols = [10, 20, 30, 40, 50];
for i=1:length(cols)
    subplot(2,3,i); imshow(reshape(X_r(:,cols(i)),[faceH,faceW]),[]); title(['Face ',num2str(cols(i))]);
end

% Plot the singular values
figure;
s = diag(D).^2 / sum(diag(D).^2);
semilogy(s,'o-'); title('Singular Values'); xlabel('Singular Value Index'); ylabel('Singular Value');

% Plot the first 5 feature vectors (columns of U) as gray scale images
figure;
for i=1:5
    subplot(1,5,i); imshow(reshape(U(:,i),[],faceW),[]); title(['PC ',num2str(i)]);
end

% Load the Yale face
load Yale_64x64.mat
faceW = 64;
faceH = 64;
numPerLine = 3;
ShowLine = 2;

% Create a matrix Y to store the images to be displayed.
Y = zeros(faceH*ShowLine,faceW*numPerLine);

% Loop over faces.
for face = [2,15,28,41,54]
    % Initialize a counter for the number of truncated SVDs computed.
    ind = 0;
    % Create a new figure.
    figure()
    % Loop over ranks.
    for r = [4 8 15]
        % Compute the mean face.
        fea_means = sum(fea,2)/size(fea,2);
        % Center the data.
        fea_centered = fea - fea_means*ones(1,size(fea,2));
        % Compute the truncated SVD.
        [U,D,V] = svds(fea_centered,r);
        % Compute the approximation of face.
        fea_r = U*D*V';
        % Extract the reconstructed face and the residual from the approximation.
        reconstructed_face = reshape(fea_r(face,:),[faceW,faceH]);
        residual_face = reshape(fea_centered(face,:)-fea_r(face,:),[faceW,faceH]);
        % Store the images to be displayed in Y.
        Y(1:64,ind*faceW+1:(ind+1)*faceW) = reconstructed_face;
        Y(65:128,ind*faceW+1:(ind+1)*faceW) = residual_face;
        % Increment the counter.
        ind = ind + 1;
    end
    % Display the images stored in Y.
    imagesc(Y);
    colormap(gray);
end

