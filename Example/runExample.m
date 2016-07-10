FitnessFunction = @(x) vectorized_fitness(x,100,1);
numberOfVariables = 2;
options = gaoptimset('Vectorized','on');
[x,fval] = ga(FitnessFunction,numberOfVariables,[],[],[],[],[],[],[],options)