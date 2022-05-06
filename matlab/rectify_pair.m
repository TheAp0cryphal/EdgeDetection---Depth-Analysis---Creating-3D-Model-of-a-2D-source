function [M1, M2, K1n, K2n, R1n, R2n, t1n, t2n] = ...
                        rectify_pair(K1, K2, R1, R2, t1, t2)
% RECTIFY_PAIR takes left and right camera paramters (K, R, T) and returns left
%   and right rectification matrices (M1, M2) and updated camera parameters. You
%   can test your function using the provided script testRectify.m

%Compute the optical center c1 and c2 of each camera by c = −(KR)^{−1}(Kt).
c1 = inv(K1*R1) * -(K1*t1);
c2 = inv(K2*R2) * -(K2*t2);

%Compute the new rotation matrix  where r1 , r2 , r3 ∈ R3×1 are orthonormal vectors that represent x-, y-, and z-axes of the camera reference frame, respectively.
%The new x-axis (r1) is parallel to the baseline: r1 = (c1 − c2)/∥c1 − c2∥.
%The new y-axis (r2) is orthogonal to x and to any arbitrary unit vector, which we set to be the z unit vector of the old left matrix: r2 is the cross product of R1(3, :) and r1.
%The new z-axis (r3) is orthogonal to x and y: r3 is the cross product of r2 and r1.

r1 = (c1-c2)/norm(c1-c2);
r2 = (cross(R1(3, :), r1))';
r2 = r2/norm(r2);
r3 = (cross(r2, r1));
r3 = r3/norm(r3);

R1n = [r1, r2, r3].'; %R1n
R2n = R1n;

%Compute the new intrinsic parameter. 
%We can use an arbitrary one. In our test code, we just let = K2.

K1n = K1;
K2n = K1;

%Compute the new translation:  t1n=R −c1,  t2n=R −c2.
t1n = -R1n * c1; 
t2n = -R2n * c2; 


%Finally, the rectification matrix of the first camera can be obtained by
M1 = (K1n*R1n)*inv(K1*R1);
M2 = (K1n*R2n)*inv(K1*R2);





