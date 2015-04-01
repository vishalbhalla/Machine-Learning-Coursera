function idx = findClosestCentroids(X, centroids)
%FINDCLOSESTCENTROIDS computes the centroid memberships for every example
%   idx = FINDCLOSESTCENTROIDS (X, centroids) returns the closest centroids
%   in idx for a dataset X where each row is a single example. idx = m x 1 
%   vector of centroid assignments (i.e. each entry in range [1..K])
%

% Set K
K = size(centroids, 1);

% You need to return the following variables correctly.
idx = zeros(size(X,1), 1);

% ====================== YOUR CODE HERE ======================
% Instructions: Go over every example, find its closest centroid, and store
%               the index inside idx at the appropriate location.
%               Concretely, idx(i) should contain the index of the centroid
%               closest to example i. Hence, it should be a value in the 
%               range 1..K
%
% Note: You can use a for-loop over the examples to compute this.
%

m = size(X,1);
n = size(X,2);
% d = zeros(1,K);
% 
% for i = 1:m
%     d = zeros(1,K);
%      for j = 1:K
%          for k = 1:n
%              d(j) = d(j) + (X(i,k) - centroids(j,k)).^n;
%          end;
%      end;
%      [~,idx(i)] = min(d);
% end;


% Code changes to satisfy Test case 2 b. for n dimesnions.
% X = magic(8);
% X = X(:, 2:4);
% centroids = magic(4);
% centroids = centroids(:,2:4);
% findClosestCentroids(X, centroids)

SumSqDiffErr = zeros(K,n);
for i = 1:m
    for j = 1:K
        SqDiffErr = X(i,:) - centroids(j,:);
        SumSqDiffErr(j,:) = sum(SqDiffErr.^2,2);
    end;
    [~,idx(i)] = min(SumSqDiffErr(:));
end;


% SumSqDiffErr = zeros(m,n);
% for j = 1:K
%         SqDiffErr = X - centroids(j);
%         t = sum(SqDiffErr.^2,2);
%         SumSqDiffErr(:,j) = sum(SqDiffErr.^2,2);
% end;
% [~,idx] = min(SumSqDiffErr,[],2);

% =============================================================

end

