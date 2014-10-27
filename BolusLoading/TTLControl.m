%%%%Bolas loading TTL protocol%%%%%
clear all;
close all;

global gatet
global loopint
global ui
global dio
%%
dio = digitalio('nidaq','dev1'); %digital object for trigger output
addline(dio,1,1,'out');
putvalue(dio, 0);
%%
gatet=20;
loopint = 10;
figure;

ui.onpulse = uicontrol('style','togglebutton','string','TTLPulse','position',[10 300 100 30],'callback','TTLPulseON','fontsize',10);
ui.ongate = uicontrol('style','togglebutton','string','TTLGate','position',[130 300 100 30],'callback','TTLGateON','fontsize',10);
ui.onloop = uicontrol('style','togglebutton','string','Loop-off','position',[240 300 80 30],'callback','TTLLoop','fontsize',10,'BackGroundColor','w');

ui.off = uicontrol('string','OFF','position',[10 250 100 30],'callback','TTLOFF','fontsize',10);

uicontrol('style','text','string','GateTime(sec)','position',[130 275 100 20],'fontsize',10);
ui.gatet = uicontrol('style','edit','string',gatet,'position',[130 250 100 25],'callback','gatet=str2num(get(ui.gatet,''string''));','fontsize',10,'BackGroundColor','w');

uicontrol('style','text','string','Interval(sec)','position',[240 275 100 20],'fontsize',10);
ui.loopint = uicontrol('style','edit','string',loopint,'position',[240 250 100 25],'callback','loopint=str2num(get(ui.loopint,''string''));','fontsize',10,'BackGroundColor','w');

