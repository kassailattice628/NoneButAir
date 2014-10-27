function ch_DaqRange
global recobj
global figUIobj

i = get(figUIobj.gain, 'value');
recobj.gain_range = recobj.gain_list{i};
set(figUIobj.gainstr, 'string', recobj.gain_range);
if i ==1
    daq.ai.Channel(recobj.plot).OutputRange = [-10 10];
    daq.ao.Channel(recobj.plot).OutputRange = [-10 10];
elseif i == 2
    daq.ai.Channel(recobj.plot).OutputRange = [-1 1];
    daq.ao.Channel(recobj.plot).OutputRange = [-1 1];
elseif i == 3
    daq.ai.Channel(recobj.plot).OutputRange = [-0.2 0.2];
    daq.ao.Channel(recobj.plot).OutputRange = [-0.2 0.2];
elseif i == 4
    daq.ai.Channel(recobj.plot).OutputRange = [-0.1 0.1];
    daq.ao.Channel(recobj.plot).OutputRange = [-0.1 0.1];
end