function phase_portraits()
close all
clc

tspan = [0 100];
figure()
ylabel('Xdot')
xlabel('x')
hold on
for x0 = -100:10:100
    for xdot0 = -100:10:100
        xinitial = [x0;xdot0];
        [tout, stateout] = ode45(@Derivatives, tspan, xinitial);
        %% Plotting with respect to time
        %plot(tout,stateout)
        %%Phase Plane:
        xout = stateout(:,1);
        xdotout = stateout(:,2);
        plot(xout, xdotout)
        drawnow
    end
end

function dstatedt = Derivatives(t, state)

x = state(1);
xdot = state(2);

xdbdot = 1;
%xdbdot = -1;

dstatedt = [xdot; xdbdot];
