function [] = get_figure_single(r_,m_,n,d,err)
    plot(m_,err,"b-*",'MarkerSize',9);
	xticklabels = m_;
    xticks = m_;
    set(gca, 'XTick', xticks, 'XTickLabel', xticklabels);
    yticks = sort(err);
    yticklabels = round(yticks,2);
    set(gca, 'YTick', yticks, 'YTickLabel', yticklabels);
	%%%labels
    xlabel('views $m$','interpreter','latex','FontSize',15);
    ylabel('$20\log_{10}\frac{||\mathbf{C}_Y - \mathbf{C}_{\hat{Y}m}||_F}{||\mathbf{C}_Y||_F}$ db','interpreter','latex','FontSize',15);
    %%%grid
    grid('on')
	%%%title
    title(['$n  = $ ',num2str(n),', $d = $',num2str(d), ', $r =$',num2str(r_)],'interpreter','latex','FontSize',15)
    xline(d,'--','$m=d$','interpreter','latex','FontSize',12)
%	saveas(gcf,['C:\Users\aabbas02\Desktop\code_final\cost\single\matlab\figures','_d',num2str(d),'_m',num2str(m_),'.fig'])
end