% Tushar Nimbhorkar & Diede Rusticus
% Computer Vision '17
% Artificial Intelligence Master
% University of Amsterdam

clear

experiment_nr = 1;
descr_type = 'keypoints';
descr_step_size = 1;
vocab_size = 400;
d_ims = 100;
nr_train_images = 100;
nr_test_images = 50;
kernel = 'linear';
N = 700;

experiment(experiment_nr,descr_type,descr_step_size,vocab_size,nr_train_images,nr_test_images, kernel,N, d_ims) 

experiment_nr = 2;
descr_type = 'dense';
descr_step_size = 10;
vocab_size = 400;
d_ims = 100;
nr_train_images = 100;
nr_test_images = 50;
kernel = 'linear';
N = 700;

experiment(experiment_nr,descr_type,descr_step_size,vocab_size,nr_train_images,nr_test_images, kernel,N, d_ims) 

experiment_nr = 3;
descr_type = 'dense';
descr_step_size = 10;
vocab_size = 800;
d_ims = 100;
nr_train_images = 100;
nr_test_images = 50;
kernel = 'linear';
N = 700;

experiment(experiment_nr,descr_type,descr_step_size,vocab_size,nr_train_images,nr_test_images, kernel,N, d_ims) 


experiment_nr = 4;
descr_type = 'dense';
descr_step_size = 10;
vocab_size = 1600;
d_ims = 100;
nr_train_images = 100;
nr_test_images = 50;
kernel = 'linear';
N = 700;

experiment(experiment_nr,descr_type,descr_step_size,vocab_size,nr_train_images,nr_test_images, kernel,N, d_ims) 


experiment_nr = 5;
descr_type = 'dense';
descr_step_size = 10;
vocab_size = 2000;
d_ims = 100;
nr_train_images = 100;
nr_test_images = 50;
kernel = 'linear';
N = 700;

experiment(experiment_nr,descr_type,descr_step_size,vocab_size,nr_train_images,nr_test_images, kernel,N, d_ims) 


experiment_nr = 6;
descr_type = 'dense';
descr_step_size = 10;
vocab_size = 4000;
d_ims = 100;
nr_train_images = 100;
nr_test_images = 50;
kernel = 'linear';
N = 700;

experiment(experiment_nr,descr_type,descr_step_size,vocab_size,nr_train_images,nr_test_images, kernel,N, d_ims) 
% 
% 
% experiment_nr = 7;
% descr_type = 'RGBSIFT';
% descr_step_size = 10;
% vocab_size = ????
% d_ims = 100;
% nr_train_images = 100;
% nr_test_images = 50;
% kernel = 'linear';
% N = 700;
% 
% experiment(experiment_nr,descr_type,descr_step_size,vocab_size,nr_train_images,nr_test_images, kernel,N, d_ims) 
% 
% 
% experiment_nr = 8;
% descr_type = 'rgbSIFT';
% descr_step_size = 10;
% vocab_size = ????
% d_ims = 100;
% nr_train_images = 100;
% nr_test_images = 50;
% kernel = 'linear';
% N = 700;
% 
% experiment(experiment_nr,descr_type,descr_step_size,vocab_size,nr_train_images,nr_test_images, kernel,N, d_ims) 
% 
% 
% experiment_nr = 9;
% descr_type = 'opponent';
% descr_step_size = 10;
% vocab_size = ????
% d_ims = 100;
% nr_train_images = 100;
% nr_test_images = 50;
% kernel = 'linear';
% N = 700;
% 
% experiment(experiment_nr,descr_type,descr_step_size,vocab_size,nr_train_images,nr_test_images, kernel,N, d_ims) 
% 
% 
% experiment_nr = 10;
% descr_type = ?????
% descr_step_size = 10;
% vocab_size = ?????
% d_ims = 100;
% nr_train_images = 50;
% nr_test_images = 50;
% kernel = 'linear';
% N = 700;
% 
% experiment(experiment_nr,descr_type,descr_step_size,vocab_size,nr_train_images,nr_test_images, kernel,N, d_ims) 
% 
% 
% experiment_nr = 11;
% descr_type = ???
% descr_step_size = 10;
% vocab_size = ???
% d_ims = 100;
% nr_train_images = 150;
% nr_test_images = 50;
% kernel = 'linear';
% N = 700;
% 
% experiment(experiment_nr,descr_type,descr_step_size,vocab_size,nr_train_images,nr_test_images, kernel,N, d_ims) 
% 
% 
% experiment_nr = 12;
% descr_type = ????
% descr_step_size = 10;
% vocab_size = ????
% d_ims = 100;
% nr_train_images = 250;
% nr_test_images = 50;
% kernel = 'linear';
% N = 700;
% 
% experiment(experiment_nr,descr_type,descr_step_size,vocab_size,nr_train_images,nr_test_images, kernel,N, d_ims) 
% 
% 
% experiment_nr = 13;
% descr_type = ????
% descr_step_size = 10;
% vocab_size = ????
% d_ims = 100;
% nr_train_images = ?????
% nr_test_images = 50;
% kernel = 'RBF';
% N = 700;
% 
% experiment(experiment_nr,descr_type,descr_step_size,vocab_size,nr_train_images,nr_test_images, kernel,N, d_ims) 
% 
% 
% experiment_nr = 14;
% descr_type = ???;
% descr_step_size = 10;
% vocab_size = ???
% d_ims = 100;
% nr_train_images = ????
% nr_test_images = 50;
% kernel = ?????
% N = 700;
% 
% experiment(experiment_nr,descr_type,descr_step_size,vocab_size,nr_train_images,nr_test_images, kernel,N, d_ims) 
% 

