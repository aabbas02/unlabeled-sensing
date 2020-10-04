function [check_unique,check_local] =  check_idx (idx_B,idx_Y,d,n,r)
    check_unique =  length(unique(idx_B(1:d-(n/r)))) == d-(n/r) & length(unique(idx_Y(1:d-(n/r)))) == d-(n/r);
    check_local  = 1;
    for i = 1 : n
        blk_number_B = floor((idx_B(i)-1)/r);  %0,1,2,3,4,5,....n/r-1
        blk_number_Y = floor((idx_Y(i)-1)/r);
        check_local  = check_local & (blk_number_B == blk_number_Y);
    end
end