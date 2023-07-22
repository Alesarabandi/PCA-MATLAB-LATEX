% Load data
load ModelReductionData.mat

% Plot 2D projections of data
for i = 1:6
    for j = i+1:6
        % Create a new figure for each pair of components
        figure()
        
        % Create a scatter plot with X(i,:) on the x-axis and X(j,:) on the y-axis
        scatter(X(i,:), X(j,:), 7, 'k', 'filled')
        
        % Label the x-axis and y-axis with the component numbers
        xlabel(['Component ', num2str(i)])
        ylabel(['Component ', num2str(j)])
        
        % Set the title of the plot with the component numbers
        title(['Scatter plot of Component ', num2str(i), ' vs. Component ', num2str(j)])
        
        % Set the axis to be equal and set the font size of the axis labels and title
        axis equal
        set(gca, 'FontSize', 20)
    end
end
