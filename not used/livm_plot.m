ct=0;
for kk=1:4
st=kk*15-14;
figure('units','normalized','outerposition',[0 0 1 1])
for n=st:min(st+14,200)    
    ct=ct+1;
    subplot(3,5,n-st+1)
    cl='b';
    plot(pks(n).sig,'color',[.5,.5,.5],'LineWidth',1);
    hold on
    y=pks(n).sig_mean;
    yfit=pks(n).sig_fit;
    if max(y)>detLimit
        plot(yfit(:,1),yfit(:,2),'color','y','LineWidth',3);
        xlabel(['alpha = ',num2str(pks(n).slop)]);
    else
        cl='r';
    end
    plot(y,'LineWidth', 2,'Color',cl);
    title(pks(n).Name)
    xlim([0,step+1]);
    ylim([0,max(y)*2+1e-9])
 end
end
