% Tushar Nimbhorkar & Diede Rusticus
% Computer Vision '17
% Artificial Intelligence Master
% University of Amsterdam


% TODO: MAP and check fitting model

% Change the vocabulary size and number of iteration as needed
vocab_size = 400; % (800, 1600, 2000 and 4000)
N = 700;
descr_type = 'keypoints'; % 'dense', 'keypoints', 'RGBsift', 'rgbsift', 'Oppsift' 
classes = {'airplanes','motorbikes','faces','cars'};  
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
    [~,centers] = kmeans(single(D),vocab_size,'MaxIter',N,'Display','iter');
    filename = strcat('objects/centers_', num2str(vocab_size));
    save(filename, 'centers');
elseif exist('centers', 'var') ~= 1 && exist(strcat('objects/centers_', num2str(vocab_size),'.mat'),'file') == 2
    load(strcat('objects/centers_', num2str(vocab_size)));
end

% 2.3 & 2.4 & 2.5 Quantization and Classification %%%%%%%
disp('check for trained models and assign..')
for i=1:length(classes)
    if exist(strcat('objects/model_',char(classes(i)),'_',num2str(vocab_size),'_',descr_type,'.mat'), 'file') ~= 2
        disp(strcat(char(classes(i)), ' model not created yet, so making now..'))
        [model, X_train] = train_svm(folder, classes(i), vocab_size, centers, descr_type);
    end
    if exist(strcat('objects/model_',char(classes(i)),'_',num2str(vocab_size),'_',descr_type,'.mat'), 'file') == 2 
        load(strcat('objects/model_', char(classes(i)),'_', num2str(vocab_size), '_', descr_type));
        if i == 1
            model_airplanes = model;
        elseif i == 2
            model_motorbikes = model;
        elseif i == 3 
            model_faces = model;
        elseif i == 4
            model_cars = model;
        end
    end
end

disp('test data..')

classesids = zeros(nr_images, 1);
classesids(1:50,:) = 1;
classesids(51:100,:) = 2;
classesids(101:150,:) = 3;
classesids(151:200,:) = 4;

rank_airplanes = test_data(folder, vocab_size, centers, descr_type, classesids, model_airplanes);
rank_motorbikes = test_data(folder, vocab_size, centers, descr_type, classesids, model_motorbikes);
rank_faces = test_data(folder, vocab_size, centers, descr_type, classesids, model_faces);
rank_cars = test_data(folder, vocab_size, centers, descr_type, classesids, model_cars);

disp('calculating average precisions:')

rankedlists = {rank_airplanes rank_motorbikes rank_faces, rank_cars};

APs = zeros(1,4);
for i = 1:length(classes)
    sum_AP = 0;
    count = 0;
    for j = 1:nr_images
        ranking = cell2mat(rankedlists(i));
        if ranking(j,1) == i
            count = count + 1;
            sum_AP = sum_AP + (count/j);
        else
            sum_AP = sum_AP + (0/j);
        end
    end
    APs(:,i) = (1/50) * sum_AP;
end

MAP = mean(APs);
disp(APs);
disp(strcat('MAP: ',num2str(MAP))); 

disp('done!')
