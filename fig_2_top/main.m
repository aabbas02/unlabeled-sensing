clc
close all;
MC         = 15;
SNR        = 30;
r          = 19;
n_         = 48*r:4*r:60*r;
d          = 64;
m_         = [32 64];
m_max 	   = max(m_); 
d_H_GW     = zeros(length(n_),length(m_)); %n  times r*m
n_max      = max(n_);
X      	   = randn(d,m_max);
W_big      = randn(n_max,m_max,MC);
B_big      = randn(n_max,d);
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
            for i_m = 1 : 2
                num_views                         = m_(i_m);
				[X_hat_GW,pi_hat]                 = gw(5e-1,50,200,r,B,B*X_hat(:,1:num_views),Y_permuted_noisy(:,1:num_views));
				d_H                               = map_check(pi_,pi_hat');
				d_H_GW(j,i_m)                     = d_H/n + d_H_GW(j,i_m);
            end
        end
        j
    end
d_H_GW      = d_H_GW/MC;
get_figure_(d_H_GW,n_,r,SNR,noise_var,MC,m_,d)
saveas(gcf,['r_',num2str(r),'m_',num2str(m_),'.fig'])
save(['r_',num2str(r),'m_',num2str(m_),'.mat'],'MC','d','m_','n_','SNR','d_H_GW','r','SNR');
