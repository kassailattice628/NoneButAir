%function RotaryDecoder
sRot = daq.createSession('ni');
%Dat acquisition counter input position channel 'ctr0' on 'Dev2')
ch1 = addCounterInputChannel(s, 'Dev2', 0, 'position');%

%{
ch1 default properties
EncoderType: X1 (X1, X2,or X4 are available)
ZresetEnalbe: 0
ZresetValue: 0
ZresetCondition: BothHigh
%CTR0‚¾‚Æ
TerminalA: 'PFI8'
TerminalB: 'PFI10'
TerminalC: 'PFI9'
%}

%{
%Read encoder position on demand
encoderPosition = inputSingleScan(s);

encoderCRP = 1000;
encoderPositionDeg = encoderPosition * 360/encoderCRP;
%}

%Acquire hardware-timed encoder position data
addAnaloginputChannel(s,'Dev2',0,'Voltage');
s.Rate;
s.DurationInSeconds;

[positionData, timestamps] = startforeground(s);

counterNBits = 32;
signedThreshold = 2^(counterBits-1);
singedData = positionData(:,1);
singedData(signedData > signedThreshold) = singnedData(singnedData > singnedThreshold) - 2^counterNBits;

positionDataDeg = signedData + 360/encoderCPR;

figure; plot(timestamps, positionDataDeg);
xlabel('Time(s)');
ylabel('Anagular position (deg)');

ch1.ZresetEnable = true;
ch1.ZresetCondition = 'BothLow';%('BothLow', 'BothHigh', 'AHigh' or 'BHigh' are availabe)

[positionData2, timestaps2] = startForeground(s);
figure; plot(timestamps2, positionData2(:,1));
xlabel('Time (s)');
ylabel('Counter value for quadrature encoder (counts)');

