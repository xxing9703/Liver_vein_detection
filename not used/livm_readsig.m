% read bond signals from CV to PV, store data in bond and pks;
for i=1:length(bond)
  fprintf([num2str(i),'/',num2str(length(bond)),'\n']);
  sig=get_p2p_signal(imax(:,4:end),metadata,step,bond(i).node1,bond(i).node2);
  bond(i).sig=sig; 
  bond(i).slopes=linearfit(sig,portion,0.5);
end
%%
for i=1:length(pks)    
    for j=1:length(bond)
      pks(i).sig(:,j)=bond(j).sig(:,i);
      pks(i).slopes(:,j)=bond(j).slops(:,i);
    end
    pks(i).slopes_mean=linearfit(mean(pks(i).sig,2),portion,0.5);
    pks(i).slopes_meanS=mean(pks(i).slops);   
end