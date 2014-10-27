%parameter settings;
global sobj
global recobj
%bal daq

%% 電気記録と記録サイクル関係
recobj.interval = 1; %loop interval(s);
recobj.sampt = 200; %samplingtime(100us)
recobj.sampf = 10^6/recobj.sampt; %samoling rate (Hz)
recobj.rect = 2*1000; %recording time (1s<-1000ms)
recobj.recp = recobj.sampf*recobj.rect/1000;
recobj.rectaxis = (0:recobj.sampt/1000:(recobj.recp-1)/recobj.sampf*1000)';%time axis (ms)

recobj.prevt = 500; %preview time (200ms)
recobj.plot = 1; %V/I plot, 1: V plot, 2: I plot
recobj.yaxis = 1;%1: fix y axis, 2: auto
recobj.prevp = (recobj.sampf*recobj.prevt/1000)-1;
recobj.prevtaxis = (0:recobj.sampt/1000:(recobj.prevp-1)/recobj.sampf*1000)'; %time axis (ms)
recobj.gain_list ={'[-10, 10 (V)]';'[-1, 1 (V)]';'[-200, 200 (mV)]';'[-100, 100 (mV)]'};
recobj.gain_range = recobj.gain_list{3};

recobj.prestim = 2; % recobj.prestim * recobj.rect (ms) は 刺激なしの blank loop

recobj.fopenflag = 0;
recobj.dataall =[];
%{
% DAQ関係
daq.devMaker = 'nidaq';
daq.devName = 'Dev4';
%}

%% PTB関係
%scrsz=get(0,'ScreenSize');
MP = get(0,'MonitorPosition');%position matrix for malti monitors
screens = Screen('Screens');
sobj.ScrNum = max(screens);% 0: main, 1,2,...: sub(刺激提示用）, !!Windwos, 1:main,2....sub
if sobj.ScrNum == 0
    sNum = sobj.ScrNum+1;
else
    sNum = sobj.ScrNum;
end
%%
sobj.ScreenSize = [MP(sNum,3)-MP(sNum,1)+1, MP(sNum,4)-MP(sNum,2)+1];%monitor size of stim monitor
sobj.pixpitch = 0.264;%(mm)
sobj.MonitorDist = 300;%(mm) = distance from moniter to eye, => sobj.MonitorDist*tan(1*2*pi/360)/sobj.pixpitch でpixel/degree

sobj.stimsz = round(ones(1,2)*Deg2Pix(1,sobj.MonitorDist));% default は 1度
sobj.shapelist = [{'FillRect'};{'FillOval'}];
sobj.shape = 'FillOval'; %初期設定はOvalに変更
sobj.pattern = 'Uni'; %uniform or Grating
%sobj.filter = 1;%1: None, 2: Gabor patch
sobj.div_zoom = 5;
sobj.flipNum = 75;
sobj.divnum = 2;
sobj.black = BlackIndex(sobj.ScrNum);
sobj.white = WhiteIndex(sobj.ScrNum);
sobj.gray = round((sobj.white+sobj.black)/2);
sobj.stimlumi = sobj.white;
sobj.bgcol = sobj.black;
if sobj.gray == sobj.stimlumi
    sobj.gray = sobj.white/2;
end
sobj.delayPTBflip = 20; %delay flip number
sobj.delayPTB = 0;% PTBflip * m_int だけど
sobj.stimRGB = [1,1,1];
sobj.stimcol = sobj.stimlumi * sobj.stimRGB;

%%%VS2%%%%
sobj.stimsz2 = round(ones(1,2)*Deg2Pix(1,sobj.MonitorDist));% default は 1度
sobj.shape2 = 'FillOval'; %初期設定はOvalに変更
sobj.stimlumi2 = sobj.white;
sobj.stimcol2 = sobj.stimlumi2 * sobj.stimRGB;
sobj.flipNum2 = 75;
sobj.delayPTBflip2 = 20; %delay flip number
sobj.delayPTB2 = 0;% PTBflip * m_int だけど
recobj.delayTTL2 = 0;


%計測時間値（変数宣言のみ）
recobj.tTTL2=0;
recobj.tRec=0;
sobj.tPTBon=0;
sobj.tPTBoff=0;
sobj.tPTBon2=0;
sobj.tPTBoff2=0;

sobj.fixpos = 1;

%sobj.shiftSpd = 20; %
sobj.shiftSpd2 = 2;%Hz
%sobj.shiftSpd_list = [20; 30; 50;100];% Frames/cycle
sobj.shiftSpd_list = [0.5; 1; 2; 4; 8];%Hz

%sobj.gratFreq = 1/1000*2*pi;%cycle/pixel
sobj.gratFreq2 = 0.08;% cycle/degree
%sobj.gratFreq_list = [1/1000*2*pi;3/1000*2*pi;5/1000*2*pi;10/1000*2*pi;30/1000*2*pi;50/1000*2*pi];
sobj.gratFreq_list = [0.01;0.02;0.04;0.08;0.16;0.32];


sobj.shiftDir = 1;%1~8:方向, 9: 8 方向random, 10: 4方向random
sobj.angle = 0;%savedata用
sobj.angle_deg = linspace(0, 315,8);
sobj.angle16_deg = linspace(0,337.5,16);

sobj.dist = 15; %distance(degree) for 2nd stimulus for lateral inhibition


sobj.position = 0;
sobj.position_cord = zeros(1,4);
sobj.position_cord2 = zeros(1,4);
sobj.stim2_center = zeros(1,2);
sobj.dist_pix = 0;

%Zoom and Fine mapping
sobj.zoom_dist = 0;
sobj.zoom_ang = 0;
check_zoom;

%Image presentation
sobj.img_i = 0;
sobj.ImageNum = 256;
sobj.list_img = 1:sobj.ImageNum;