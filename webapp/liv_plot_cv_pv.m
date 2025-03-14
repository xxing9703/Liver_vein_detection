function liv_plot_cv_pv(pks,idx)
% plots the averaged CV-PV signals for individual metabolite peaks
% required input: pks after running script_main.  
n=length(idx);
ub=1000;% ylim upper bond minimum
figure('units','normalized','outerposition',[0, 0, 1, 1])
for i=1:n
    subplot(ceil(sqrt(n)),ceil(sqrt(n)),i)
    tp=mean(pks(idx(i)).sig,2); 
    err=std(pks(idx(i)).sig');
%     plot(0:1/50:1,tp'+err,"Color",[1,.9,1])
%     hold on
%     plot(0:1/50:1,tp'-err,"Color",[1,.9,1])
%     hold on
    x2 = [0:1/50:1, fliplr(0:1/50:1)];
    inBetween = [tp'+err, fliplr(tp'-err)];
    fill(x2, inBetween, [.9 .85 .9],'EdgeColor','none');
    hold on
    plot(0:1/50:1,tp,'color','r','LineWidth',1)
    hold on
    plot([0,1],[ub/2,ub/2],'--b')
    title(pks(idx(i)).Name)
    ylim([0,max(ub,max(tp'+err))]);     
    ylabel('ion counts');
    xticks([0,1]);
    xticklabels({'CV','PV'});
end