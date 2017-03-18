function train_svm(class, vocab_size, centers, descr_type)

    [X, Y] = get_features_and_labels(class, vocab_size, centers, descr_type);
    model = fitcsvm(X,Y);
    filename = strcat('model_', char(class), '_', num2str(vocab_size), '_', descr_type);
    save(filename, 'model');
    
end

