%��ʽ7--���о�����⣨���ȷֲ���
%����һ��������Ŷ�����
%��һ������ Qi+Qj<=200
[vj si taoij vi sj ci taoji Qi Qj]=solve('(Qi/200)-((vj-si-taoij)/(vi-si))*(0.5*(Qi/200)*(Qi/200)+(Qi/200)*(1-(Qi/200)-(Qj/200)))+((vi-sj-taoji)/(vi-si))*0.5*(Qj/200)*(Qj/200)=(vi-ci)/(vi-si)','vj=40','si=10','taoij=2','vi=40','sj=10','taoji=2','ci=20','Qi=Qj','vj','si','taoij','vi','sj','ci','taoji','Qi','Qj');
disp('���о�����Qi+Qj<=200��Ӧ�Ľ�Ϊ����һ�����ţ���');
disp(Qi);
%�ڶ������� 200-Qi<=Qj<=200
[vj si taoij vi sj ci taoji Qi Qj]=solve('(Qi/200)-((vj-si-taoij)/(vi-si))*(0.5*(1-(Qj/200))*(1-(Qj/200)))+((vi-sj-taoji)/(vi-si))*0.5*(1-(Qi/200))*(2*(Qj/200)+(Qi/200)-1)=(vi-ci)/(vi-si)','vj=40','si=10','taoij=2','vi=40','sj=10','taoji=2','ci=20','Qi=Qj','vj','si','taoij','vi','sj','ci','taoji','Qi','Qj');
disp('���о�����200-Qi<=Qj<=200��Ӧ�Ľ�Ϊ����һ�����ţ���');
disp(Qi);
%���������� 200<Qj<=400-Qi
[vj si taoij vi sj ci taoji Qi Qj]=solve('(Qi/200)+((vi-sj-taoji)/(vi-si))*(0.5*(1-(Qi/200))*(2*(Qj/200)+(Qi/200)-1)-0.5*((Qj/200)-1)*((Qj/200)-1))=(vi-ci)/(vi-si)','vj=40','si=10','taoij=2','vi=40','sj=10','taoji=2','ci=20','Qi=Qj','vj','si','taoij','vi','sj','ci','taoji','Qi','Qj');
disp('���о�����200<Qj<=400-Qi��Ӧ�Ľ�Ϊ����һ�����ţ���');
disp(Qi);


%�����������������  
%˼·���û��������� xf(x)
%1.��������
s1=10; s2=10;
c1=20; c2=20;
r1=40; r2=40;
p1=0; p2=0;
tao12=2;
tao21=2;
%2.����������d��������ܶȺ���
syms d1 d2 d;   %������ű���
f1=1/200;   %�ܶȺ����ı��ʽ;
f2=1/200;
f=1/200;
%3.�������Ŷ������µ��������
Q1=119;   %������Ҫ�����������޸�
Q2=119;   %������Ҫ�����������޸�
D1=0:0.01:200;
D2=0:0.01:200;
T=zeros(20001,20001);   %T��ת����
LiRun=zeros(20001,20001);

for i=1:20001
    for j=1:20001
         if ((D2(j)-Q2)>0)&((Q1-D1(i))>0)    %i����ת
            T(i,j)=min((D2(j)-Q2),(Q1-D1(i)));
            LiRun(i,j)=r1*D1(i)+s1*(Q1-T(i,j)-D1(i))-tao12* T(i,j)+r2*(Q2+T(i,j)-p2*(D2(j)-Q2-T(i,j)));
         elseif ((Q2-D2(j))>0)&((D1(i)-Q1)>0)  %j����ת
            T(i,j)=min((Q2-D2(j)),(D1(i)-Q1)); 
            LiRun(i,j)=r1*(Q1+T(i,j))-p1*(D1(i)-(Q1+T(i,j)))-tao21* T(i,j)+r2*D2(j)+s2*(Q2-D2(j)-T(i,j));
         elseif ((D2(j)-Q2)>0)&((D1(i)-Q1)>0)  %i,j����ת   ȱ��ʱ
            T(i,j)=0;
            LiRun(i,j)=r1*Q1-p1*(D1(i)-Q1)+r2*Q2-p2*(D2(j)-Q2);
         elseif ((D2(j)-Q2)<0)&((D1(i)-Q1)<0)  %i,j����ת   ���ʱ
            T(i,j)=0;
            LiRun(i,j)=r1*D1(i)+s1*(Q1-D1(i))+r2*D2(j)+s2*(Q2-D2(j));
         end
     end
end
LiRunA=0.5*(sum(sum(LiRun*0.00005*0.00005))-c1*Q1-c2*Q2);
disp('���о������Ŷ������µ�ÿ����˾���������Ϊ');
disp(LiRunA);



