function [idx_sub] =  sub_sort (array,idx,r,k)
%Sort input array over subset of indices (these indices are offset where offset is a function of r,k) in idx and return sorted indices
%in idx_sub---r(radius),k(block#) required to offset local indices to global indices
[~,idx_sub] = sort(array);
idx_sub = (k-1)*r + idx_sub;   %the preceding sort operation removes offset from the indices, add it back
idx_sub = intersect(idx_sub,idx,'stable');    
end