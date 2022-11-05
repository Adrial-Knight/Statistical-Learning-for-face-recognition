function confusion = confmat(guess, expect)
    labels = unique([expect, guess]);
    m = length(labels);
    confusion = zeros(m, m);
    for i = 1:m
        true_index = (expect == labels(i));
        for j = 1:m
            confusion(i, j) = mean(guess(true_index) == labels(j));
        end
    end
end
