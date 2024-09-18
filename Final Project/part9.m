%% adding the path of subfolders
clc;
addpath('D:\sharif\signals and system\project\functions');
addpath('D:\sharif\signals and system\project\database');
addpath('D:\sharif\signals and system\project\musics');
addpath('D:\sharif\signals and system\project\test_musics');

%% loading the created database
clear; close all; clc;

database = load('D:\sharif\signals and system\project\database\database.mat').database;

%% calculate the hash tags for the given song
snr=10;
prob_main=[];
while snr>=1 
    %importing an audio
    path = 'D:\sharif\signals and system\project\musics\'; % test musics path
    song_num = 27; % music i
    format = '.mp3';
    [downsampled_Fs, audioMono] = import_audio(path, song_num, format);
    % adding noise to the audio
    audioMono=awgn(audioMono,snr);
    L=length(audioMono);
    
    prob_temp=[];
    p=1;
    while p<=100
        start_time=1+floor(rand()*(L-(20*downsampled_Fs)));
        end_time=start_time+(20*downsampled_Fs);
        audio_sample=audioMono(start_time:end_time);

        % creating the time-freq matrix of the audio using fft and an overlapping sliding window with the length of "window_time"
        window_time = 0.1;
        [time, freq, time_freq_mat] = STFT(audio_sample, downsampled_Fs, window_time);

        % finding the anchor points from time_freq_mat using a sliding window with the size of 2dt*2df
        df = floor(0.1*size(time_freq_mat, 1)/4);
        dt = 2/window_time;
        % finding anchor points
        anchor_points = find_anchor_points(time_freq_mat, dt, df);
        
        % creating the hash tags using a window with the size of dt*2df for each anchor point
        df_hash = floor(0.1*size(time_freq_mat,1));
        dt_hash = 20/window_time;
        % creating hash-keys and hash-values for each pair of anchor points
        % Key format: (f1*f2*(t2-t1)) 
        % Value format: (song_name*time_from_start)
        [hash_key, hash_value] = create_hash_tags(anchor_points, df_hash, dt_hash, 0);

        % searching hash tags
        clc; close all;

        list = []; 
        % searching for found hash-keys in the database
        for i = 1:length(hash_key)
            key_tag = [num2str(hash_key(i, 1)), '*', num2str(hash_key(i, 2)), '*', num2str(hash_key(i, 3))];
            if (isKey(database, key_tag))
                temp1 = split(database(key_tag),'+');
                for j = 1:length(temp1)
                    temp2 = split(temp1{j},'*');
                    list = [list; [str2num(temp2{1}),str2num(temp2{2}),hash_value(i,2)]];
                end
            end
        end
        % scoring
        clc; close all;

        score=scoring(list);
        
        prob_temp=[prob_temp;score(1,2)];
        p=p+1;
    end
    prob_main=[prob_main;mean(prob_temp),snr];
    snr=snr-0.1; % step  of SNR 
end
% plot probability of audio1 and audio 2
plot(prob_main(:,2),prob_main(:,1),'Linewidth',1.5);
xlabel('SNR','interpreter','latex');
ylabel('probability','interpreter','latex');
title("average probability respect to SNR",'interpreter','latex');
grid on; grid minor;