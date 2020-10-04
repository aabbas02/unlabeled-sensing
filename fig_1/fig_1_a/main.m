clc
close all;
MC           = 15;
SNR          = 35;
n            = 240;
r_           = [4 5 8 10];
d            = 64;
m_           = [24 48 72 144];
m_max 	     = max(m_); 
X      	     = randn(d,m_max);
W            = randn(n,m_max,MC);
B            = randn(n,d);
Y_           = B*X;
X_           = X*diag(1./sqrt(diag(Y_'*Y_)));
Y_           = Y_*diag(1./sqrt(diag(Y_'*Y_)));
C_Y          = Y_*Y_';
noise_var    = 1  / ( 10^(SNR/10) * n );
err_C_Y      = zeros(length(r_),length(m_));
for i = 1 : length(r_)
    r      = r_(i);
    pi_    = make_r_local_permutation(n,r);
    Y_permuted  = pi_*Y_;
    for j = 1 : MC
        Y_permuted_noisy = Y_permuted + sqrt(noise_var)*W(:,:,j);
        X_hat            = zeros(d,m_max);
        for k = 1 : m_max
            [~,~,~,X_hat(:,k)]  = OneD_Sort(B,Y_permuted_noisy(:,k),r);
        end
        for l = 1 : length(m_)
            m     = m_(l);
            Y_hat = B*(X_hat(:,1:m));
            C_hat = Y_hat*Y_hat';
            err_C_Y(i,l) = err_C_Y(i,l) + norm(C_Y - C_hat,'fro')/norm(C_Y,'fro');
        end
    end
    i
end
err_C_Y = 20*log10(err_C_Y/MC);
get_figure_grid(r_,m_,n,d,err_C_Y)
save('data.mat','r_','m_','n','d','err_C_Y');
