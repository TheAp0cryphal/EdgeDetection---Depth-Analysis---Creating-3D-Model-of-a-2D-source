function depthM = get_depth(dispM, K1, K2, R1, R2, t1, t2)
% GET_DEPTH creates a depth map from a disparity map (DISPM).
c1 = -inv(K1*R1) * (K1*t1);
c2 = -inv(K2*R2) * (K2*t2);

b = norm(c2 - c1);

f = K1(1,1)

depthM = zeros(size(dispM));
for i = 1: size(dispM,2)
    for j = 1: size(dispM,1)
        if dispM(j,i) == 0
            depthM(j,i) = 0;
        else          
            depthM(j,i) = (b*f)/dispM(j,i);
        end
    end
end