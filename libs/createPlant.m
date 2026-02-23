function sys = createPlant(m, k, c)
%SPRING_MASS_DAMPER_SYSTEM バネマスダンパ系の線形システムオブジェクトを作成
%
% 構文:
%   sys = spring_mass_damper_system(m, k, c)
%
% 入力パラメータ:
%   m  - 質量 (kg)
%   k  - ばね定数 (N/m)
%   c  - ダンパ定数 (N·s/m)
%
% 出力:
%   sys - 線形システムオブジェクト (tf または ss クラス)
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
%
% 使用例:
%   sys = spring_mass_damper_system(1, 10, 0.5);
%   step(sys);

    % 入力値のバリデーション
    validateattributes(m, {'numeric'}, {'positive', 'scalar'}, mfilename, 'm');
    validateattributes(k, {'numeric'}, {'positive', 'scalar'}, mfilename, 'k');
    validateattributes(c, {'numeric'}, {'nonnegative', 'scalar'}, mfilename, 'c');

    % 状態空間表現の係数行列
    A = [0, 1; -k/m, -c/m];
    B = [0; 1/m];
    C = [1, 0];
    D = 0;
    
    % 線形システムオブジェクト (状態空間表現) を作成
    sys = ss(A, B, C, D);
    
    % システムのプロパティを設定
    sys.InputName = 'Force (N)';
    sys.OutputName = 'Position (m)';
    sys.StateName = {'Position (m)', 'Velocity (m/s)'};
    
end
