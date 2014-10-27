function gui_window3
% None But Air Graphical User Interface 

global sobj
global recobj
global figUIobj

%%
%---------- GUI window ----------%
uicontrol('string','OpenScreen','position',[5 705 80 30],'Callback','[sobj.wPtr, RECT] = Screen(''OpenWindow'', sobj.ScrNum,sobj.bgcol);','Horizontalalignment','center')
uicontrol('string','CloseScreen','position', [5 670 80 30],'Callback','flag.start = 1;Screen(''Close'', sobj.wPtr);','Horizontalalignment','center')

%uicontrol('style','text','position',[110 705 80 20],'string','Stim ON/OFF','Horizontalalignment','left');
figUIobj.stim=uicontrol('style','togglebutton','position',[110 705 100 30],'string','Stim OFF','callback','stimset;','Horizontalalignment','center');

figUIobj.loop=uicontrol('style','togglebutton','position',[110 670 100 30],'string','Loop-Out','callback','main_loopingMac;','BackGroundColor','r');

figUIobj.StimMonitor1=uicontrol('style','text','position',[230 670 100 20], 'string','','FontSize',12,'BackGroundColor','w');
figUIobj.StimMonitor2=uicontrol('style','text','position',[230 690 100 25], 'string','OFF','FontSize',12,'BackGroundColor','w');
figUIobj.StimMonitor3=uicontrol('style','text','position',[230 715 100 20], 'string','','FontSize',12,'BackGroundColor','w');

figUIobj.EXIT=uicontrol('string','EXIT','position',[350 705 50 30],'CallBack','quit_NBA','FontSize',12,'Horizontalalignment','center');
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%  Visual stimuli  %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
uipanel('Title','Vis. Stim.1','FontSize',12,'Position',[0.005 0.013 0.195 0.87]);

uicontrol('style','text','position',[10 620 90 15],'string','Mode (Position)','Horizontalalignment','left');
figUIobj.mode=uicontrol('style','popupmenu','position',[10 600 90 20],'string',[{'Random'},{'Fix_Rep'},{'Ordered'}],'callback','ch_position;');

uicontrol('style','text','position',[105 620 70 15],'string','Stim.Pattern','Horizontalalignment','left');
figUIobj.pattern=uicontrol('style','popupmenu','position',[105 600 90 20],'string',[{'Uni'},{'BW'},{'Sin'},{'Rect'},{'Gabor'},{'Sz_r'},{'Zoom'},{'2Stim'},{'Images'}],'callback','stim_pattern2');
% When new stimulus patterns will be added, change "visual stimulus.m".


%%% %%%
uicontrol('style','text','position',[10 575 60 15],'string','Stim.Shape','Horizontalalignment','left');
figUIobj.shape=uicontrol('style','popupmenu','position',[10 555 75 20],'string',[{'Rect'},{'Circle'}],'callback','sobj.shape = sobj.shapelist{get(figUIobj.shape,''value''),1};');
set(figUIobj.shape, 'value', 2); % 丸形の刺激がデフォルト

uicontrol('style','text','position',[90 575 45 15],'strin','Div.Zoom','Horizontalalignment','left');
figUIobj.div_zoom=uicontrol('style','edit','position',[90 550 40 25],'string',sobj.div_zoom,'callback','sobj.div_zoom = re_write(figUIobj.div_zoom);check_zoom;','BackGroundColor','w');

%distance from the center point
uicontrol('style','text','position',[140 575 50 15],'string','Dist(deg)','Horizontalalignment','left');
figUIobj.dist=uicontrol('style','edit','position',[140 550 40 25],'string',sobj.dist,'callback','sobj.dist = re_write(figUIobj.dist);check_zoom;','BackGroundColor','w');

%%% Luminance %%%
uicontrol('style','text','position',[10 530 50 15],'string','Stim.Lumi','Horizontalalignment','left');
figUIobj.stimlumi=uicontrol('style','edit','position',[10 505 45 25],'string',sobj.stimlumi,'callback','sobj.stimlumi = re_write(figUIobj.stimlumi);check_lumi2','BackGroundColor','w');

