%HW6
%GB comments
1a 100
1b 100
1c 100
1d 100
1e 100
2a 100
2b 100
2c  90 Need to discuss a bit more here. For example, there are still low pvalues when the variance is low. Can you explain that?
Overall: 99


% Problem 1. Curve fitting. 
% Part 1. Take 10 x values on the interval 0 < x <= 10 and then create y
% values from the x values by plugging the x values into a third order
% polynomial of your choice. Add random noise to the data by choosing a random number
% in the interval [-D, D]. Start with D = 1. Plot your data in the x-y plane.

x_values = sort(10*rand(10, 1));
y_values = (x_values.^3 - 2*x_values.^2 + 3*x_values - 25) + 2*rand(10,1)-1;
scatter(x_values, y_values);
    
% Part 2. Fit your data with polynomials from order 1 to 9. Plot the fitted
% polynomials together with the data. 

for ii = 1:9
    p = strcat('poly', num2str(ii));
    fit_ln = fit(x_values, y_values, p);
    plot(fit_ln, x_values, y_values);
    hold on;
end

% Part 3. On a separate plot, plot the R^2 and adjusted R^2 as a function
% of the order of the polynomial. 

rsquare = zeros(1,9);
radjust = zeros(1,9);
for ii = 1:9
    p = strcat('poly', num2str(ii));
    [FO, G] = fit(x_values, y_values, p);
    rsquare(ii) = G.rsquare;
    radjust(ii) = G.adjrsquare;
end

poly_order = 1:9;
subplot(1,2,1);
plot(poly_order, rsquare); title('rsquare');  hold on;
subplot(1,2,2);
plot(poly_order, radjust); title('radjust');

% Part 4. Repeat parts 1 - 3 for D = 10 and D = 1000. Comment on the
% results. 

% D = 10

x_values = sort(10*rand(10, 1));
y_values = (x_values.^3 - 2*x_values.^2 + 3*x_values - 25) + 20*rand(10,1)-10;
scatter(x_values, y_values);

for ii = 1:9
    p = strcat('poly', num2str(ii));
    fit_ln = fit(x_values, y_values, p);
    plot(fit_ln, x_values, y_values);
    hold on;
end

rsquare = zeros(1,9);
radjust = zeros(1,9);
for ii = 1:9
    p = strcat('poly', num2str(ii));
    [FO, G] = fit(x_values, y_values, p);
    rsquare(ii) = G.rsquare;
    radjust(ii) = G.adjrsquare;
end

poly_order = 1:9;
subplot(1,2,1);
plot(poly_order, rsquare); title('rsquare');  hold on;
subplot(1,2,2);
plot(poly_order, radjust); title('radjust');

% D = 1000

x_values = sort(10*rand(10, 1));
y_values = (x_values.^3 - 2*x_values.^2 + 3*x_values - 25) + 2000*rand(10,1)-1000;
scatter(x_values, y_values);

for ii = 1:9
    p = strcat('poly', num2str(ii));
    fit_ln = fit(x_values, y_values, p);
    plot(fit_ln, x_values, y_values);
    hold on;
end

rsquare = zeros(1,9);
radjust = zeros(1,9);
for ii = 1:9
    p = strcat('poly', num2str(ii));
    [FO, G] = fit(x_values, y_values, p);
    rsquare(ii) = G.rsquare;
    radjust(ii) = G.adjrsquare;
end

poly_order = 1:9;
subplot(1,2,1);
plot(poly_order, rsquare); title('rsquare');  hold on;
subplot(1,2,2);
plot(poly_order, radjust); title('radjust');

% As you increase the noise (from D = 1 to D = 10, or from D = 10 to D =
% 1000), it becomes increasingly harder to find a polynomial that will fit
% the x and y data. At higher noise, only very high-order polynomials
% will fit the x and y data with a reasonble R-squared value. At lower
% noise, some lower-order polynomials are still able to fit the x and y
% data fairly well.

% Part 5. Now repeat parts 1-3 but take 100 x values on the interval 0 < x <=
% 10. Comment on the results. 

