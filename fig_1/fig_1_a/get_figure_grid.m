function [] = get_figure_grid(r_,m_,n,d,err)
	clims = [min( min((err))) max(max((err)))];	
    err   = flipud(err);
    imagesc(err, clims);
    colormap(gray)
    xticks(1 : length(m_))
    xticklabels(m_)
    set(gca, 'XTick', xticks, 'XTickLabel', xticklabels);
    yticks(1 : length(r_))
    yticklabels(flip(r_))
    set(gca, 'YTick', yticks, 'YTickLabel', yticklabels);
    xlabel('views $m$','interpreter','latex','FontSize',11);
    ylabel('block size $r$','interpreter','latex','FontSize',11)
    title({['$n= $  ',num2str(n),',  $d=$',num2str(d)],'$20\log_{10}\frac{||\mathbf{C}_Y - \mathbf{C}_{\hat{Y}m}||_F}{||\mathbf{C}_Y||_F}$'},'interpreter','latex','FontSize',12)
    c = colorbar;
    c.TickLabelInterpreter = 'tex';
    c.Label.String = 'db';
    %saveas(gcf,['C:\Users\aabbas02\Desktop\code_final\cost\grid\matlab\figures','_d',num2str(d),'_m',num2str(m_),'.fig'])
    saveas(gcf,['matlab_figure',num2str(d),'_m',num2str(m_),'.fig'])
end