uicontrol('style','text','position',[65 530 45 15],'string','BG.Lumi','Horizontalalignment','left');
figUIobj.bgcol=uicontrol('style','edit','position',[65 505 45 25],'string',sobj.bgcol,'callback','sobj.bgcol = re_write(figUIobj.bgcol);check_lumi2','BackGroundColor','w');

uicontrol('style','text','position',[120 530 40 15],'string','Lumi','Horizontalalignment','left');
figUIobj.lumi=uicontrol('style','popupmenu','position',[120 510 75 20],'string',[{'Fix'},{'Rand'}],'callback','Random_luminance');

%%%%% Durtion %%%
uicontrol('style','text','position',[10 480 65 15],'string','Stim.Duration','Horizontalalignment','left');
figUIobj.flipNum=uicontrol('style','edit','position',[10 455 30 25],'string',sobj.flipNum,'callback','sobj.flipNum = re_write(figUIobj.flipNum);check_duration2;','BackGroundColor','w');
sobj.duration = sobj.flipNum*sobj.m_int;
figUIobj.stimDur = uicontrol('style','text','position',[45 455 75 15],'string',['flips = ',num2str(floor(sobj.duration*1000)),' ms'],'Horizontalalignment','left');


%%% RGB %%% sobj.stimRGB
uicontrol('style','text','position',[125,480,50,15],'string','Stim.RGB','Horizontalalignment','left');
figUIobj.stimRGB = uicontrol('style','popupmenu','position',[125,455,70,25], 'string',[{'BW'},{'Blu'},{'Gre'},{'Yel'},{'Red'}],'callback','check_stimRGB;');


%%% DelayPTB
uicontrol('style','text','position',[10 430 75 15],'string','PTB delay flip ','Horizontalalignment','left');
figUIobj.delayPTBflip = uicontrol('style','edit','position',[10 405 30 25],'string',sobj.delayPTBflip,'callback','sobj.delayPTBflip = re_write(figUIobj.delayPTBflip); check_duration2','BackGroundColor','w');
sobj.delayPTB = sobj.delayPTBflip*sobj.m_int; 
figUIobj.delayPTB = uicontrol('style','text','position',[45 405 75 15],'string',['flips = ',num2str(floor(sobj.delayPTB*1000)),' ms'],'Horizontalalignment','left');

%%%%
uicontrol('style','text','position',[10 380 70 15],'string','Set Blank','Horizontalalignment','left');
figUIobj.prestimN=uicontrol('style','edit','position',[10 355 30 25],'string',recobj.prestim,'callback','blank_set;','BackGroundColor','w');
figUIobj.prestim=uicontrol('style','text','position',[45 355 85 15],'string',['loops = > ',num2str(recobj.prestim * recobj.rect/1000),' sec'],'Horizontalalignment','left');

%%% Size %%%%
uicontrol('style','text','position',[10 330 105 15],'string','Stim.Size (Diamiter)','Horizontalalignment','left');
figUIobj.size=uicontrol('style','edit','position',[10 305 50 25],'string','1','callback','sobj.stimsz = stim_size(sobj.MonitorDist,figUIobj.size); if(get(figUIobj.auto_size,''value'')==1), set(figUIobj.auto_size,''value'',0,''string'',''Auto OFF'');end','BackGroundColor','w');
uicontrol('style','text','position',[65 305 30 15],'string','deg','Horizontalalignment','left');
%Auto-Fill のときは，stimsz は画面を分割した場所を埋める
figUIobj.auto_size=uicontrol('style','togglebutton','position',[105 300 70 30],'string','Auto OFF','callback','autosizing(sobj.MonitorDist);','Horizontalalignment','center');

uicontrol('style','text','position',[10 280 70 15],'string','Monitor Div.','Horizontalalignment','left');
figUIobj.divnum=uicontrol('style','edit','position',[10 255 50 25],'string',sobj.divnum,'callback','sobj.divnum = re_write(figUIobj.divnum);autosizing(sobj.MonitorDist);ch_position;ch_Matnum(figUIobj.divnumN,figUIobj.fixposN);','BackGroundColor','w');
figUIobj.divnumN = uicontrol('style','text','position',[65 255 100 15],'string',['(=> ' num2str(sobj.divnum) ' x ' num2str(sobj.divnum) ' Matrix)'],'Horizontalalignment','left');

