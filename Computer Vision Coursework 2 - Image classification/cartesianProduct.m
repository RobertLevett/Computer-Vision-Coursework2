function result = cartesianProduct(sets)
    c = cell(1, numel(sets));
    [c{:}] = ndgrid( sets{:} );
    A = cellfun(@(v)v(:), c, 'UniformOutput',false);
    result = [A{:}];
end