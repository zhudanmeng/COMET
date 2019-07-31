function dispv(str,verbose)

try
    if nargin<2
        verbose = 1;
    end
    
    if verbose
        disp(str)
    end
catch E
    disp(E.message)
end
