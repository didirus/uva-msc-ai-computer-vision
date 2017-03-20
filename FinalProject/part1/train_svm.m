function train_svm(imageset, class, vocab_size, centers, descr_type)

    [X, Y] = get_features_and_labels(imageset, class, vocab_size, centers, descr_type);
    model = train(Y, sparse(X));
    filename = strcat('objects/model_', char(class), '_', num2str(vocab_size), '_', descr_type);
    save(filename, 'model');
    
end

