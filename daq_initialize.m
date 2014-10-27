function daq_initialize(devicemaker,devicename)
%DAQ関連のパラメータの設定初期化
global recobj
global daq
daqreset;

daq.datap = floor(recobj.sampf*recobj.rect/1000);

%% analog input
daq.ai = analoginput(devicemaker,devicename);
addchannel(daq.ai,0:2);
daq.ai.Channel.InputRange = [-10 10];
%daq.ai.Channel(1).InputRange = [-10 10];%Voltage
%daq.ai.Channel(2).InputRange = [-10 10];%Current
%daq.ai.Channel(3).InputRange = [-10 10];%Photo Sensor
set(daq.ai, 'SampleRate',recobj.sampf);
%set(daq.ai, 'InputType', 'SingleEnded');
set(daq.ai, 'InputType', 'Differential');%BNC版DAQは，基本差動のようだ
set(daq.ai, 'SamplesPerTrigger', recobj.sampf*recobj.rect/1000);
%set(daq.ai, 'Triggertype', 'Manual');
set(daq.ai, 'Triggertype', 'HwDigital');
%set(daq.ai, 'TriggerCondition','NegativeEdge');
set(daq.ai, 'TriggerCondition','PositiveEdge');
set(daq.ai, 'HwDigitalTriggerSource', 'PFI0');


%% analgoutput
%m=1;
%daq.ao = analogoutput(devicemaker,devicename);
%daq.chaout = addchannel(daq.ao,m-1);
%daq.ao.Channel(1).OutputRange = [-10 10];
%set(daq.ao, 'SampleRate', recobj.sampf);
%set(daq.ao, 'TriggerType', 'Immediate');
%set(daq.ao, 'Triggertype', 'HwDigital');
%set(daq.ao, 'HwDigitalTriggerSource', 'PFI0');

%daq.original_func = [5*ones(100,1);zeros(daq.datap-100,1)];%n-m Matrix (m: outputnum);
%dataoutori = [5*sin(2.5*2*pi*(1/recobj.sampf:1/recobj.sampf:300/1000))';zeros(recobj.sampf*200/1000,1)]; %outputdata
%daq.dataout(:,m)= (daq.original_func(:,m) - daq.ao.Channel.NativeOffset(m))/daq.ao.Channel(m).NativeScaling;
%daq.dataout = (dataoutori-daq.ao.Channel(1).NativeOffset)/daq.ao.Channel(1).NativeScaling;

%% dititalio
daq.dio = digitalio(daq.devMaker,daq.devName); %digital object for trigger output
addline(daq.dio,0:1,0,'out'); % P0.0, P0.1 を 'out' に set
%addline(daq.dio,1,1,'out'); % P0.0, P0.1 を 'out' に set
%addline(daq.dio,[4 7],1,'out'); % P0.0, P0.1 を 'out' に set
%putvalue(daq.dio, [1 0]);%trigger signal reset
putvalue(daq.dio, [0 0]);