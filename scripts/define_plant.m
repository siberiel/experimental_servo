%% DEFINE_PLANT.m
% 
% 制御対象の定義
% 

    % メカパラメータ
    mass = 3.5; % 3.5kg = 100[mm] * 100[mm] * 50[mm] * 2.7*10^3[kg/m^3]想定
    spring = 0; % 十分に剛性はあるものとして k = 0
    damping = 10;
    % 粘性抵抗はF=cvとして、定格速度0.5m/sで5N程度生じると仮定すると
    % c = 5[N]/0.5[m/s] = 10 [Ns/m]

    % !将来的に追加したい要素
    % 動摩擦係数: 0.005, ガイドの転がり摩擦
    % コギング力: 推力の3%程度?, コアレスとの比較

    % プラントオブジェクトの生成
    sys_plant = createPlant(mass, spring, damping);
    sys_res1 = createResonanceQF(1000, 10, 1.5);
    sys_ares1 = createAntiResQF(900, 100, 1, 1);
    sys_plant_res = sys_plant * sys_res1 * sys_ares1;
    hold on
    bodeplot(sys_plant);
    bodeplot(sys_plant_res);
    hold off
