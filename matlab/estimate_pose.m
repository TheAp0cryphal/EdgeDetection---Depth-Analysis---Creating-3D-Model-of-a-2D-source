function P = estimate_pose(x, X)
% ESTIMATE_POSE computes the pose matrix (camera matrix) P given 2D and 3D
% points.
%   Args:
%       x: 2D points with shape [2, (X1(i, 1))]
%       X: 3D points with shape [3, (X1(i, 1))]

x_t=x';
X_T=X';
Mat = [];

  for i=1:size(x_t, 1)    
    x = x_t(i, 1);
    y = x_t(i, 2);
    
    Mat = [
      Mat; 
      (X_T(i, 1)), (X_T(i, 2)), (X_T(i, 3)), 1, 0, 0, 0, 0, -x*(X_T(i, 1)), -x*(X_T(i, 2)), -x*(X_T(i, 3)), -x; 
      0, 0, 0, 0, (X_T(i, 1)), (X_T(i, 2)), (X_T(i, 3)), 1, -y*(X_T(i, 1)), -y*(X_T(i, 2)), -y*(X_T(i, 3)), -y  
    ];

  end
    [~,~,V] = svd(Mat);        
    singular = V(:,size(V,2));      
    P = reshape(singular, 4, 3)';
end
