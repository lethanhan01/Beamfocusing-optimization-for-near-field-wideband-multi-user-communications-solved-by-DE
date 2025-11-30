function [best, fbest, history] = de_rand_1(func, lb, ub, D, NP, F, Cr, Gmax)

pop = lb + rand(NP, D).*(ub - lb);
fitness = zeros(NP,1);
for i = 1:NP
    fitness(i) = func(pop(i,:));
end

history = zeros(Gmax,1);

for g = 1:Gmax
    for i = 1:NP
        % chọn 3 chỉ số khác nhau
        idx = randperm(NP,3);
        while any(idx==i)
            idx = randperm(NP,3);
        end
        
        x1 = pop(idx(1),:);
        x2 = pop(idx(2),:);
        x3 = pop(idx(3),:);

        % mutation
        donor = x1 + F*(x2 - x3);

        % crossover
        trial = pop(i,:);
        jrand = randi(D);
        for j = 1:D
            if rand <= Cr || j == jrand
                trial(j) = donor(j);
            end
        end

        % selection
        ftrial = func(trial);
        if ftrial <= fitness(i)
            pop(i,:) = trial;
            fitness(i) = ftrial;
        end
    end

    history(g) = min(fitness);
end

[fbest, idx] = min(fitness);
best = pop(idx,:);

end
