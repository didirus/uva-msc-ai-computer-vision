function [model] = train_svm(class, X_train, vocab_size, kernel, descr_type, nr_train_images)
    
    % Get the labels of the train images
    Y_train = get_labels(class, 'train', nr_train_images);
    
    % Train the model according to the kernelfunction
    model = fitcsvm(X_train, Y_train, 'KernelFunction', kernel);
    
    % Save the model
    filename = strcat('objects/M_',char(class),'_',num2str(vocab_size),'_',descr_type,'_',num2str(nr_train_images),'_',kernel,'.mat');
    save(filename, 'model');
end

