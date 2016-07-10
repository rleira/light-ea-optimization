% thisPopulation — matrix containing population
% Other parameters are custom
% problemObj — object with variables of the problem
% lowRankObj — object with low rank matrices
% positionObj — object with luminarie position variables
% luminarieObj — object with luminarie variables
function fitness = EAFitness(thisPopulation, problemObj, lowRankObj, positionObj, luminarieObj)

    populationSize = length(thisPopulation);
    EPop = zeros(populationSize, problemObj.triangleCount);
    selectedLuminaryPop = zeros(populationSize, problemObj.lumCount);
    
    % Calculate the Emissions for each member of the population
    for memberId=1:populationSize
        VExtr = thisPopulation(memberId, :);
        E=zeros(problemObj.triangleCount,1);
        % Calculate E for each genome in the current population
        for VExtrIndex=1:problemObj.lumCount
            lowerLimit = (((VExtrIndex - 1) * problemObj.nvars ) + 1);
            VExtrAux = VExtr(lowerLimit:lowerLimit+2);

            % Calculate the emision merging both the view hemicube with the
            % radiance hemicube taken from the luminaire
            position = find(problemObj.selectedIndexesOrdered==positionObj.positionsMapMatrix(VExtrAux(1), VExtrAux(2)));

            fileName = [problemObj.luminarieLocation int2str(VExtrAux(3))];
            luminDisc = load(fileName);
            lumE = accumarray([positionObj.positionsMatrix(position, :) problemObj.triangleCount]', [luminDisc.a 0]);
            E = E + lumE(1:problemObj.triangleCount);
            
            positions(VExtrIndex) = position;
            selectedLuminary(VExtrIndex) = VExtrAux(3);
        end
        % Store single solution on vector in matrix containing all population
        EPop(memberId, :) = E;
        selectedLuminaryPop(memberId, :) = selectedLuminary;
    end
    
    EPop = EPop*lowRankObj.RmeanMatrix;
    
    EPop = EPop';
    %%%%%%%%%%%%%%%%%%%%%%%%%PROBLEMS SOLVERS%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %---------------------------------------
    % Optimize Power Find min and max luxes:
    %---------------------------------------
    B = -lowRankObj.Yp*(lowRankObj.V*EPop) + EPop(problemObj.objectiveSelectedIndexesOrdered, :);
    objetivo = sum(luminarieObj.luminairePower(selectedLuminaryPop), 2);
    
    % Penalty
    c1 = ((max(100 - (min(B, [], 1)/problemObj.areaPatch), zeros(1, populationSize)).^2)*100);
    [row col values] = find(c1>0);
    c1(col) = c1(col) + luminarieObj.maxPower*problemObj.lumCount; % c1 >= maxPower
    
    c2 = ((max((max(B, [], 1)/problemObj.areaPatch) - 750, zeros(1, populationSize)).^2)*100);
    [row col values] = find(c2>0);
    c2(col) = c2(col) + luminarieObj.maxPower*problemObj.lumCount; % c2 >= maxPower

    objetivo = objetivo + c1' + c2';
    %---------------------------------------
    
    % RETURN
    fitness = objetivo;
end

