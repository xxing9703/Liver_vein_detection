function liv_plot_cv_pv_single(ax,pk,ub)
% plots the averaged CV-PV signals for individual metabolite peaks

%ub=1000;% ylim upper bond minimum
    tp=mean(pk.sig,2); 
    err=std(pk.sig');
%     plot(0:1/50:1,tp'+err,"Color",[1,.9,1])
%     hold on
%     plot(0:1/50:1,tp'-err,"Color",[1,.9,1])
%     hold on
    x2 = [0:1/50:1, fliplr(0:1/50:1)];
    inBetween = [tp'+err, fliplr(tp'-err)];
    fill(ax,x2, inBetween, [.9 .85 .9],'EdgeColor','none');
    hold (ax,"on")
    plot(ax,0:1/50:1,tp,'color','r','LineWidth',1)
    hold (ax,"on")
    plot(ax,[0,1],[ub/2,ub/2],'--b')
    title(ax,pk.Name)
    ylim(ax,[0,max(ub,max(tp'+err))*1.2]);     
    ylabel(ax,'ion counts');
    xticks(ax,[0,1]);
    xticklabels(ax,{'CV','PV'});
