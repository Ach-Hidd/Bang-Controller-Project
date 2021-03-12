clf
clc
%Time:
t_ges = 2.5;
dt = 0.025;
t_vect = 0 : dt : t_ges;
%Initial position, Initial velocity, Initial acceleration:
q_0=0;
dq_0=0;
ddq_0=0;
%The position, velocity, acceleration:
q = q_0;
dq = dq_0;
ddq = dq_0;
%PD constants
Kp=100;
Kd=Kp/2;
% force limitation to Fmax (limitation of output of PD controller)
Fmax = 1;
%Matrices to store the calculate values:
n_times = length(t_vect);
q_Matrix = zeros(1, n_times);
dq_Matrix = zeros(1, n_times);
ddq_Matrix = zeros(1, n_times);
F_Matrix = zeros(1, n_times);
%// initiallize plot. Get a handle to graphic object
 f = figure(1);
 filename = 'ani.gif'; 
 set(gcf, 'Color', [1,1,1]);  %// I like a white background!
    s1 = subplot(3,1,1);
    p1 = plot(NaN,NaN,'b', 'LineWidth', 2); 
    title('Position')
    ylabel('m');
    axis([0 t_ges -0.25 1.25]);%// freeze axes to their final size, to prevent Matlab from rescaling them dynamically
    s2 = subplot(3,1,2);
    p2 = plot(NaN,NaN,'b', 'LineWidth', 2); 
    title('Velocity');
    ylabel('m/s');
    axis([0 t_ges -1 2]);%// freeze axes to their final size, to prevent Matlab from rescaling them dynamically
    s3 = subplot(3,1,3);
    p3 = plot(NaN,NaN,'b', 'LineWidth', 2); 
    title('Force');
    ylabel('N');
    axis([0 t_ges -Fmax*1.25 Fmax*1.25]);%// freeze axes to their final size, to prevent Matlab from rescaling them dynamically
    
for ci = 1:n_times
     %Velocity calculation:
     dq = dq + dt * ddq;
     dq_Matrix(1,ci) = dq;
    
     %position calculation:
     q = q + dt * dq;
     q_Matrix(1,ci) = q;
     
     %PD controller calculation: (closed-loop, with the reference is 1 meter (Point B))
     F = Kp*(1-q) + Kd*(0-dq);
     
     % force limitation (optionnal)
     if abs(F)> Fmax
         F = Fmax*sign(F);
     end
     F_Matrix(1,ci) = F;
     
     %acceleration calculation:
     ddq = F;
     ddq_Matrix(1,ci) = ddq;
     
    % update the plot
    ind = (1:ci);  
    t_plot = t_vect(ind);
    pause(0.01)
    set(p1, 'XData', t_plot, 'YData', q_Matrix(ind));
    set(p2, 'XData', t_plot, 'YData', dq_Matrix(ind));
    set(p3, 'XData', t_plot, 'YData', F_Matrix(ind));
    
     drawnow;                                                % draw to the screen
    frame = getframe(f);                                    % capture frame for file-writing
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,256);
    
    %%% Write the animated GIF %%%
    if ci==1;
          imwrite(imind,cm,filename,'gif', 'Loopcount',inf, 'DelayTime', .05); 
    elseif (mod(n, 1))==0;
          imwrite(imind,cm,filename,'gif','WriteMode','append', 'DelayTime', .05); 
     end 
    pause(.02)
end
