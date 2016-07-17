% parents — Row vector of parents chosen by the selection function
% options — Options structure
% nvars — Number of variables
% FitnessFcn — Fitness function
% state — Structure containing information about the current generation. 
%          The State Structure describes the fields of state.
% thisScore — Vector of scores of the current population
% thisPopulation — Matrix of individuals in the current population
% Other parameters are custom
% variableMaxValues — contains the max value for each gene
function mutationChildren = EAMutation(parents, options, nvars, FitnessFcn, state, thisScore, thisPopulation, variableMaxValues)
    % Get count of elements we need to mutate
    parentsLength = length(parents);
    % Get the Genomes we need to mutate
    parentsGenomes = thisPopulation(parents, :);
    % Sort a random gene for each Genome we need to mutate
    randomGene = randi(length(variableMaxValues), parentsLength, 1);
    % Get a random value to place on each of the sorted genes
    randomGeneValue = floor(rand(1, parentsLength).*variableMaxValues(randomGene)) + 1;
    
    % Copy parents and mutate acordingly
    mutationChildren = parentsGenomes;
    % RETURN
    mutationChildren(sub2ind(size(parentsGenomes), [1:parentsLength], randomGene')) = randomGeneValue;
end

% genomeLength = length(variableMaxValues);
% 
% % Get count of elements we need to mutate
% parentsLength = length(parents);
% % Get the Genomes we need to mutate
% parentsGenomes = thisPopulation(parents, :);
% % Sort a random genes for each Genome we need to mutate
% 
% % Set 1 to gene that must be mutated and 0 to others
% randomGenes = randi([0 1], parentsLength, genomeLength);
% randomGenesInverse = -(randomGenes-1);
% % Using randomGenes calculate random values for them
% mutatedGenes = (floor(rand(parentsLength, genomeLength)*diag(variableMaxValues)) + 1).*randomGenes;
% 
% RETURN
% mutationChildren = parentsGenomes.*randomGenesInverse + mutatedGenes.*randomGenes;