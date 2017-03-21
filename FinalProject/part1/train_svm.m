function [ model, X_train ] = train_svm(imageset, class, vocab_size, centers, descr_type)

    X_train = get_features(imageset, vocab_size, centers, descr_type, 'train');
    Y_train = get_labels(class, 'train');
    model = fitcsvm(X_train, Y_train);
    filename = strcat('objects/model_', char(class), '_', num2str(vocab_size), '_', descr_type, '.mat');
    save(filename, 'model');
    
end

