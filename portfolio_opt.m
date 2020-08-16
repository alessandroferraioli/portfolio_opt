
clc;
close all;
clear all;


% Input parameters
p = [0.25,0.35,0.4]; %Percentages of the portfolio
q = [30,49,79]; %Quotes for each stock
monthly = 337; %How much you want to spend
total = 0;
firstRun = true;
stop = false;
 
if(sum(p) == 1)
    % Setting the problem
    x = optimvar('x',3,1,'Type','integer','LowerBound',1);
    prob = optimproblem;
    prob.Objective = -q(1)*x(1) - q(2)*x(2)-q(3)*x(3); 
    prob.Constraints.cons2 = q(1)*x(1)<=monthly*p(1);
    prob.Constraints.cons3 = q(2)*x(2)<=monthly*p(2);
    prob.Constraints.cons4 = q(3)*x(3)<=monthly*p(3);

    options = optimoptions('intlinprog','Display','off');
    sol = solve(prob,'Options',options);

    % Printing solution
    if(length(sol.x)>=1)
        if(firstRun == true)
            firstRun = false
        end
        total = q(1)*sol.x(1) + q(2)*sol.x(2) + q(3)*sol.x(3);
        while(monthly-min(q)>total)
            disp("Rebalancing the solution");
            [minValue,minIndex] = min(q);
            sol.x(minIndex)  = sol.x(minIndex)+1;
            total = q(1)*sol.x(1) + q(2)*sol.x(2) + q(3)*sol.x(3);
        end
        fprintf("You're going to spend : %f\n",total);
        fprintf("Difference between monthly and total %f\n",monthly-total);
        disp("The solution is :");
        fprintf("x1: %d \nx2: %d \nx3: %d\n",sol.x(1),sol.x(2),sol.x(3));
    else
        disp("The problem doesn't have solution.Try to increase your monthly expense");
        stop = true;
    end

else
    disp("Sorry, the percentages input doesn't sum up to 1");
    stop = true;

end
