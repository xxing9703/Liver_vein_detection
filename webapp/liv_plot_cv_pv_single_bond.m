function liv_plot_cv_pv_single_bond(ax,pk,bondID)
% plots the averaged CV-PV signals for individual metabolite peaks
% required input: pks after running script_main.  
 hold (ax,"on")
 ub=1000;% ylim upper bond minimum
 tp=pk.sig(:,bondID); 
 plot(ax,0:1/50:1,tp,'color','b','LineWidth',1)
 hold (ax,"off")
   
  
