function sys_out = createAntiResZETA(f_n, zeta_z, zeta_p, k)
    %CREATERESONANCEZETA  周波数 f0 (Hz) を中心周波数とする共振要素の伝達関数を返す
    %
    % 構文:
    %   sys = createAntiResZETA(f_n, zeta_z, zeta_p, k);
    %
    % 入力:
    %   f_n    : 反共振周波数 (Hz)
    %   zeta_z : 零点の減衰比（小さいほど谷が深くなる。例: 0.01）
    %   zeta_p : 極の減衰比（谷の肩の広さを決める。例: 0.7）
    %   K      : ゲイン
    % 出力:
    %   sys : MATLAB Control System Toolbox の tf オブジェクト
    %
    % 補足:
    % Q値を指定する場合はcreateAntiResQFを使用

    arguments
        f_n (1,1) double {mustBeFinite, mustBeReal, mustBePositive}
        zeta_z (1,1) double {mustBeFinite, mustBeReal, mustBeNonnegative}
        zeta_p (1,1) double {mustBeFinite, mustBeReal, mustBePositive}
        k   (1,1) double {mustBeFinite, mustBeReal}
    end
    
    omega_n = 2 * pi * f_n;
    
    % 分子 (Numerator): 零点によって「谷」を作る
    num = k * [1, 2 * zeta_z * omega_n, omega_n^2];
    % 分母 (Denominator): システムを安定させ、高域ゲインを平坦にする
    den = [1, 2 * zeta_p * omega_n, omega_n^2];
    
    sys_out = tf(num, den);

end
