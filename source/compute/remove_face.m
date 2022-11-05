function [train, tests] = remove_face(train, tests, to_hide)
    if isempty(to_hide)
        return
    end
    face_id = unique(train.label)';
    face_id = face_id(to_hide);
    im_to_remove = sum(train.label == face_id, 2);
    train.images = train.images(:, ~im_to_remove);
    train.N = train.N - sum(im_to_remove);
    train.label = train.label(~im_to_remove);
    [train.size_cls, train.border , ~] = unique(train.label);
    train.Nc = length(train.size_cls);
    train.size_cls = [train.border(2:train.Nc)-train.border(1:train.Nc-1);train.N-train.border(train.Nc)+1];
    train.border = [train.border; train.N+1];

    label_to_hide = logical(sum(tests.label == face_id, 2));
    tests.label(label_to_hide) = Inf;
end
