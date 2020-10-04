function [pi_hat] = levsort(B,Y,r)
    n = size(B,1);
    pi_hat = zeros(n,n);
    [U_B,~,~] = svd(B,'econ');
    [U_Y,~,~] = svd(Y,'econ');
    u_b = diag(U_B*U_B');
    u_y = diag(U_Y*U_Y');
    for i = 1 : n/r
        [~,idx_B] = sort(u_b((i-1)*r+1:i*r));
        [~,idx_Y] = sort(u_y((i-1)*r+1:i*r));
        idx_B = (i-1)*r + idx_B;
        idx_Y = (i-1)*r + idx_Y;
        for j = 1 : r
            pi_hat(idx_Y(j),idx_B(j)) = 1;
        end
    end
end