x_values = sort(10*rand(100, 1));
y_values = (x_values.^3 - 2*x_values.^2 + 3*x_values - 25) + 2*rand(100,1)-1;
scatter(x_values, y_values);

for ii = 1:9
    p = strcat('poly', num2str(ii));
    fit_ln = fit(x_values, y_values, p);
    plot(fit_ln, x_values, y_values);
    hold on;
end

rsquare = zeros(1,9);
radjust = zeros(1,9);
for ii = 1:9
    p = strcat('poly', num2str(ii));
    [FO, G] = fit(x_values, y_values, p);
    rsquare(ii) = G.rsquare;
    radjust(ii) = G.adjrsquare;
end

poly_order = 1:9;
subplot(1,2,1);
plot(poly_order, rsquare); title('rsquare');  hold on;
subplot(1,2,2);
plot(poly_order, radjust); title('radjust');

% With 100 points taken rather than 10, the initial scatter plot of x and y
% values yields a smoother curve. This smoother curve makes the polynomial
% fitting process easier, and more lower-order polynomials fit the x and y
% data well. The R squared value more rapidly rises to near 1 after the 
% first or second order polynomial fits. 

% Problem 2. Basic statistics. 
% Part 1. Consider two different distributions - Gaussian numbers with a mean of
% 0 and variance 1 and Gaussian numbers with a mean of 1 and variance 1.
% (1) Make a plot of the average p-value for the t-test comparing N random
% numbers chosen from each of these two distributions as a function of N.

N = 100;
for ii = 1:N
    pval = [];
    for xx = 1:N %Find average p-value for given N over 100 trials
        dist1 = randn(1, ii);
        dist2 = 1 + randn(1, ii);
        [is_sig, pval(xx)] = ttest2(dist1, dist2);
    end
    avg_pval = sum(pval)/100;
    plot(ii, avg_pval, 'r.'); hold on;
end
xlabel('N'); ylabel('p-value');

% Part 2. Now keep the first distribution the same, but vary the mean of
% the second distribution between 0 and 10 with the same variance and
% repeat part one. Make a plot of all of these different curves on the same
% set of axes. What is special about the case where the mean of the second
% distribution is 0? 

N = 100;
for yy = 1:11 %Vary mean of second distribution (subtract by one later)
    for ii = 1:N
        pval = [];
        for xx = 1:N %Find average p-value for given N over 100 trials
            dist1 = randn(1, ii);
            dist2 = (yy-1) + randn(1, ii);
            [is_sig, pval(xx)] = ttest2(dist1, dist2);
        end
        avg_pval(yy, ii) = sum(pval)/100; %Create matrix of p-values per varying mean 
    end  
end
for ii = 1:11
    plot(1:N, avg_pval(ii, :));
    hold on;
end
xlabel('N'); ylabel('p-value');

% When second distribution has mean of 0, it is basically the same as
% distribution 1 and thus, the average p-value curve should be high, as 
% observed; increasing the mean will decrease the average p-value

% Part 3. Now keep the means of the two distributions at 0 and 1 as in part
% 1, but vary the variance of both distributions simultaneiously between 0.1 and 10 and plot the 
% p-values vs the number of numbers drawn as before. Comment on your results.  

N = 100;
for yy = 1:10 %Vary variances of both distributions (subtract by 0.9 later for 0.1 to 10 variance)
    for ii = 1:N
        pval = [];
        for xx = 1:N %Find average p-value for given N over 100 trials
            dist1 = (yy-0.9).*randn(1, ii);
            dist2 = 1 + (yy-0.9).*randn(1, ii);
            [is_sig, pval(xx)] = ttest2(dist1, dist2);
        end
        avg_pval(yy, ii) = sum(pval)/100; %Create matrix of p-values per varying variances 
    end  
end
for ii = 1:10
    plot(1:N, avg_pval(ii, :));
    hold on;
end
xlabel('N'); ylabel('p-value');

% This seems to produce more variation. As the variance for both
% distributions increase, the average p-value curves show higher average
% p-values; there starts to be very little statistical significance between
% the two distributions as the variance for both distributions increases. 
