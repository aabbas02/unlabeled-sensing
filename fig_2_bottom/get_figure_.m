function [] = get_figure_(data_GW,data_LEV,n_,r_,SNR,noise_var,MC,m_,d)
figure
styles = ["b-*","k-s","c-d","y-p","g-h"];
	hold on
	plot(n_,data_GW, styles(1),'MarkerSize',9,'DisplayName',['Proposed']);
    plot(n_,data_LEV, styles(2),'MarkerSize',9,'DisplayName',['Levsort']);
    xticklabels = n_;
	xticks = n_;
	set(gca, 'XTick', xticks, 'XTickLabel', xticklabels);
    set(gca, 'YTick', yticks, 'YTickLabel', yticklabels);
    xlabel('measurements $n$','interpreter','latex','FontSize',11);
    ylabel('hamming distortion : $d_H$','interpreter','latex','FontSize',11);
    grid('on')
% add a bit of space to the figure
fig = gcf;
fig.Position(3) = fig.Position(3) + 750;
% add legend
Lgnd = legend('show');
Lgnd.Position(1) = 0.01;
Lgnd.Position(2) = 0.4;
set(Lgnd, 'Interpreter','latex')
%
title({['$d_H$ against measurments $n$'] ['dimension $d = $',num2str(d),', views $m = $',num2str(m_) ', SNR $ = $', num2str(SNR),', $r = $', num2str(r_)]},'interpreter','latex')
end