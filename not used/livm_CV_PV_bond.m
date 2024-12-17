% create bonds based on the limiting bond length criteria
n=0;bond=[]; 
for i=1:size(cv,1)
    for j=1:size(pv,1)
         dist=((pv(j,1)-cv(i,1))^2+(pv(j,2)-cv(i,2))^2)^0.5;
        if dist>=ln(1) && dist<=ln(2)
           n=n+1;
           bond(n).node1=cv(i,:);
           bond(n).node2=pv(j,:);
           bond(n).dist=dist;
        end
    end
end

%  draw bonds
for i=1:length(bond)
   line(gca,[bond(i).node1(1),bond(i).node2(1)],[bond(i).node1(2),bond(i).node2(2)],'color','w');
end
drawnow();