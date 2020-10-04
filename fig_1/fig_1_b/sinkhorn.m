function [gamma,u] = sinkhorn(K,mu1,mu2,niter_sinkhorn,u_init)
u       =  u_init; 
for i = 1 : niter_sinkhorn
    v = mu2 ./ (K'*u);
    u = mu1 ./ (K*v);
end
gamma = diag(u)*K*diag(v);
end
