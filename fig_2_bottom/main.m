clc
close all;
MC         = 25;
SNR        = 30;
r_         = 11;
n_         = 48*r_:4*r_:60*r_;
d          = 64;
m_         = 64;
m_max 	   = max(m_); 
d_H_GW     = zeros(length(n_),length(r_)); %n  times r*m
d_H_lev    = zeros(length(n_),length(r_)); %n  times r*m
n_max      = max(n_);
X      	   = randn(d,m_max);
W_big      = randn(n_max,m_max,MC);
B_big      = randn(n_max,d);
for i = 1 : length(r_)
    r      = r_(i);
    for j = 1 : length(n_)
		n           = n_(j);
		B           = B_big(1:n,:);
		Y_          = B*X;
		X_          = X*diag(1./sqrt(diag(Y_'*Y_)));
		Y_          = Y_*diag(1./sqrt(diag(Y_'*Y_)));
        pi_         = make_r_local_permutation(n,r);
        Y_permuted  = pi_*Y_;
        noise_var   = 1  / ( 10^(SNR/10) * n );
        for k = 1 : MC
            Y_permuted_noisy = Y_permuted + sqrt(noise_var)*W_big(1:n,:,k);
            X_hat            = zeros(d,m_max);
            for m = 1 : m_max
                [~,~,~,X_hat(:,m)]  = OneD_Sort(B,Y_permuted_noisy(:,m),r);
            end
            for i_m = 1 : length(m_)
                num_views                         = m_(i_m);
				[~,pi_hat]                        = gw(5e-1,50,200,r,B,B*X_hat(:,1:num_views),Y_permuted_noisy(:,1:num_views));
				d_H                               = map_check(pi_,pi_hat');
                d_H_GW(j,i+((i_m-1)*length(r_)))  = d_H/n + d_H_GW(j,i+(i_m-1)*length(r_));
                pi_hat                            = levsort(B,Y_permuted_noisy(:,1:num_views),r);
                d_H                               = map_check(pi_,pi_hat);
                d_H_lev(j,i+((i_m-1)*length(r_))) = d_H/n + d_H_lev(j,i+(i_m-1)*length(r_));
            end
        end
       j 
    end
end
d_H_GW      = d_H_GW/MC;
d_H_lev     = d_H_lev/MC;
get_figure_(d_H_GW,d_H_lev,n_,r_,SNR,noise_var,MC,m_,d)
saveas(gcf,['r_14.fig'])
save(['r_14.mat'],'MC','d','m_','n_','SNR','d_H_GW','d_H_lev','r_','noise_var');
