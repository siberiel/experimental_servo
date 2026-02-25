%% DEFINE_FBCONTROLLER2.m
% 
% フィードバックの定義
% 
% 2入力1出力
% 入力：位置指令, 位置フィードバック
% 出力：トルク指令
% 速度指令は位置指令の1サンプル差分
% 速度フィードバックは位置フィードバックのNsampサンプル差分
% 

    % FBコントローラーのパラメータ
    Kp = 100;
    Kv = 10;
    Ts = 0.01;
    Nsamp = 3;

    % FBコントローラー生成
    sys_Cfb = createFBcontroller(Kp, Kv, Ts, Nsamp);

    