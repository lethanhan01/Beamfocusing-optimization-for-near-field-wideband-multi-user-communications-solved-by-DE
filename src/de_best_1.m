function [best, fbest, history] = de_best_1(func, lb, ub, D, NP, F, Cr, Gmax)

pop = lb + rand(NP, D).*(ub - lb);
fitness = arrayfun(@(i) func(pop(i,:)), 1:NP)';
history = zeros(Gmax,1);

for g = 1:Gmax
    [~, best_idx] = min(fitness);
    best_vec = pop(best_idx,:);

    for i = 1:NP
        idx = randperm(NP,2);
        while any(idx == i)
            idx = randperm(NP,2);
        end

        x1 = pop(idx(1),:);
        x2 = pop(idx(2),:);
        donor = best_vec + F*(x1 - x2);

        trial = pop(i,:);
        jrand = randi(D);
        for j = 1:D
            if rand <= Cr || j == jrand
                trial(j) = donor(j);
            end
        end

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
