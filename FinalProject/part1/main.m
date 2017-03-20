% Tushar Nimbhorkar & Diede Rusticus
% Computer Vision '17
% Artificial Intelligence Master
% University of Amsterdam


% TODO: MAP and check fitting model

% Change the vocabulary size and number of iteration as needed
vocab_size = 400; % (800, 1600, 2000 and 4000)
N = 500;
descr_type = 'keypoints'; % 'dense', 'keypoints', 'RGBsift', 'rgbsift', 'Oppsift' 
classes = {'airplanes_train','motorbikes_train','faces_train','cars_train'};  

folder = '../Caltech4/ImageData/';
nr_images = 200;

% 2.1 Feature Extraction and Description
disp('feature extraction..')
if exist(strcat('objects/D_', descr_type, '.mat'), 'file') ~= 2
    disp('no D file yet, so making now..')
    D = feature_extraction(folder, descr_type);
    filename = strcat('objects/D_', descr_type);
    save(filename, 'D');
elseif exist('D', 'var') ~= 1
    load(strcat('objects/D_', descr_type, '.mat'));
end


% 2.2: K-means: get cluster means
disp('k-means..')
if exist(strcat('objects/centers_',num2str(vocab_size),'.mat'), 'file') ~= 2
    disp('no cluster centers yet, so making now..')
    [~,centers] = kmeans(single(D),vocab_size,'MaxIter',N);
    filename = strcat('objects/centers_', num2str(vocab_size));
    save(filename, 'centers');
elseif exist('centers', 'var') ~= 1 && exist(strcat('objects/centers_', num2str(vocab_size),'.mat'),'file') == 2
    load(strcat('objects/centers_', num2str(vocab_size)));
end

% 2.3 & 2.4 & 2.5 Quantization and Classification %%%%%%%
for i=1:length(classes)
%     if exist(strcat('objects/model_',char(classes(i)),'_',num2str(vocab_size),'_',descr_type,'.mat'), 'file') ~= 2
    disp(strcat('no ', char(classes(i)), ' model yet, so making now..'))
    [X] = train_svm(folder, classes(i), vocab_size, centers, descr_type);
%     end
    if exist(strcat('model_', char(classes(i))), 'var') ~= 1 && exist(strcat('objects/model_',char(classes(i)),'_',num2str(vocab_size),'_',descr_type,'.mat'), 'file') == 2
        disp('getting models..')
        load(strcat('model_', char(classes(i)),'_', num2str(vocab_size), '_', descr_type));
        if i == 1
            model_airplanes_train = model;
        elseif i == 2
            model_motorbikes_train = model;
        elseif i == 3 
            model_faces_train = model;
        elseif i == 4
            model_cars_train = model;
        end
    end
end

disp('get test data..')
if exist(strcat('test_data_',vocab_size, '_', descr_type,'.mat'), 'file') ~= 2
    test_data = get_test_data(folder, vocab_size, descr_type, centers);
    filename = strcat('objects/test_data_', num2str(vocab_size), '_', descr_type);
    save(filename, 'test_data');
elseif exist('test_data', 'var') ~= 1 && exist(strcat('test_data_',vocab_size, '_', descr_type,'.mat'), 'file') == 2
    load(strcat('objects/test_data_', num2str(vocab_size), '_', descr_type, '.mat'));
end

disp('get class scores..')
% Initialise scores matrices for every class
scores_airplanes = zeros(nr_images,2);
scores_motorbikes = zeros(nr_images,2);
scores_faces = zeros(nr_images,2);
scores_cars = zeros(nr_images,2);

% Keep track of image index by filling the first collumns with index nrs
scores_airplanes(:,1) = 1:nr_images;
scores_motorbikes(:,1) = 1:nr_images;
scores_faces(:,1) = 1:nr_images;
scores_cars(:,1) = 1:nr_images;

% Get class scores of test data according to every class model
[l_a, s_a, ~] = predict(model_airplanes_train,test_data);
[l_m, s_m, ~] = predict(model_motorbikes_train,test_data);
[l_f, s_f, ~] = predict(model_faces_train,test_data);
[l_c, s_c, ~] = predict(model_cars_train,test_data);

% Get the second column of the scores matrix because it represents the
% scores for the relevant class
scores_airplanes(:,2) = s_a(:,2);
scores_motorbikes(:,2) = s_m(:,2);
scores_faces(:,2) = s_f(:,2);
scores_cars(:,2) = s_c(:,2);

% Order the score matrices to get a ranking
[~, order] = sort(scores_airplanes(:,2));
rank_airplanes = scores_airplanes(order,:);

[~, order] = sort(scores_motorbikes(:,2));
rank_motorbikes = scores_motorbikes(order,:);

[~, order] = sort(scores_faces(:,2));
rank_faces = scores_faces(order,:);

[~, order] = sort(scores_cars(:,2));
rank_cars = scores_cars(order,:);