uicontrol('style','text','position',[10 230 70 15],'string','Fixed Pos.','Horizontalalignment','left');
figUIobj.fixpos=uicontrol('style','edit','position',[10 205 50 25],'string',sobj.fixpos,'callback','sobj.fixpos = re_write(figUIobj.fixpos);ch_position;','BackGroundColor','w');
figUIobj.fixposN = uicontrol('style','text','position',[65 205 100 15],'string',['(<= ' num2str(sobj.divnum) ' x ' num2str(sobj.divnum) ' Matrix)'],'Horizontalalignment','left');

%%% Rotation Direction %% 
uicontrol('style','text','position',[10 180 130 15],'string','Direction (Grating, Poler)','Horizontalalignment','left');
figUIobj.shiftDir = uicontrol('style','popupmenu','position',[10 155 90 25],'string',[{'0'},{'45'},{'90'},{'135'},{'180'},{'225'},{'270'},{'315'},{'Order8'},{'Rand8'},{'Rand16'}],'callback','sobj.shiftDir = get(figUIobj.shiftDir,''value'');');
uicontrol('style','text','position',[100 160 25 15],'string','deg','Horizontalalignment','left');

%%%
uicontrol('style','text','position',[10 135 80 15],'string','Temporal Freq','Horizontalalignment','left');
figUIobj.shiftSpd=uicontrol('style','popupmenu','position',[10 110 80 25],'string',[{'0.5'},{'1'},{'2'},{'4'},{'8'}],'value',3,'callback','sobj.shiftSpd2 = sobj.shiftSpd_list(get(figUIobj.shiftSpd,''value''));','BackGroundColor','w');
uicontrol('style','text','position',[90 115 20 15],'string','Hz','Horizontalalignment','left');

uicontrol('style','text','position',[10 90 75 15],'string','Spatial Freq','Horizontalalignment','left');
figUIobj.gratFreq=uicontrol('style','popupmenu','position',[10 65 100 25],'string',[{'0.01'},{'0.02'},{'0.04'},{'0.08'},{'0.16'},{'0.32'}],'value',4,'callback','sobj.gratFreq2 = sobj.gratFreq_list(get(figUIobj.gratFreq, ''value''));','BackGroundColor','w');
uicontrol('style','text','position',[110 70 50 15],'string','cycle/deg','Horizontalalignment','left');

uicontrol('style','text','position',[10 45 70 15],'string','Monior Dist.','Horizontalalignment','left');
figUIobj.MonitorDist=uicontrol('style','edit','position',[10 20 50 25],'string',sobj.MonitorDist,'callback','sobj.MonitorDist = re_write(figUIobj.MonitorDist);sobj.stimsz = stim_size(sobj.MonitorDist,(figUIobj.size));','BackGroundColor','g');
uicontrol('style','text','position',[65 20 30 15],'string','mm','Horizontalalignment','left');

%%
uicontrol('style', 'text','position',[125 430 60 15],'string','# of Images','HorizontalAlignment','left');
figUIobj.ImageNum = uicontrol('style','edit','position',[125 405 40 25],'string',sobj.ImageNum,'callback','sobj.ImageNum = re_write(figUIobj.ImageNum);','BackGroundColor','w');


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%              Visula Stimuli 2             %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
uipanel('Title','Vis. Stim.2','FontSize',12,'Position',[0.205 0.013 0.195 0.87]);

uicontrol('style','text','position',[210 620 70 15],'string','Stim.Shape2','Horizontalalignment','left');
figUIobj.shape2=uicontrol('style','popupmenu','position',[210 600 85 20],'string',[{'Rect'},{'Circle'}],'callback','sobj.shape2 = sobj.shapelist{get(figUIobj.shape2,''value''),1};');
set(figUIobj.shape2, 'value', 2);

uicontrol('style','text','position',[210 575 60 15],'string','Stim.Lumi2','Horizontalalignment','left');
figUIobj.stimlumi2=uicontrol('style','edit','position',[210 550 50 25],'string',sobj.stimlumi2,'callback','sobj.stimlumi2 = re_write(figUIobj.stimlumi2);check_lumi2','BackGroundColor','w');
%Match を押すと Stim.lumi1 のサイズにそろえる
uicontrol('string','Match','position',[270 545 60 30],'callback','set(figUIobj.stimlumi2,''string'',get(figUIobj.stimlumi,''string''));sobj.stimlumi2 = sobj.stimlumi;check_lumi2','Horizontalalignment','center');

