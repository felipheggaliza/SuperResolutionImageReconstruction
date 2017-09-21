close all
clear 
clc

maxNiter = 1000; % number of iterations

N = 10; % number of low-resolution images acquired with different subpixel displacements of the camera

N1 = 16; % X row dimension
N2 = 16; % X column dimension

M1 = 4; % Y_k row dimension
M2 = 4; % Y_k column dimension

X = 255*abs(rand(N1*N2,1)); % high-resolution image

W = rand(N1*N2, N1*N2, N); % Warp matrix

D = getDownsampleOperator(M1*M2, N1*N2, 2);

Y = zeros(M1*M2, N);

noise = rand(M1*M2,N);
for k=1:1:N
    Y(:, k) = D * W(:,:, k) * X + noise(:,k); % acquired image
end

%% Landweber Iteration
Xhat = 255*abs(rand(N1 * N2, N)); % estimated image
Xhat(:,1) = X;

mi = 0.001;
lambda =2;
j= 1;
Xsum = 0;
while(j < maxNiter)
    for k=1:1:N
        Xsum = Xsum + transpose(W(:,:,k)) * transpose(D) * Y(:,k) ...
            - transpose(W(:,:,k)) * transpose(D) * D * W(:,:,k) * Xhat(:,j);  
    end

    Xhat(:,j+1) = Xhat(:,j) + mi*Xsum - lambda*( Xhat(:,j) - Xhat(:,1) );
    j = j + 1
end

plot(X,'-k')

hold on

plot(Xhat(:,100),'-r')
legend('real X','X_hat')