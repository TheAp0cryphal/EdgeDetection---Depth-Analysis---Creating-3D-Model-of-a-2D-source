function [K, R, t] = estimate_params(P)
% ESTIMATE_PARAMS computes the intrinsic K, rotation R and translation t from
% given camera matrix P.

%P = K*[R -R*Pc]

%Compute the camera center c by using SVD.
%Hint: c is the eigenvector corresponding to the smallest eigenvalue.
rev = [0, 0, 1 
       0, 1, 0 
       1, 0, 0];

[~,~,V] = svd(P);
c = V(1:3,end) / V(end, end);
V(4,:) = []
P = P(:,1:3);

p_rev = rev*P;
p_rev_transpose = transpose(p_rev);
[Qprime, Rprime] = qr(p_rev_transpose);

R_ = rev*Rprime'*rev;
multi = diag(sign(diag(R_)));
R_ = R_*multi;

R_ = R_/ R_(end, end);

K = R_;
R = inv(R_)*P;
t = -R*V(:,4);

end