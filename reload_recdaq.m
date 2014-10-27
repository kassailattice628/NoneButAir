function reload_recdaq
global recobj
global daq
global figUIobj

% rerload recobj
% recobj.rect, recobj.sampt, recobj.sampf
recobj.sampf = 10^6/recobj.sampt;
daq.datap = floor(recobj.sampf*recobj.rect/1000);
recobj.recp = recobj.sampf*recobj.rect/1000;
recobj.rectaxis = (0:recobj.sampt/1000:(recobj.recp-1)/recobj.sampf*1000)';

%recobj.prevt
recobj.prevp = recobj.sampf*recobj.prevt/1000;
recobj.prevtaxis = (0:recobj.sampt/1000:(recobj.prevp-1)/recobj.sampf*1000)'; %time axis (ms)


%change plot area
%{
set(figUIobj.p1,'xdata',recobj.prevtaxis,'ydata',zeros(recobj.prevp,1));
set(figUIobj.s1,'XLim', [0, recobj.prevt]);
set(figUIobj.s1,'YLim', [-0.1 0.1]);
%}
set(figUIobj.p2,'xdata',recobj.rectaxis,'ydata',zeros(recobj.recp,1));
set(figUIobj.s2,'XLim', [0, recobj.rect]);
set(figUIobj.s2,'YLim', [-0.1 0.1]);

set(figUIobj.p3,'xdata',recobj.rectaxis,'ydata',zeros(recobj.recp,1));
set(figUIobj.s3,'XLim', [0, recobj.rect]);
set(figUIobj.s3,'YLim', [-0.1 0.1]);

% reload daq
set(daq.ai, 'SampleRate', recobj.sampf);
set(daq.ai, 'SamplesPerTrigger', recobj.sampf*recobj.rect/1000);
%set(daq.ao, 'SampleRate', recobj.sampf);

