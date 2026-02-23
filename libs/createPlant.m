function sys_out = createPlant(m, k, c)
    %CREATEPLANT バネマスダンパ系の線形システムオブジェクトを作成
    %
    % 構文:
    %   sys = createPlant(m, k, c);
    %
    % 入力パラメータ:
    %   m  - 質量 (kg)
    %   k  - ばね定数 (N/m)
    %   c  - ダンパ定数 (N·s/m)
    %
    % 出力:
    %   sys - 線形システムオブジェクト (ss)
    %
    % 説明:
    %   バネマスダンパ系の微分方程式:
    %       m*y'' + c*y' + k*y = F
    %   
    %   状態変数: x1 = y (位置), x2 = y' (速度)
    %   状態方程式:
    %       dx1/dt = x2
    %       dx2/dt = -(k/m)*x1 - (c/m)*x2 + (1/m)*F
    %   
    %   出力:
    %       y = x1 (位置)

    arguments
        m (1,1) {mustBeNumeric, mustBeFinite, mustBePositive}
        k (1,1) {mustBeNumeric, mustBeFinite, mustBeNonnegative}
        c (1,1) {mustBeNumeric, mustBeFinite, mustBeNonnegative}
    end

    % 状態空間表現の係数行列
    A = [0, 1; -k/m, -c/m];
    B = [0; 1/m];
    C = [1, 0];
    D = 0;
    
    % 線形システムオブジェクト (状態空間表現) を作成
    sys_out = ss(A, B, C, D);
    
    % システムのプロパティを設定
    sys_out.InputName = 'Force (N)';
    sys_out.OutputName = 'Position (m)';
    sys_out.StateName = {'Position (m)', 'Velocity (m/s)'};
    
end
