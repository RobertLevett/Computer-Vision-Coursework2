function [T] = create_result_table(T,results)
    for i=1:length(results)
        row = [results{i,2} results{i,3}];
        T = [T; row];
    end
end

