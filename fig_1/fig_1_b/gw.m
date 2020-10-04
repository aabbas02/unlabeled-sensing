function [X_hat,pi_hat] = gw(epsilon,niter,niter_SHORN,radius,B,Y_hat,Y)
	[n,~] = size(Y);
	gamma_est = zeros(n,n);
	pi_hat = zeros(n,n);
    for i = 1 : n/radius
			source     = normc(Y_hat( (i - 1)*radius + 1 : i*radius , :));
			target     = normc(Y    ( (i - 1)*radius + 1 : i*radius , :));
			source     = source*source';
			target     = target*target';
			[gamma,check] = gw_l2_modified(source,target,epsilon,niter,niter_SHORN,radius);
            if(check > 0)
				sprintf('Epsilon = %d too small',epsilon)
            end
		gamma_est( (i - 1)*radius + 1 : i*radius , (i - 1)*radius + 1 : i*radius ) = gamma;
    end 
    for i = 1 : n
	    [~,pi_col] =  max(gamma_est(i,:)); 
        gamma_est(:,pi_col) = 0;
		pi_hat(i,pi_col) = 1;
    end
 	X_hat =  B\(pi_hat*Y);
end

