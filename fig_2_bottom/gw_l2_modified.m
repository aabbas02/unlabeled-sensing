function [gamma,check] = gw_l2_modified(source,target,epsilon,niter,niter_SHORN,radius)
        f1 = @(a)a^2;  
        f2 = @(b)b^2;
        h1 = @(a)a;
        h2 = @(b)b; 
mu1    = 1/radius * ones(radius,1);
mu2    = 1/radius * ones(radius,1);
n 	   = length(mu1);
GWcst  = f1(source)*mu1*ones(n,1)' +  ones(n,1)*mu2'*f2(target');
gamma  = mu1*mu2';
u_init = ones(length(mu1),1);
for i = 1 : niter
    C  			= -2 * h1(source)*gamma*h2(target')+ GWcst;    %%%Changed from Peyre 
    K  			= exp(-C/epsilon);
    [gamma,u]   = sinkhorn(K,mu1,mu2,niter_SHORN,u_init);
    u_init      = u;  								 		   %%%Warm Restart
    check 		= sum(isnan(gamma(:)));
    if(check > 0)
        break
    end
end


