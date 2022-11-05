function output = data_extraction(path)
    fld = dir(path);
    
    % Size of the training set
    nb_elt = length(fld);
    str_len = 0;
    i = 1;
    while (str_len < 3)
        str_len = length(fld(i).name);
        i = i + 1;
    end
    Im = imread([path fld(i).name]);
    P = numel(Im);
    N = length(fld([fld.isdir]==0));
    dim_im = size(Im);
    
    % Data matrix containing the training images in its columns 
    images = zeros(P, N); 
    % Vector containing the class of each training image
    label = zeros(N, 1);
    di = 0;
    for i=1:nb_elt
        if fld(i).isdir == false
            label(i + di) = str2double(fld(i).name(6:7));
            img = double(imread([path fld(i).name]));
            images(:, i+di) = img(:);
        else
            di = di - 1;
        end
    end

    [~,I] = sort(label);
    images = images(:,I);
    [cls_trn, bd , ~] = unique(label);
    Nc = length(cls_trn); 
    % Number of training images in each class
    size_cls = [bd(2:Nc)-bd(1:Nc-1);N-bd(Nc)+1];

    border = [bd; N+1];

    output = struct("images", images, "label", label, "Nc", Nc, "size_cls", size_cls, "border", border, "dim_im", dim_im, "N", N, "P", P);
end
