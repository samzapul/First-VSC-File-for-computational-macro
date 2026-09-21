% Run from this folder. All parameters are illustrative per-period values.
% VS Code edits this file; MATLAB or GNU Octave runs it.
alpha=0.5; delta=0.10; A=1; T=80; savings=[0.25 0.30];
K=zeros(T+1,2); Y=zeros(T,2); C=Y; invest=Y; K(1,:)=4;
for scenario=1:2
    for t=1:T
        Y(t,scenario)=A*K(t,scenario)^alpha;
        invest(t,scenario)=savings(scenario)*Y(t,scenario);
        C(t,scenario)=Y(t,scenario)-invest(t,scenario);
        K(t+1,scenario)=(1-delta)*K(t,scenario)+invest(t,scenario);
    end
end
budget=Y-C-invest;
capital=K(2:end,:)-(1-delta)*K(1:end-1,:)-invest;
assert(max(abs(budget(:)))<1e-10 && max(abs(capital(:)))<1e-10);
assert(abs(K(2,1)-4.1)<1e-10 && abs(C(1,1)-1.5)<1e-10);
assert(abs(K(2,2)-4.2)<1e-10 && abs(C(1,2)-1.4)<1e-10);
output_dir=fullfile(fileparts(mfilename('fullpath')),'figures');
if ~exist(output_dir,'dir'), mkdir(output_dir); end
figure; plot(0:T,K,'LineWidth',1.5); xlabel('Period'); ylabel('Capital, goods');
legend('s=0.25','s=0.30','Location','southeast'); grid on;
print(fullfile(output_dir,'lab01_capital.png'),'-dpng');
figure; plot(0:T-1,C,'LineWidth',1.5); xlabel('Period'); ylabel('Consumption, goods');
legend('s=0.25','s=0.30','Location','southeast'); grid on;
print(fullfile(output_dir,'lab01_consumption.png'),'-dpng');
save(fullfile(output_dir,'lab01_results.mat'),'K','Y','C','invest','savings','alpha','delta','A','-v7');
fprintf('Lab01: first-period arithmetic and all accounting residuals pass.\n');
