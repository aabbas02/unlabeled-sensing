function [B_tilde,y_tilde,x_init,X_hat] =  OneD_Sort (B,y,r)
    n        = size(B,1);
    d        = size(B,2);
    max_iter = d - (n/r);
    idx_B = zeros(n,1); %at iteration#num_iter, idx_B(num_iter) = p_star
    idx_Y = zeros(n,1); %at iteration#num_iter, idx_B(num_iter) = q_star
    idx_K = 1:(n/r);
    B_tilde = zeros(n/r,d);
    y_tilde = zeros(n/r,1);
    for i = 1:n/r
        B_tilde(i,:) = sum(B( (i-1)*r+1:i*r,: ) );
        y_tilde(i)   = sum(y( (i-1)*r+1:i*r ) );
    end
    x_init   = B_tilde\y_tilde;
    num_iter = 0;
    while (num_iter < max_iter)
        y_hat = B*( B_tilde(1:(n/r)+num_iter,:)\y_tilde(1:(n/r)+num_iter) ) ;
        for i = 1:length(idx_K)
            k = idx_K(i);                %%%block-no
            blk_idx = (k-1)*r+1:k*r;     %%%offset indices
            p = setdiff(blk_idx,idx_B);  %%%idx_B = zero-entries do not effect set_diff 
            q = setdiff(blk_idx,idx_Y);
            [p] = sub_sort(y_hat(blk_idx),p,r,k); %p,q are offset indices  (both input and output)
            [q] = sub_sort(y(blk_idx),q,r,k);
            %if(norm(y_hat(p) - y(q),2) < norm(flip(y_hat(p)) - y(q),2))
               % sprintf('identity')
            %else
               % sprintf('anti-identity')
            %end
            for j = 1 : length(p)
                B_tilde((n/r)+num_iter+1,:) = B(p(j),:);  %overwrite multiple times
                y_tilde((n/r)+num_iter+1) 	= y(q(j));    %overwrite multiple times
                err =  norm(y - B*( (B_tilde(1:(n/r)+num_iter+1,:)\y_tilde(1:(n/r)+num_iter+1)) ));
                if(i==1 && j == 1)
                    min    = err;
                    p_star = p(j);
                    q_star = q(j);
                    i_star = i;
                elseif (err < min)                 %min is always defined via preceding if
                    min    = err;
                    p_star = p(j);
                    q_star = q(j);
                    i_star = i;    
                end
            end
        end
        B_tilde((n/r)+num_iter+1,:) = B(p_star,:);      %final augmentation-B
        y_tilde((n/r)+num_iter+1) 	= y(q_star);        %final augmentation=Y
        idx_B(num_iter+1)=p_star;                       %augment matched indices
        idx_Y(num_iter+1)=q_star;
        k_star=idx_K(i_star);
        blk_idx=(k_star-1)*r+1:k_star*r;
        if( length(intersect( blk_idx,idx_B) ) ==  r-1) %%%extra zeros do not matter in intersection
            idx_K(i_star) = [];                         %r-1 equations learnt from block#k_star --> remove block# k_star at idx(k_i)
        end
    num_iter = num_iter + 1;
    end
	%[check_unique,check_local] = check_idx(idx_B,idx_Y,d,n,r);
    %if(~(check_unique == 1 && check_local == 1))
    %    sprintf('unique = %d , local = %d',check_unique,check_local)
    %end
    X_hat = B_tilde\y_tilde;
end