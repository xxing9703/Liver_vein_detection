function liv_plot_cv_pv(pks,id,n)
% plots the averaged CV-PV signals for individual metabolite peaks
% required input: pks after running script_main.  
n=min(n,length(pks)+id-1);
figure('units','normalized','outerposition',[0, 0, 1, 1])
for i=1:n
    subplot(ceil(sqrt(n)),ceil(sqrt(n)),i)
    tp=mean(pks(i+id-1).sig,2);
    plot(0:1/50:1,tp,'r')
    title(pks(i+id-1).Name)
    ylim([0,max(500,max(tp))])
end