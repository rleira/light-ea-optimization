% GenomeLength — genome length
% FitnessFcn — Fitness function
% options — Options for optimization, 'gaoptimset'
% other parameters are custom
% —
function Population = EAInit(GenomeLength, FitnessFcn, options, variableMaxValues)
    populationSize = gaoptimget(options, 'PopulationSize');
    Population = floor(rand(populationSize, GenomeLength)*diag(variableMaxValues)) + 1;
end