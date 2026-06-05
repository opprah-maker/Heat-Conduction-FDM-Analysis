% MATLAB Simulation: 2D Heat Conduction (Finite Difference Method)

% Parameters
dx = 0.01;  % Grid spacing in x-direction
dy = 0.01;  % Grid spacing in y-direction
Lx = 0.1;   % Length of the plate in x-direction
Ly = 0.1;   % Length of the plate in y-direction
Nx = round(Lx/dx) + 1;  % Number of grid points in x
Ny = round(Ly/dy) + 1;  % Number of grid points in y
alpha = 1e-4;  % Thermal diffusivity
dt = 0.001;  % Time step
Tmax = 1;    % Maximum simulation time

% Initialize temperature field
T = zeros(Nx, Ny);

% Boundary Conditions
T(:,1) = 100; % Left boundary: 100C
T(:,end) = 50; % Right boundary: 50C
T(1,:) = 75;  % Top boundary: 75C
T(end,:) = 25; % Bottom boundary: 25C

% Time-stepping loop
for t = 0:dt:Tmax
    T_new = T;
    for i = 2:Nx-1
        for j = 2:Ny-1
            % Finite Difference Approximation (Explicit Scheme)
            T_new(i,j) = T(i,j) + alpha * dt * ((T(i+1,j) - 2*T(i,j) + T(i-1,j)) / dx^2 + ...
                                            (T(i,j+1) - 2*T(i,j) + T(i,j-1)) / dy^2);
        end
    end
    T = T_new;
end

% Post-Processing & Visualization
figure;
imagesc(T);
colorbar;
title('2D Heat Distribution');
xlabel('X Grid Points');
ylabel('Y Grid Points');

% Save results to file
csvwrite('heat_distribution_results.csv', T);
disp('Simulation complete. Results saved to heat_distribution_results.csv');