uicontrol('style','text','position',[210 525 85 15],'string','Stim.Duration2','Horizontalalignment','left');
figUIobj.flipNum2=uicontrol('style','edit','position',[210 500 30 25],'string',sobj.flipNum2,'callback','sobj.flipNum2 = re_write(figUIobj.flipNum2);check_duration2;','BackGroundColor','w');
sobj.duration2 = sobj.flipNum2*sobj.m_int;
figUIobj.stimDur2 = uicontrol('style','text','position',[245 500 75 15],'string',['flips = ',num2str(floor(sobj.duration2*1000)),' ms'],'Horizontalalignment','left');

%%% DelayPTB2
uicontrol('style','text','position',[210 475 85 15],'string','PTB delay flip2 ','Horizontalalignment','left');
figUIobj.delayPTBflip2 = uicontrol('style','edit','position',[210 450 30 25],'string',sobj.delayPTBflip2,'callback','sobj.delayPTBflip2 = re_write(figUIobj.delayPTBflip2); check_duration2','BackGroundColor','w');
sobj.delayPTB2 = sobj.delayPTBflip2*sobj.m_int; 
figUIobj.delayPTB2 = uicontrol('style','text','position',[245 450 75 15],'string',['flips = ',num2str(floor(sobj.delayPTB2*1000)),' ms'],'Horizontalalignment','left');


uicontrol('style','text','position',[210 425 105 15],'string','Stim.Size2 (Diamiter)','Horizontalalignment','left');
figUIobj.size2=uicontrol('style','edit','position',[210 400 50 25],'string','1','callback','sobj.stimsz2 = stim_size(sobj.MonitorDist,figUIobj.size2 );','BackGroundColor','w');
uicontrol('style','text','position',[265 400 25 15],'string','deg','Horizontalalignment','left');
%Match を押すと Stim.Size1 のサイズにそろえる
uicontrol('string','Match','position',[295 395 60 30],'callback','set(figUIobj.size2,''string'',get(figUIobj.size,''string''));sobj.stimsz2 = sobj.stimsz;','Horizontalalignment','center');

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%              Electrophysiology             %%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
uipanel('Title','NI DAQ Setting','FontSize',12,'Position',[0.42 0.77 0.55 0.22]);
%%%
uicontrol('style','text','position',[435 695 60 15],'string','Samp.Time','Horizontalalignment','left');
figUIobj.sampt=uicontrol('style','edit','position',[435 670 50 25],'string',recobj.sampt,'callback','recobj.sampt = re_write(figUIobj.sampt); reload_recdaq;','BackGroundColor','w');
uicontrol('style','text','position',[490 670 20 15],'string','us','Horizontalalignment','left');

uicontrol('style','text','position',[520 695 60 15],'string','Rec.Time','Horizontalalignment','left');
figUIobj.rect=uicontrol('style','edit','position',[520 670 50 25],'string',recobj.rect,'callback','recobj.rect = re_write(figUIobj.rect);blank_set; reload_recdaq;','BackGroundColor','w');
uicontrol('style','text','position',[575 670 20 15],'string','ms','Horizontalalignment','left');

uicontrol('style','text','position',[605 695 70 15],'string','Loop Interval','Horizontalalignment','left');
figUIobj.interval=uicontrol('style','edit','position',[605 670 50 25],'string',recobj.interval,'callback','recobj.interval = re_write(figUIobj.interval);','BackGroundColor','w');
uicontrol('style','text','position',[660 670 25 15],'string','sec','Horizontalalignment','left');

uicontrol('style','text','position',[690 695 80 15],'string','Preview Trace','Horizontalalignment','left');
figUIobj.prevt=uicontrol('style','edit','position',[690 670 50 25],'string',recobj.prevt,'callback','recobj.prevt = re_write(figUIobj.prevt); reload_recdaq;','BackGroundColor','w');
uicontrol('style','text','position',[745 670 20 15],'string','ms','Horizontalalignment','left');

