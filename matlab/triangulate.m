function pts3d = triangulate(P1, pts1, P2, pts2 )
% triangulate estimate the 3D positions of points from 2d correspondence
%   Args:
%       P1:     projection matrix with shape 3 x 4 for image 1
%       pts1:   coordinates of points with shape N x 2 on image 1
%       P2:     projection matrix with shape 3 x 4 for image 2
%       pts2:   coordinates of points with shape N x 2 on image 2
%
%   Returns:
%       Pts3d:  coordinates of 3D points with shape N x 3
%

[n1,~] = size(pts1);
[n2,~] = size(pts2);
p_size = size(pts1,1);
p1 = [pts1'; ones(1,n1)];
p2 = [pts2'; ones(1,n2)];

for i = 1:p_size
   
    Mat1 = [0 p1(3,i) -p1(2,i);    -p1(3,i) 0 p1(1,i);
        p1(2,i) -p1(1,i) 0];        
    Mat2 = [0 p2(3,i) -p2(2,i);    -p2(3,i) 0 p2(1,i);
        p2(2,i) -p2(1,i) 0];

    
    conc = [Mat1* P1; Mat2*P2];   
    [~, ~, v] = svd(conc);
    
    v = v(:, end);
    
    pt3d(:,i) = v/v(4); %diving by 4th column
    
end
pts3d = pt3d(1:3,:);







