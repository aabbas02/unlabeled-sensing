function [] = get_figure_x(MSE_X_GW,delta_,r_,SNR,MC)
    MSE_X_GW   = log10(MSE_X_GW);
    MSE_X_GW   = flipud(MSE_X_GW);
	MSE_X_m_1  = MSE_X_GW(:,1:length(r_));                   %m = 1
	MSE_X_m_r = MSE_X_GW(:,length(r_)+1:2*length(r_));      %m = r
	MSE_X_m_2r  = MSE_X_GW(:,2*length(r_)+1:3*length(r_));    %m = 2r
	clims = [min(min(MSE_X_GW))  max(max(MSE_X_GW))];	

	subplot(1,3,1)
	imagesc(MSE_X_m_1, clims);
	colormap(gray)
	xticks(1 : length(r_))
	xticklabels(r_(:))
	yticks(1 : length(delta_))
	yticklabels(flip(delta_))	
	xlabel('r')
	ylabel('delta')
	title('m = 1')

	subplot(1,3,2)
	imagesc(MSE_X_m_r , clims);
	colormap(gray)
	xticks(1 : length(r_))
	xticklabels(r_(:))
	yticks(1 : length(delta_))
	yticklabels(flip(delta_))
	xlabel('r')
	ylabel('delta')
	title('m = r')

	subplot(1,3,3)
	imagesc(MSE_X_m_2r , clims);
	colormap(gray)
	xticks(1 : length(r_))
	xticklabels(r_(:))
	yticks(1 : length(delta_))
	yticklabels(flip(delta_))
	xlabel('r')
	ylabel('delta')
	title('m = 2r')
	c = colorbar;
    sgtitle("SNR = " + SNR +  "MC = " + MC);	
end