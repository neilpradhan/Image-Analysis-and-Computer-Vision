function [prob, centers] = mixture_prob(image, K, L, mask)
N = size(image, 1);
M = size(image, 2);
Ivec = im2double(reshape(image, N*M, 3));% Image matrix into NM X 3(r,g,b)
Mvec = reshape(mask,N*M,1);% vector of given mask- mask contains which pixels are taken(1) and which are neglected(0)
Ima = Ivec(find(Mvec == 1), :);% Store all pixels for which mask=1 in a Nx3 matrix
g = zeros(size(Ima, 1), K);% initialisation of M X K matrix
g1 = zeros(N*M, K);% initialisation of NM X K matrix

% Randomly initialize the K components using masked pixels
%[segmentation, centers, empty, cen_idx, count] = kmeans_segm1(Ima, K, L,1500,true, false)
[segmentation, centers,~,~,~] = kmeans_mix(Ima, K, L, 1400,true,false)
cov = cell(K, 1);
cov(:) = {rand * eye(3)};% randomly filling the covariance matrices

w = zeros(1, K);
for i = 1 : K
    w(i) = sum(segmentation == i) / size(segmentation, 1);% segmentation is reshape of cen_idx which is MN X 1 matrix with values from 1 to K reshaped to N X M
end

% Iterate L times
for i = 1 : L
%Expectation: Compute probabilities P_ik using masked pixels
    for k = 1 : K
        mean_k = centers(k, :);% mean_ k is of the dimension k X 3
        cov_k = cov{k};% innitila covariance will be random
        diff = bsxfun(@minus, Ima, mean_k); % difference between 2 matrices can be of different length like subtr. mean colour.(here 3)
        g(:, k) = 1 / sqrt(det(cov_k) * (2 * pi)^3) * exp(-0.5 *...
            sum((diff * inv(cov_k) .* diff), 2));% kth gaussian component defined
    end
    p = bsxfun(@times, g, w);%probability distribution Wk X gk dimension of p is M X K
    norm = sum(p, 2);% norm is a col vector giving sum of each row in p
    p = bsxfun(@rdivide, p, norm);% this is how much of pixel i comes from kth Gaussian component,
    
%   Maximization: Update weights, means and covariances using masked pixels
    w = sum(p, 1) / size(p, 1);% update weight
    for k = 1 : K
        centers(k, :) = p(:, k)' * Ima / sum(p(:, k), 1); % update center
        diff = bsxfun(@minus, Ima, centers(k, :));% difference of value and mean for calculating covariance
        cov{k} = (diff' * bsxfun(@times, diff, p(:, k))) / sum(p(:, k), 1);% updating covariance
    end
end

% Compute probabilities p(c_i) in Eq.(3) for all pixels I
for k = 1 : K
    diff = bsxfun(@minus, Ivec, centers(k, :));
    g1(:, k) = 1 / sqrt(det(cov{k}) * (2 * pi)^3) * exp(-0.5 *...
            sum((diff * inv(cov{k}) .* diff), 2));
end
prob = sum(bsxfun(@times, g1, w), 2);
prob = reshape(prob,N,M, 1);

