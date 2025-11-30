function [best, fbest, history] = jde(func, lb, ub, D, NP, Gmax)

tau1 = 0.1;
tau2 = 0.1;

pop = lb + rand(NP, D).*(ub - lb);
F = 0.5*ones(NP,1);
Cr = 0.9*ones(NP,1);

fitness = arrayfun(@(i) func(pop(i,:)), 1:NP)';
history = zeros(Gmax,1);

for g = 1:Gmax

    for i = 1:NP
        if rand < tau1, F(i) = 0.1 + rand()*0.9; end
        if rand < tau2, Cr(i) = rand(); end

        idx = randperm(NP,3);
        while any(idx == i)
            idx = randperm(NP,3);
        end

        x1 = pop(idx(1),:);
        x2 = pop(idx(2),:);
        x3 = pop(idx(3),:);

        donor = x1 + F(i)*(x2 - x3);

        trial = pop(i,:);
        jrand = randi(D);
        for j = 1:D
            if rand <= Cr(i) || j == jrand
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