%%% Trigger Delay or TTL Delay
uicontrol('style','text','position',[775 695 80 15],'string','Trig/TTL Delay','Horizontalalignment','left');
figUIobj.TTL2=uicontrol('style','togglebutton','position',[775 670 100 25],'string','FV trig','value',1,'Callback','ch_TTL2;','Horizontalalignment','left');

figUIobj.delayTTL2=uicontrol('style','edit','position',[880 670 50 25],'string',recobj.delayTTL2,'callback','recobj.delayTTL2 = re_write(figUIobj.delayTTL2);','BackGroundColor','w');
uicontrol('style','text','position',[935 670 20 15],'string','ms','Horizontalalignment','left');

%%%
uicontrol('style','text','position',[435 650 55 15],'string','Plot Type ','Horizontalalignment','left');
figUIobj.plot=uicontrol('style','popupmenu','position',[435 630 90 20],'string',[{'V-plot'},{'I-plot'}],'callback','recobj.plot = get(figUIobj.plot, ''value'');ch_plot;');

uicontrol('style','text','position',[530 650 55 15],'string','Y-axis','Horizontalalignment','left');
figUIobj.yaxis=uicontrol('style','popupmenu','position',[530 630 90 20],'string',[{'Auto'},{'Fix'}],'callback','recobj.yaxis = get(figUIobj.yaxis,''value'');');

uicontrol('style','text','position',[625 650 70 15],'string','Daq Range','Horizontalalignment','left');
figUIobj.gain=uicontrol('style','popupmenu','position',[625 630 90 20],'string',[{' x 1'},{' x 10'},{' x 50'},{' x 100'}],'value',3,'callback','ch_DaqRange');
figUIobj.gainstr=uicontrol('style','text','position',[715 630 90 15],'string',recobj.gain_range,'Horizontalalignment','left');

%%%
uicontrol('string','File Name','position', [435 595 90 30],'Callback','SelectSaveFile;','Horizontalalignment','center');
figUIobj.savech=uicontrol('style','popupmenu','position', [530 600 120 20],'string',[{'ALL'},{'Header Only'},{'Header&Photo'}]);
figUIobj.save=uicontrol('style','togglebutton','position', [655 595 70 30],'string','Unsave','Callback','ch_save');



%%%%%%%%%%%%%%%%%%%   Plot Window   %%%%%%%%%%%%%%%%%%%%
%場所の指定は subplot の position で指定(0-1.0 の相対値）
%uicontrol('style','frame','position',[390 30 600 610],'BackGroundColor','w');

%{
figUIobj.s1 = subplot('position', [0.46 0.8 0.52 0.15]);
figUIobj.p1 = plot(recobj.prevtaxis,zeros(recobj.prevp,1));
xlim([0 recobj.prevt]);
ylim([-2 2]);
title('Preview Data');
xlabel('Time (ms)');
ylabel('mV');
%}


figUIobj.s2 = subplot('position', [0.46 0.35 0.52 0.35]);
figUIobj.p2 = plot(recobj.rectaxis,zeros(recobj.recp,1));
xlim([0 recobj.rect]);
ylim([-2 2]);
title('V-DATA');
xlabel('Time (ms)');
ylabel('mV');
figUIobj.flash2 = line('xdata',[0 0],'ydata',[0 0],'Color','r','LineWidth',2);
figUIobj.flash3 = line('xdata',[0 0],'ydata',[0 0],'Color','r','LineWidth',2);


figUIobj.s3 = subplot('position', [0.46 0.1 0.52 0.15]);
figUIobj.p3 = plot(recobj.rectaxis,zeros(recobj.recp,1));
xlim([0 recobj.rect]);
ylim([-2 2]);
title('Photo Sensor');
xlabel('Time (ms)');
ylabel('mV');

%set(figUIobj.s1, 'Drawmode','fast');
set(figUIobj.s2, 'Drawmode','fast');
set(figUIobj.s3, 'Drawmode','fast');

%set(figUIobj.p1, 'Erasemode','xor');
set(figUIobj.p2, 'Erasemode','xor');
set(figUIobj.p3, 'Erasemode','xor');

ch_position;
