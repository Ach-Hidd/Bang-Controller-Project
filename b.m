clear clc
s = tf('s');

Gs = 1/(s^2+0*s+0);
 
%PID 
Kp= 10;
Ki= 0.0;
Kd= Kp/2;
C = pid(Kp,Ki,Kd);
figure()
Gscl = feedback(series(C,Gs),1); 
step(Gscl);
legend('closed loop');
grid on;