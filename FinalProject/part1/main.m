% Tushar Nimbhorkar & Diede Rusticus
% Computer Vision '17
% Artificial Intelligence Master
% University of Amsterdam

% All experiments with the different parameter combinations. Outcomment the
% experiment you want to test. At the bottom of this script the experiment
% function is called with the accompanying arguments. 

% Our original experiment setup was to evaluate the best setting for each
% parameter one at a time in the following order:
%
% - sampler             [keypoint/dense]        exp 1+2
% - voc. size           [400/800/1600/2000/4000]exp 3+4+5+6
% - descriptor          [RGB/rgb/opp/gray]      exp 7+8+9
% - nr. train images    [50/150/250]            exp 10+11+12
% - kernel function     [linear/RBF/polynomial] exp 13+14
%
% However, after running the experiments we found out that it is required
% to check for each descriptor both the keypoint and dense sampler option. 
% Therefore, we extended our experiment setup with exp 15+16 testing
% rgb/gray descriptors for keypoint sampling as well.


clear
 
% Exp 1+2 to choose between sampler [keypoints/dense]

experiment_nr = 1;
sampler = 'keypoints';
descriptor = 'RGB';
descr_stepsize = 1;
vocab_size = 400;
nr_feature_ims = 100;
nr_train_images = 100;
nr_test_images = 50;
kernel = 'linear';
N = 700;

% experiment_nr = 2;
% sampler = 'dense';
% descriptor = 'RGB';
% descr_stepsize = 10;
% vocab_size = 400;
% nr_feature_ims = 100;
% nr_train_images = 100;
% nr_test_images = 50;
% kernel = 'linear';
% N = 700;
% 
% % Dense is winner
% % Exp 3+4+5+6 to choose between voc. size [400/800/1600/2000/4000]
% 
% experiment_nr = 3;
% sampler = 'dense';
% descriptor = 'RGB';
% descr_stepsize = 10;
% vocab_size = 800;
% nr_feature_ims = 100;
% nr_train_images = 100;
% nr_test_images = 50;
% kernel = 'linear';
% N = 700;
% 
% experiment_nr = 4;
% sampler = 'dense';
% descriptor = 'RGB';
% descr_stepsize = 10;
% vocab_size = 1600;
% nr_feature_ims = 100;
% nr_train_images = 100;
% nr_test_images = 50;
% kernel = 'linear';
% N = 700;
% 
% experiment_nr = 5;
% sampler = 'dense';
% descriptor = 'RGB';
% descr_stepsize = 10;
% vocab_size = 2000;
% nr_feature_ims = 100;
% nr_train_images = 100;
% nr_test_images = 50;
% kernel = 'linear';
% N = 700;
% 
% experiment_nr = 6;
% sampler = 'dense';
% descriptor = 'RGB';
% descr_stepsize = 10;
% vocab_size = 4000;
% nr_feature_ims = 100;
% nr_train_images = 100;
% nr_test_images = 50;
% kernel = 'linear';
% N = 700;
% 
% % Voc. size 400 is winner
% % Exp 7+8+9 to choose between descriptor [RGB/rgb/opp/gray]
% 
% experiment_nr = 7;
% sampler = 'dense';
% descriptor = 'rgbSIFT';
% descr_stepsize = 10;
% vocab_size = 400;
% nr_feature_ims = 100;
% nr_train_images = 100;
% nr_test_images = 50;
% kernel = 'linear';
% N = 100;
% 
% experiment_nr = 8;
% sampler = 'dense';
% descriptor = 'opponent';
% descr_stepsize = 10;
% vocab_size = 400;
% nr_feature_ims = 100;
% nr_train_images = 100;
% nr_test_images = 50;
% kernel = 'linear';
% N = 700;
% 
% experiment_nr = 9;
% sampler = 'dense';
% descriptor = 'gray';
% descr_stepsize = 10;
% vocab_size = 400;
% nr_feature_ims = 100;
% nr_train_images = 100;
% nr_test_images = 50;
% kernel = 'linear';
% N = 100;
% 
% % Descriptor RGB is winner
% % Exp 10+11+12 to choose between nr. train images [50/150/250]
% 
% experiment_nr = 10;
% sampler = 'dense';
% descriptor = 'RGB';
% descr_stepsize = 10;
% vocab_size = 400;
% nr_feature_ims = 100;
% nr_train_images = 50;
% nr_test_images = 50;
% kernel = 'linear';
% N = 700;
% 
% experiment_nr = 11;
% sampler = 'dense';
% descriptor = 'RGB';
% descr_stepsize = 10;
% vocab_size = 400;
% nr_feature_ims = 100;
% nr_train_images = 150;
% nr_test_images = 50;
% kernel = 'linear';
% N = 700;
% 
% experiment_nr = 12;
% sampler = 'dense';
% descriptor = 'RGB';
% descr_stepsize = 10;
% vocab_size = 400;
% nr_feature_ims = 100;
% nr_train_images = 250;
% nr_test_images = 50;
% kernel = 'linear';
% N = 700;
% 
% % 250 train images is winner
% % Exp 13+14 to choose between kernel functions [linear/RBF/polynomial]
% 
% experiment_nr = 13;
% sampler = 'dense';
% descriptor = 'RGB';
% descr_stepsize = 10;
% vocab_size = 400;
% nr_feature_ims = 100;
% nr_train_images = 250;
% nr_test_images = 50;
% kernel = 'rbf';
% N = 700;
% 
% experiment_nr = 14;
% sampler = 'dense';
% descriptor = 'RGB';
% descr_stepsize = 10;
% vocab_size = 400;
% nr_feature_ims = 100;
% nr_train_images = 250;
% nr_test_images = 50;
% kernel = 'polynomial';
% N = 700;
% 
% % Linear kernel is winner
% % Exp 15+16 to check keypoint sampler for rgb and gray SIFTs
% 
% experiment_nr = 15;
% sampler = 'keypoints';
% descriptor = 'gray';
% descr_stepsize = 10;
% vocab_size = 400;
% nr_feature_ims = 100;
% nr_train_images = 100;
% nr_test_images = 50;
% kernel = 'linear';
% N = 100;
% 
% experiment_nr = 16;
% sampler = 'keypoints';
% descriptor = 'opponent';
% descr_stepsize = 10;
% vocab_size = 400;
% nr_feature_ims = 100;
% nr_train_images = 100;
% nr_test_images = 50;
% kernel = 'linear';
% N = 100;

experiment(experiment_nr,sampler,descriptor,descr_stepsize,vocab_size,nr_feature_ims,nr_train_images,nr_test_images,kernel,N) 

