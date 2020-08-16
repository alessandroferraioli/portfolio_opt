
clc;
close all;
clear all;


% Input parameters
p = [0.25,0.35,0.4]; %Percentages of the portfolio
q = [30,49,79]; %Quotes for each stock
monthly = 200; %How much you want to spend

% Setting the problem
x = optimvar('x',3,1,'Type','integer','LowerBound',0);
prob = optimproblem;
prob.Objective = -q(1)*p(1)*x(1) - q(2)*p(2)*x(2)-q(3)*p(3)*x(3); 
prob.Constraints.cons1 = q(1)*p(1)*x(1) + q(2)*p(2)*x(2) + q(3)*p(3)*x(3) <=monthly;

options = optimoptions('intlinprog','Display','off');
sol = solve(prob,'Options',options);

% Printing solution
total = q(1)*p(1)*sol.x(1) + q(2)*p(2)*sol.x(2) + q(3)*p(3)*sol.x(3);
fprintf("You're going to spend : %f\n",total);
disp("The solution is :");
fprintf("x1: %d \nx2: %d \nx3: %d\n",sol.x(1),sol.x(2),sol.x(3));
