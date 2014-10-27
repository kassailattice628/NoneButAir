function prevdata
global recobj
global daq
global figUIobj


i =1;
%rect 分のデータがたまるまでpreview表示させる

while daq.ai.SamplesAcquired < daq.ai.SamplesPerTrigger
%{
    while  daq.ai.SamplesAcquired < recobj.prevp*i
    end
    data = peekdata(daq.ai, recobj.prevp);
    set(figUIobj.p1, 'ydata', data(:,recobj.plot)*1000);
    set(figUIobj.s1,'XLim', [0, recobj.prevt]);
    
    if recobj.yaxis==1
    set(figUIobj.s1,'YLim', [min(data(:,recobj.plot)*1000) max(data(:,recobj.plot)*1000)]);
    elseif recobj.yaxis==2
    set(figUIobj.s1,'YLim', [-80 100]);
    end
    
    %disp(['plot', num2str(i)]);
    drawnow
    i = i+1;
%}
end
    %stop(daq.ai)