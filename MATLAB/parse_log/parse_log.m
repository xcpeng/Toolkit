function [] = parse_log()
    %This file will generate the accuracy, training loss and test loss of
    %the network
    filename = '7_mid_concat.txt';
    basedir = 'C:\Users\xpeng\Desktop\multi-channel\';
    keysentence = 'Test net output #50: accuracy =';
    filename = [basedir filename];
    fid = fopen(filename);
    tline = fgets(fid);
    
    len = 1;
    accuracy = zeros(120,1);
    train_loss = zeros(120,1);
    test_loss = zeros(120,1);
    while ischar(tline)
       % disp(tline);
        k = findstr(tline, keysentence);
        if ~isempty(k)
            s=tline(k:length(tline));
            p = findstr(s, '=');
            str_acc = s(p+2:end);
            accuracy(len) = str2double(str_acc);
            
            tline = fgets(fid); % next line to get the test loss
            
            start_p = findstr(tline, '=');
            end_p = findstr(tline, '(');
            str_test_loss = tline(start_p+1:end_p-1);
            test_loss(len) = str2double(str_test_loss);
            
            tline = fgets(fid); % get next line to get the train loss
            
            start_p = findstr(tline, '=');
            str_train_loss = tline(start_p+1:end);
          %  disp(str_train_loss);
            train_loss(len) = str2double(str_train_loss);
            
            len = len+1;
            
        end
        tline = fgets(fid);
    end
    accuracy = accuracy(1:len-2);
    train_loss = train_loss(1:len-2);
    test_loss = test_loss(1:len-2);
    
    disp(accuracy);
    %  disp(train_loss);
    %disp(test_loss);
    plot([1:len-2], accuracy);
    save([filename(1:end-4) '.mat'], 'accuracy', 'train_loss', 'test_loss');
    fclose(fid);
end

function made = mkdir_if_missing(path)
made = false;
if exist(path) == 0
  unix(['mkdir -p ' path]);
  made = true;
end
end