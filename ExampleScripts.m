%% Example Scripts
% May 16, 2017

%% Tyler's Silo Example

    fs = 44100; 
    input_sig = audioread('BowieVocals.wav');
    grain_len = 50; % 1 to 100 milliseconds
    platter_width = 1.6; % multiplier of grain length
    start_time  = 2.267;
    num_streams = 100;
    outlength = 3; % in seconds 
    
    output1 = tylerssilo(input_sig, grain_len, platter_width,... 
        start_time, num_streams, outlength);   
    
    soundsc(output1,44100)

%% Tyler's Silo Sequence Example 1

    fs = 48000; 
    input_sig = audioread('VHS.wav');
    num_notes = 20;
    note_len = .1;
    random_grain_len = [1, 100];
    random_stream_count = 1;
    grain_lock = 1;
    stream_lock = 20;
    platter_width = 1;
    start_time  = 1.267;
    env = linspace(1,0,(note_len*fs));

    output2 = tylerssilosequence(input_sig, num_notes, note_len,...
              random_grain_len, random_stream_count, grain_lock,...
              stream_lock, platter_width, env, start_time);

    soundsc(output2,48000)
    
    %% Tyler's Silo Sequence Example 2

    fs = 44100; 
    input_sig = audioread('AlwaysForPleasureOrganGrinder.wav');
    num_notes = 200;
    note_len = .1;
    random_grain_len = [1, 100];
    random_stream_count = 10;
    grain_lock = 1;
    stream_lock = 20;
    platter_width = 1.2;
    start_time = 1;
    env = linspace(1,0,(note_len*fs));

    output3 = tylerssilosequence(input_sig, num_notes, note_len,...
              random_grain_len, random_stream_count, grain_lock,... 
              stream_lock, platter_width, env, start_time);

    soundsc(output3,44100)

%% Tyler's Silo Sequence Example 3

    fs = 44100; 
    input_sig = audioread('svega.wav');
    num_notes = 20;
    note_len = .5;
    random_grain_len = [5, 20];
    random_stream_count = [0, 50];
    grain_lock = 1;
    stream_lock = 1;
    platter_width = 1.06;
    start_time = 2;
    env = hann(note_len*fs);
    env = env';

    output4 = tylerssilosequence(input_sig, num_notes, note_len,...
              random_grain_len, random_stream_count, grain_lock,... 
              stream_lock, platter_width, env, start_time);
    output5 = tylerssilosequence(input_sig, num_notes, note_len,...
              random_grain_len, random_stream_count, grain_lock,... 
              stream_lock, platter_width, env, start_time);
    slam = output4 + output5;

    soundsc(slam,44100)
    
    