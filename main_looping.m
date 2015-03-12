function main_looping

global recobj
global figUIobj
global sobj
global floop
global sTrig
global s

floop = get(figUIobj.loop,'value');
fstim = get(figUIobj.stim,'value');

if floop == 0;% Loop-Out
    set(figUIobj.loop,'string','Loop-Out','BackGroundColor','r');
    if sobj.ScrNum ~= 0
        outputSingleScan(sTrig,[0,0]); %trigger reset
    end
    sobj.Dir8 = randperm(8);
    sobj.Dir16 = randperm(16);
elseif floop == 1;%Looping
    %%%% Loop Error %%%%
    %{
    if sobj.shiftDir >= 9 && get(figUIobj.mode,'value') == 1
        errordlg('Randome Direction can be used in the fixed position mode!!.');
        set(figUIobj.shiftDir, 'value', 1);
        sobj.shiftDir = 1;
        set(figUIobj.loop, 'value',0);
        set(figUIobj.loop, 'string', 'Loop-Out','BackGroundColor','r');
        set(figUIobj.stim, 'string','OFF','BackGroundColor','r');
        return;
    end
    %}
    %%%%%  check save file name  %%%%%
    ch_save
    %%%%%%%%%%%%%%%%%%%%%%
    
    %%%%%  main looping  %%%%%
    set(figUIobj.loop,'string','Looping','BackGroundColor','g');
    while floop == 1
        try %error check
            %{
%%%%%%%%%TTT%MacTest用５サイクル回ったらストップして Screen close
        if recobj.cycleNum == 1
            if sobj.ScrNum == 0;
                [sobj.wPtr, RECT] = Screen('OpenWindow', sobj.ScrNum,sobj.bgcol);
            end
        elseif recobj.cycleNum == 6
            Screen('CloseAll');
            stimset;
            set(figUIobj.loop,'string','Loop-Out','BackGroundColor','r')
            set(figUIobj.loop,'value',0);
            set(figUIobj.stim,'string','OFF')
            set(figUIobj.stim,'value',0);
            break;
        end
        CounterTest = CounterTest + 1;
%%%%%%%%%%%%%%%%%%
            %}
            switch get(figUIobj.RotaryCtr,'value')
                case 1
                    startBacground(sRot);
            end
            startBackground(s);
            
            %%%%%%%%%%%%%%%%%%%%%%%
            recobj.cycleNum = recobj.cycleNum +1;
            
            if fstim == 1%%visual stimlus ON
                visual_stimulus;
                %%% Timinig Mesure %%%
                recobj.tRec = sobj.vbl_1- recobj.RecStartTime; %Absolute time
                sobj.tPTBon = sobj.vbl_2 - sobj.vbl_1;
                sobj.tPTBoff = sobj.vbl_3 -  sobj.vbl_1;
                if strcmp(sobj.pattern, '2stim') == 1
                    sobj.tPTBon2 = sobj.vbl2_2 - sobj.vbl_1;
                    sobj.tPTBoff2 = sobj.vbl2_3 - sobj.vbl_1;
                end
            elseif fstim == 0%% visual stimulus OFF, Elechtorichal Rec Only
                trigger_AIFV;
                recobj.tRec = toc(recobj.STARTloop);
                recobj.TTL2 = 0;
                sobj.tPTBon = 0;
                sobj.tPTBon2 = 0;
                sobj.tPTBoff = 0;
                sobj.tPTBoff2 = 0;
                sobj.position = 0;
                sobj.position_cord = zeros(1,4);
                sobj.position_cord2 = zeros(1,4);
                sobj.stim2_center = zeros(1,2);
                sobj.dist_pix = 0;
            end
            
            %preview data はどうするか？
            %prevdata;<- いれるならこのあたり
            
            %%%%%%%%%%%%%%%%%
            %%%%%  data get   %%%%%
            %%%%%%%%%%%%%%%%%
            recobj.dataall = getdata(daq.ai)*1000;% mV
            
            %%%%%%%%%%%%%%%%%
            %%%%%   reset trigger   %%%%
            %%%%%%%%%%%%%%%%%
            outputSingleScan(sTrig,[0,0]); %trigger reset
            
            %%%%%%%%%%%%%%%%%
            %%%%%  data save  %%%%%
            %%%%%%%%%%%%%%%%%
            savedata;
            
            %%%%%%%%%%%%%%%%%
            %%%%%   data plot   %%%%%
            %%%%%%%%%%%%%%%%%
            plot_data;
            
            %%%%%%%%%%%%%%%%
            % ここで interval とる必あり？
            pause(recobj.interval);
        catch ME1
            Screen('CloseAll');
            rethrow(ME1);
        end
    end %%% Loop END %%%
    
    %%% Reset Cycle Num %%%
    recobj.cycleNum = 0- recobj.prestim;
    disp(['Loop-Out:', num2str(recobj.cycleNum)]);
    sobj.stimsz = stim_size(sobj.MonitorDist,figUIobj.size); %Random size の後 size を戻す
    sobj.stimsz2 = stim_size(sobj.MonitorDist,figUIobj.size2);
    wait(s, 20)
    clear recobj.STARTloop;
end