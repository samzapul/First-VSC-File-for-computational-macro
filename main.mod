var y;
varexo e;
parameters rho;
rho = 0.9;

model;
y = rho*y(-1) + e;
end;

shocks;
var e; stderr 0.01;
end;

stoch_simul(order=1, irf=20);