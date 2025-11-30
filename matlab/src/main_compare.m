clear; clc; close all;

func = @rastrigin;
D = 3;
lb = -5.12;
ub = 5.12;

NP = 50;
F = 0.8;
Cr = 0.9;
Gmax = 1000;   % tăng lên 1500 nếu muốn hội tụ tốt hơn

% ---- CHẠY 4 THUẬT TOÁN ----
[best1, fbest1, history1] = de_rand_1(func, lb, ub, D, NP, F, Cr, Gmax);
[best2, fbest2, history2] = de_best_1(func, lb, ub, D, NP, F, Cr, Gmax);
[best3, fbest3, history3] = de_current_to_best_1(func, lb, ub, D, NP, F, Cr, Gmax);
[best4, fbest4, history4] = jde(func, lb, ub, D, NP, Gmax);

% ---- VẼ HỘI TỤ ----
figure;
semilogy(history1, 'LineWidth', 1.5); hold on;
semilogy(history2, 'LineWidth', 1.5);
semilogy(history3, 'LineWidth', 1.5);
semilogy(history4, 'LineWidth', 1.5);

legend('DE/rand/1','DE/best/1','DE/current-to-best/1','jDE');
xlabel('Generations');
ylabel('Best fitness (log scale)');
title('So sánh hội tụ các biến thể DE trên hàm Rastrigin');
grid on;


% ---- IN KẾT QUẢ BEST FITNESS ----
disp('---- Final fbest values ----');
fprintf('DE/rand/1 best fitness: %.10f\n', fbest1);
fprintf('DE/best/1 best fitness: %.10f\n', fbest2);
fprintf('DE/current-to-best/1 best fitness: %.10f\n', fbest3);
fprintf('jDE best fitness: %.10f\n', fbest4);
