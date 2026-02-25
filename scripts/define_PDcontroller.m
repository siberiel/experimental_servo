%% DEFINE_FBCONTROLLER1.m
% 
% フィードバックの定義
% 
% 1入力1出力
% 入力：位置指令と位置フィードバックの差（偏差）
% 出力：トルク指令
% 
    % プラントのパラメータ
    mass = 3.5;
    spring = 5e5;
    damping = 80;
    % damping = 8000;

    % 制御対象プラントの生成
    sys_plant = createPlant(mass, spring, damping);
    sys_res1 = createResonanceQF(1000, 10, 1.5);
    sys_ares1 = createAntiResQF(900, 100, 1, 1);
    sys_plant_res = sys_plant * sys_res1 * sys_ares1;

    % FBコントローラーのパラメータ
    Kp = 500000;
    Kd = 100;

    % PDコントローラーの生成
    sys_C = createPDcontroller(Kp, Kd);

    % 開ループ
    L = sys_C * sys_plant;

    % 閉ループ
    sys_CL = feedback(L, 1); % sys_CL = L / (1 + L)

    % 感度
    S = feedback(1, L); % S = 1 / (1 + L)

    subplot(2,1,1);
    bode(sys_C);
    subplot(2,1,2);
    bode(L);