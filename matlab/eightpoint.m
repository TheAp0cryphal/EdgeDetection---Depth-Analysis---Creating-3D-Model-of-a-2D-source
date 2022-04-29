function F = eightpoint(pts1, pts2, M)
% eightpoint:
%   pts1 - Nx2 matrix of (x,y) coordinates
%   pts2 - Nx2 matrix of (x,y) coordinates
%   M    - max (imwidth , imheight)

% Q2.1 - Todo:
%     Implement the eightpoint algorithm
%     Generate a matrix F from correspondence '../data/some_corresp.mat'

pts1 = pts1 ./ M;
pts2 = pts2 ./ M;
n = size(pts1, 1);

x1 = pts1(:, 1);
x2 = pts2(:, 1);
y1 = pts1(:, 2);
y2 = pts2(:, 2);

for i = 1:n
    Mat(i,:) = [times(x1(i), x2(i)), times(x1(i), y2(i)), x1(i), times(y1(i), x2(i)), times(y1(i),y2(i)), y1(i), x2(i), y2(i), 1];
end
%Fundamental Matrix
[~, ~, V] = svd(Mat);

% right singular least value
mtx = V(:,9);
mtx = reshape(mtx, 3, 3);

%Rank 2 constraint
[U, S ,V] = svd(mtx);

S(3, 3) = 0;
V = transpose(V);
F = U*S*V;

F_ = refineF(F, pts1, pts2);

scale = [1/M 0 0; 0 1/M 0; 0 0 1];
scale_ = transpose(scale);

F = scale_*F_*scale;
disp(F);
end




