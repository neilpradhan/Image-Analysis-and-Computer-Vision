function [segmentation, centers, empty, cen_idx, count] = kmeans_segm1(image, K, L, seed, RANDSAM, Keepingthreshold)
N= size(image, 1);%image size rows N
M = size(image, 2);%image size  columns M
Ivec = reshape(double(image),N*M, 3);%Image vector or list of points on which we will apply KNN
delta = 100 * ones(K, 3);% for thresholding
clus_centers = zeros(K, 3);% cluster centers
clus_centers_new = zeros(K, 3);% new cluster centers
idx_old = zeros(1, N*M);% Index initialisation
empty = false;% some variable initialisation
threshold = 0.01;
count = 0;

% Let X be a set of pixels and V be a set of K cluster centers in 3D (R,G,B).
if  RANDSAM == true
    % Randomly initialize the K cluster centers
    rng(seed, 'twister');
    idx = randsample(N*M, K);% remove K numbers from numbers between 1 to MN
    for i = 1 : K
        clus_centers(i, :) = Ivec(idx(i), :);% randomly select cluster centers
    end
else
    [~, clus_init] = kmeansplus_init(Ivec', K, seed);% K meansplus method to initialise the cluster centers
    clus_centers = clus_init';
end

% Compute all distances between pixels and cluster centers
D = pdist2(clus_centers, Ivec, 'euclidean');% this is a matrix of "K X MN"

if Keepingthreshold == false
    % Iterate L times
    for i = 1 : L
        % Assign each pixel to the cluster center for which the distance is
        % minimum Di,j will give the eucledian combination between ith row of cluster_center with the jth row of Ivec(reshaped img)
        [~, cen_idx] = min(D);% for every column of D cen_idx takes the index of lowest value hence every every vvalue of cen_idx is between 1 and K
        
        % Recompute each cluster center by taking the mean of all pixels assigned to it
        for j = 1 : K
            n_idx = find(cen_idx == j);% n_idx gives the cen_idx index(col) where the condition satisfies. size(n_idx) not eq to size(cen_idx)
            if isempty(n_idx) == true
                empty = 1;
                n = randsample(N*M, 1);% take a value randomly if empty coz we have to make K cluster centers anyways
                clus_centers(j, :) = Ivec(n, :);
%               clus_centers(j, :) = (max(Ivec) - min(Ivec)) .* rand(1, 3) + min(Ivec);
            else
                clus_centers(j, :) = mean(Ivec(n_idx, :));%regardless values in n_idx the mean shall be 
            end
        end
        % Recompute all distances between pixels and cluster centers
        D = pdist2(clus_centers, Ivec, 'euclidean');
    end
else
    %keepingthreshold
    while (max(delta(:)) > threshold)
        [~, cen_idx] = min(D);
        for j = 1 : K
            n_idx = find(cen_idx == j);
            if isempty(n_idx) == true
                empty = 1;
                n = randsample(N * M, 1);
                clus_centers_new(j, :) = Ivec(n, :);
            else
                clus_centers_new(j, :) = mean(Ivec(n_idx, :));
            end
        end
        delta = abs(clus_centers_new - clus_centers);
%         delta = abs(idx_old - cen_idx);
        count = count + 1;
        D = pdist2(clus_centers_new, Ivec, 'euclidean');
        clus_centers = clus_centers_new;
%         idx_old = cen_idx;

    end
   
end

[~, cen_idx] = min(D);
segmentation = reshape(cen_idx,N,M);
centers = clus_centers;