function [bond,pks]=liv_readsig(app,bond,imax,step,portion,pks)
% read bond signals from CV to PV, store data in bond and pks;
metadata=imax(:,1:2);

% fig = uifigure;
%     d = uiprogressdlg(fig,'Title','Please Wait',...
%         'Message','Calculating CV-PV signals');
for i=1:length(bond)
  app.lineobj1{i}.Color='k';
  app.lineobj2{i}.Color='k'; 
end
drawnow();
  
for i=1:length(bond)
  fprintf([num2str(i),'/',num2str(length(bond)),'\n']);
  app.lineobj1{i}.Color='y';
  app.lineobj2{i}.Color='y';  
  drawnow();
  sig=get_p2p_signal(imax(:,4:end),metadata,step,bond(i).node1,bond(i).node2);
  bond(i).sig=sig; 
  bond(i).slopes=linearfit(sig,portion,0.5);
end

for i=1:length(pks)    
    for j=1:length(bond)
      pks(i).sig(:,j)=bond(j).sig(:,i);
      pks(i).slopes(:,j)=bond(j).slopes(:,i);
    end
    pks(i).slopes_mean=linearfit(mean(pks(i).sig,2),portion,0.5);
    pks(i).slopes_meanS=mean(pks(i).slopes);   
end