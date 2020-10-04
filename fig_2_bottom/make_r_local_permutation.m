function [pi_map] = make_r_local_permutation(n,r)
pi_map = zeros(n,n);
for i = 1 : n/r
   col = randsample(r,r);
   col = col + (i-1)*r;
   for j = 1 : r
        pi_map((i-1)*r+j,col(j))= 1;
   end
end
