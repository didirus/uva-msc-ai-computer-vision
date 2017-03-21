% Tushar Nimbhorkar & Diede Rusticus
% Computer Vision '17
% Artificial Intelligence Master
% University of Amsterdam


% TODO: MAP and check fitting model

% Change the vocabulary size and number of iteration as needed
vocab_size = 400; % (800, 1600, 2000 and 4000)
N = 700;
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
        train_svm(folder, classes(i), vocab_size, centers, descr_type);
    end
    if exist(strcat('objects/model_',char(classes(i)),'_',num2str(vocab_size),'_',descr_type,'.mat'), 'file') == 2
        
        load(strcat('objects/model_', char(classes(i)),'_', num2str(vocab_size), '_', descr_type));
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
if exist(strcat('X_test_',num2str(vocab_size), '_', descr_type,'.mat'), 'file') ~= 2
    [X_test, Y_a, Y_m, Y_f, Y_c] = get_test_data(folder, vocab_size, descr_type, centers);
    filename = strcat('objects/X_test_', num2str(vocab_size), '_', descr_type);
    save(filename, 'X_test');
elseif exist('X_test', 'var') ~= 1 && exist(strcat('X_test',num2str(vocab_size), '_', descr_type,'.mat'), 'file') == 2
    load(strcat('objects/X_test_', num2str(vocab_size), '_', descr_type, '.mat'));
end

disp('get class scores..')

% Initialise scores matrices for every class
scores_airplanes = zeros(nr_images,2);
scores_motorbikes = zeros(nr_images,2);
scores_faces = zeros(nr_images,2);
scores_cars = zeros(nr_images,2);

% Keep track of image index by filling the first collumns with index nrs
% 1:50 = airplanes, 51:100 = motorbikes, 101:150 = faces, 151:200 = cars
classesids = zeros(nr_images, 1);
classesids(1:50,:) = 1;
classesids(51:100,:) = 2;
classesids(101:150,:) = 3;
classesids(151:200,:) = 4;

scores_airplanes(:,1) = classesids;
scores_motorbikes(:,1) = classesids;
scores_faces(:,1) = classesids;
scores_cars(:,1) = classesids;

% Get class scores of test data according to every class model
[l_a, accuracy_a, d_p_a] = predict(Y_a, sparse(X_test), model_airplanes_train);
[l_m, accuracy_m, d_p_m] = predict(Y_m, sparse(X_test), model_motorbikes_train);
[l_f, accuracy_f, d_p_f] = predict(Y_f, sparse(X_test), model_faces_train);
[l_c, accuracy_c, d_p_c] = predict(Y_c, sparse(X_test), model_cars_train);

% Get the second column of the scores matrix because it represents the
% scores for the relevant class
scores_airplanes(:,2) = d_p_a;
scores_motorbikes(:,2) = d_p_m;
scores_faces(:,2) = d_p_f;
scores_cars(:,2) = d_p_c;

% Order the score matrices to get a ranking
disp('getting the ranked list..');
rank_airplanes = flipud(sortrows(scores_airplanes,2));
rank_motorbikes = flipud(sortrows(scores_motorbikes,2));
rank_faces = flipud(sortrows(scores_faces,2));
rank_cars = flipud(sortrows(scores_cars,2));

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


