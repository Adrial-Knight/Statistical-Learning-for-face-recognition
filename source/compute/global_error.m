function error = global_error(confusion, exception)
    diag_conf = diag(confusion);
    diag_conf(exception) = [];
    success = sum(diag_conf) / length(diag_conf);
    error = 1 - success;
end
