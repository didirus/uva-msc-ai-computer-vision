% The task is to implement getCaltechIMDB function under finetunecnn.m 
% script. This function reads images, their labels (1. airplanes, 2. 
% cars, 3. faces, 4. motorbikes), and their splits (either training or 
% validation) from the data directory and creates imdb struct described above

%% main function 
% load
%% fine-tune cnn
% 
[net, info, expdir] = finetune_cnn();
save('data/fine_tuned_model.mat', 'net');
%% extract features and train svm

% TODO: Replace the name with the name of your fine-tuned model
nets.fine_tuned = load(fullfile('data', 'fine_tuned_model.mat')); 
nets.fine_tuned = nets.fine_tuned.net;
nets.pre_trained = load(fullfile('data', 'pre_trained_model.mat')); 
nets.pre_trained = nets.pre_trained.net; 
data = load(fullfile(expdir, 'imdb-caltech.mat'));
data.images.data = single(data.images.data);
% vl_simplenn_display(nets.pre_trained);

%% Visualisation


train_svm(nets, data);
visualize_net(nets.fine_tuned,data,'Fine tuned')
pause(5);
visualize_net(nets.pre_trained,data,'Pre trained')