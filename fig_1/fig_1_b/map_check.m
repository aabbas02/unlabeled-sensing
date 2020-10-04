function [err] = map_check(pi_o,pi_hat)
err   = 0;
[n,~] = size(pi_o);
    for i = 1 : n
         [~,j1]   = max(pi_o(i,:));
         [~,j2]   = max(pi_hat(i,:));
		 err      = err + (j1 ~= j2);
    end
end