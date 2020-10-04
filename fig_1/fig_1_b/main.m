clc
close all;
MC           = 25;
SNR          = 30;
n_           = [440];
r_           = [8];
d            = 64;
m_           = (8:8:128);
m_max 	     = max(m_); 
n_max        = max(n_);
X      	     = randn(d,m_max);
W_big        = randn(n_max,m_max,MC);
B_big        = randn(n_max,d);
err_C_Y      = zeros(1,length(m_));
for i = 1 : length(r_)
    r      = r_(i);
    for j = 1 : length(n_)
		n           = n_(j);
		B           = B_big(1:n,:);
		Y_          = B*X;
		X_          = X*diag(1./sqrt(diag(Y_'*Y_)));
		Y_          = Y_*diag(1./sqrt(diag(Y_'*Y_)));
		C_Y         = Y_*Y_';
        pi_         = make_r_local_permutation(n,r);
        Y_permuted  = pi_*Y_;
        noise_var   = 1  / ( 10^(SNR/10) * n );
        for k = 1 : MC
            Y_permuted_noisy = Y_permuted + sqrt(noise_var)*W_big(1:n,:,k);
            X_hat            = zeros(d,m_max);
            for m = 1 : m_max
                [~,~,~,X_hat(:,m)]  = OneD_Sort(B,Y_permuted_noisy(:,m),r);
            end
            for l = 1 : length(m_)
                m = m_(l);
                Y_hat = B*(X_hat(:,1:m));
                C_hat = Y_hat*Y_hat';
                err_C_Y(l) = err_C_Y(l) + norm(C_Y - C_hat,'fro')/norm(C_Y,'fro');
            end
        end
    end
    i
end
err_C_Y = 20*log10(err_C_Y/MC);
get_figure_single(r_,m_,n,d,err_C_Y);
saveas(gcf,['err_C_Y_r_',num2str(r),'m_',num2str(m_),'.fig'])
save(['data.mat'],'r_','m_','n','d','err_C_Y');
