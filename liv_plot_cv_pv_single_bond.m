function liv_plot_cv_pv_single_bond(ax,pk,bondID)
% add plots for single bond CV-PV signal
 hold (ax,"on") 
 tp=pk.sig(:,bondID); 
 plot(ax,0:1/50:1,tp,'color','b','LineWidth',1)
 hold (ax,"off")
   
  
