%公式7--集中决策求解（均匀分布）
%步骤一：求解最优订货量
%第一段区间 Qi+Qj<=200
[vj si taoij vi sj ci taoji Qi Qj]=solve('(Qi/200)-((vj-si-taoij)/(vi-si))*(0.5*(Qi/200)*(Qi/200)+(Qi/200)*(1-(Qi/200)-(Qj/200)))+((vi-sj-taoji)/(vi-si))*0.5*(Qj/200)*(Qj/200)=(vi-ci)/(vi-si)','vj=40','si=10','taoij=2','vi=40','sj=10','taoji=2','ci=20','Qi=Qj','vj','si','taoij','vi','sj','ci','taoji','Qi','Qj');
disp('集中决策下Qi+Qj<=200对应的解为（不一定最优）：');
disp(Qi);
%第二段区间 200-Qi<=Qj<=200
[vj si taoij vi sj ci taoji Qi Qj]=solve('(Qi/200)-((vj-si-taoij)/(vi-si))*(0.5*(1-(Qj/200))*(1-(Qj/200)))+((vi-sj-taoji)/(vi-si))*0.5*(1-(Qi/200))*(2*(Qj/200)+(Qi/200)-1)=(vi-ci)/(vi-si)','vj=40','si=10','taoij=2','vi=40','sj=10','taoji=2','ci=20','Qi=Qj','vj','si','taoij','vi','sj','ci','taoji','Qi','Qj');
disp('集中决策下200-Qi<=Qj<=200对应的解为（不一定最优）：');
disp(Qi);
%第三段区间 200<Qj<=400-Qi
[vj si taoij vi sj ci taoji Qi Qj]=solve('(Qi/200)+((vi-sj-taoji)/(vi-si))*(0.5*(1-(Qi/200))*(2*(Qj/200)+(Qi/200)-1)-0.5*((Qj/200)-1)*((Qj/200)-1))=(vi-ci)/(vi-si)','vj=40','si=10','taoij=2','vi=40','sj=10','taoji=2','ci=20','Qi=Qj','vj','si','taoij','vi','sj','ci','taoji','Qi','Qj');
disp('集中决策下200<Qj<=400-Qi对应的解为（不一定最优）：');
disp(Qi);


%步骤二：求解最大利润  
%思路：用积分求期望 xf(x)
%1.声明参数
s1=10; s2=10;
c1=20; c2=20;
r1=40; r2=40;
p1=0; p2=0;
tao12=2;
tao21=2;
%2.定义需求量d及其概率密度函数
syms d1 d2 d;   %定义符号变量
f1=1/200;   %密度函数的表达式;
f2=1/200;
f=1/200;
%3.计算最优订货量下的最大利润
Q1=119;   %这里需要根据运算结果修改
Q2=119;   %这里需要根据运算结果修改
D1=0:0.01:200;
D2=0:0.01:200;
T=zeros(20001,20001);   %T是转载量
LiRun=zeros(20001,20001);

for i=1:20001
    for j=1:20001
         if ((D2(j)-Q2)>0)&((Q1-D1(i))>0)    %i向外转
            T(i,j)=min((D2(j)-Q2),(Q1-D1(i)));
            LiRun(i,j)=r1*D1(i)+s1*(Q1-T(i,j)-D1(i))-tao12* T(i,j)+r2*(Q2+T(i,j)-p2*(D2(j)-Q2-T(i,j)));
         elseif ((Q2-D2(j))>0)&((D1(i)-Q1)>0)  %j向外转
            T(i,j)=min((Q2-D2(j)),(D1(i)-Q1)); 
            LiRun(i,j)=r1*(Q1+T(i,j))-p1*(D1(i)-(Q1+T(i,j)))-tao21* T(i,j)+r2*D2(j)+s2*(Q2-D2(j)-T(i,j));
         elseif ((D2(j)-Q2)>0)&((D1(i)-Q1)>0)  %i,j都不转   缺货时
            T(i,j)=0;
            LiRun(i,j)=r1*Q1-p1*(D1(i)-Q1)+r2*Q2-p2*(D2(j)-Q2);
         elseif ((D2(j)-Q2)<0)&((D1(i)-Q1)<0)  %i,j都不转   多货时
            T(i,j)=0;
            LiRun(i,j)=r1*D1(i)+s1*(Q1-D1(i))+r2*D2(j)+s2*(Q2-D2(j));
         end
     end
end
LiRunA=0.5*(sum(sum(LiRun*0.00005*0.00005))-c1*Q1-c2*Q2);
disp('集中决策最优订货量下的每个公司的最大利润为');
disp(LiRunA);



