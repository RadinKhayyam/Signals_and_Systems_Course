%% adding the path of subfolders
clc;
addpath('D:\sharif\signals and system\project\functions');
addpath('D:\sharif\signals and system\project\database');
addpath('D:\sharif\signals and system\project\musics');
addpath('D:\sharif\signals and system\project\test_musics');

%% loading the created database
clear; close all; clc;

database = load('D:\sharif\signals and system\project\database\database.mat').database;

% calculate the hash tags for the given song

% importing audios

path = 'D:\sharif\signals and system\project\musics\'; % test musics path
format = '.mp3';
song_num_1=27;
song_num_2=45;
[downsampled_Fs1, audio1] = import_audio(path, song_num_1, format); % music 27 - skyfall - adele 
[downsampled_Fs2, audio2] = import_audio(path, song_num_2, format);% music 45 - callin U - outlandish
audio1=audio1(146*downsampled_Fs1:166*downsampled_Fs1);% split song noumber 27 from seconde 146 to 166
audio2=audio2(1*downsampled_Fs2:21*downsampled_Fs2);% split song noumber 45 from seconde 146 to 166
alpha=0;
prob_audio_1=[];
prob_audio_2=[];
while alpha<=1

    audioMono=(1-alpha).*audio1+(alpha).*audio2; % sum of two signal with alpha and 1-alpha coefficients
    downsampled_Fs=downsampled_Fs1;

    % creating the time-freq matrix of the audio using fft and an overlapping sliding window with the length of "window_time"
    window_time = 0.1;
    [time, freq, time_freq_mat] = STFT(audioMono, downsampled_Fs, window_time);

    % a full screen figure for plots
    figure('Units','normalized','Position',[0 0 1 1])

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
    prob_audio_1=[prob_audio_1;score(score(:,1)==song_num_1,2),alpha];
    prob_audio_2=[prob_audio_2;score(score(:,1)==song_num_2,2),alpha];
    
    alpha=alpha + 0.05; % step of the alpha
end

% plot probability of audio1 and audio 2
plot(prob_audio_1(:,2),prob_audio_1(:,1),'Linewidth',1.5);
hold on;
plot(prob_audio_2(:,2),prob_audio_2(:,1),'Linewidth',1.5);
xlabel('alpha','interpreter','latex');
ylabel('probability','interpreter','latex');
title("probability respect to alpha",'interpreter','latex');
grid on; grid minor;
legend('audio 1','audio 2');
