% parents — Row vector of parents chosen by the selection function
% options — Options structure
% nvars — Number of variables
% FitnessFcn — Fitness function
% state — Structure containing information about the current generation. 
%          The State Structure describes the fields of state.
% thisScore — Vector of scores of the current population
% thisPopulation — Matrix of individuals in the current population
% Other parameters are custom
% problemObj — Contains the problem definition
% variableMaxValues — contains the max value for each gene
function mutationChildren = EAMutation(parents, options, nvars, FitnessFcn, state, thisScore, thisPopulation, problemObj, variableMaxValues)
    populationSize = gaoptimget(options, 'PopulationSize');
    
    % For each gene and each individual calculate which gene must be
    % mutated with a probability of 
    randomGenes = rand(populationSize, nvars) <= problemObj.MutationFraction;
    % Calculate matrix with genes that aren't mutated
    randomGenesInverse = -(randomGenes-1);
    
    % Calculate values for mutated genes
    mutatedGenes = (floor(rand(populationSize, nvars)*diag(variableMaxValues)) + 1).*randomGenes;
    
    % RETURN
    mutationChildren = thisPopulation.*randomGenesInverse + mutatedGenes.*randomGenes;
    mutationChildren = mutationChildren(parents, :);
end