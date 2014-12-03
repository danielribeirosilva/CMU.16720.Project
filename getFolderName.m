function [foldername] = getFolderName(i)
    if i < 10
        foldername = ['0' num2str(i)];
    else
        foldername = num2str(i);
    end
    
end