clear all
% close all
delta=0.1;
pp=[1,0];

payc=zeros(2,11);

for i=1:2
    p=pp(i);
    for j=1:11
        nc=j-1;

        payc(i,j)=(1 / (delta)) * ( (p * ((1+delta)^nc - 1) + ( (1-p) * (1 - (1-delta)^nc) ) ) );
    end
end

figure

bb=0:1:10;
plot(bb,payc(1,:))
hold on
plot(bb,bb)
hold on
plot(bb,payc(2,:))



hold off

xlabel('n_C')
ylabel('Common public goods')

legend('Synergy','Linear','Discounting')
