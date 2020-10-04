function [] = get_figure_(data,n_,r_,SNR,noise_var,MC,m_,d)
figure
styles = ["b-*","k-s","c-d","y-p","g-h"];
	hold on
	for j = 1 : 2
		plot(n_,data(:,j), styles(j),'MarkerSize',9,'DisplayName',['$m = $',num2str(m_(j))]);
	end
	xticklabels = n_;
	xticks = n_;
	set(gca, 'XTick', xticks, 'XTickLabel', xticklabels);
	%yticks = linspace(min(data(:,j)),max(data(:,j)),length(r_));
	%yticklabels = round(yticks,2);
    set(gca, 'YTick', yticks, 'YTickLabel', yticklabels);
    xlabel('measurements $n$','interpreter','latex','FontSize',11);
    ylabel('hamming distortion $d_H$','interpreter','latex','FontSize',11);
    grid('on')
    title(['$r = $',num2str(r_)],'interpreter','latex')
% add a bit of space to the figure
%fig = gcf;
%fig.Position(3) = fig.Position(3) + 750;
% add legend
Lgnd =  legend('show');
%Lgnd.Position(1) = 0.01;
%Lgnd.Position(2) = 0.4;
set(Lgnd, 'Interpreter','latex')
%
%sgtitle({['$d_H$ against block size $r$'] ['dimension $d = $',num2str(d), ', SNR $ = $', num2str(SNR)]},'interpreter','latex')
end