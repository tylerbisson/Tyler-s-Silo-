function [ output ] = tylerssilosequence(input_sig, num_notes, note_len,...
    random_grain_len, random_stream_count, grain_lock, stream_lock,...
    platter_width, env, start_time)

% Tyler's Silo Sequence  is a function that creates a randomized sequence 
% using Tyler' Silo. 

%           input_sig: read in input signal using audioread 
%           num_notes: the amount of notes produced by function
%            note_len: note length in seconds
%    random_grain_len: an array of randomly selected grain length in 
%                      milliseconds, ex. [1, 100]
%      grain_lock = 1: if set to non-1 integer and random_grain_len set 
%                      to single integer, function will only use this 
%                      grain length. Can be set to 1 which allows grain 
%                      length randomization.
%  random_stream_count: an array of randomly selected stream counts 
%                       ex. [5, 20]
%          stream_lock: if set to non-1 integer and random_grain_len set 
%                       to single integer, function will only use this 
%                       grain length. Can be set to 1 which allows grain 
%                       length randomization.
%        platter_width: platter width is a multiplier of the window that 
%                       tylers silo selects grains from. A platter_width of
%                       one results results in no varience in grain
%                       selection, while a platter_width of two results in 
%                       a window two size that of the grain length from
%                       which tylers silo will randomly select a grain. 
%           start_time: this sets the postion where the grain selection 
%                       platter begins. 
%                  env: envelope for tylers silo output 

fs = 44100; 
outlen = (note_len*fs) * num_notes; 
output = zeros(1, outlen); 
output = output'; 
env = env'; 

    for notecount = 1:1:num_notes 
        sti = (note_len*fs) * (notecount - 1) + 1;
        endi = (note_len*fs) * notecount;
        grain_len = randi(random_grain_len) * grain_lock;
        num_streams = randi(random_stream_count) * stream_lock;
        note = tylerssilo(input_sig, grain_len, platter_width,...
            start_time, num_streams, note_len);
        
        output(sti:endi) =  output(sti:endi) + note.* env; 
    end
end

