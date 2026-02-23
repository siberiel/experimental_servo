%% DEFINE_PLANT.m
% 
% 制御対象の定義
% 

    % メカパラメータ
    mass = 3.5; % 3.5kg = 100[mm] * 100[mm] * 50[mm] * 2.7*10^3[kg/m^3]想定
    spring = 5e7; % 転がりガイド想定
    damping = 800; % 減衰比3%, c[Ns/m] = 2 * zeta * sqrt(mass * spring) = 2 * 0.03 * sqrt(3.5 * 5e7)

    % !将来的に追加したい要素
    % 動摩擦係数: 0.005, ガイドの転がり摩擦
    % コギング力: 推力の3%程度?, コアレスとの比較

    % プラントオブジェクトの生成
    sys_plant = createPlant(mass, spring, damping);
    bodeplot(sys_plant);
