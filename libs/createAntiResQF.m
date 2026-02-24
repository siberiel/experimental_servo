function sys_out = createAntiResQF(f_n, qz, qp, k)
    %CREATEANTIRESQF  周波数 f0 (Hz) を中心周波数とする反共振要素の伝達関数を返す
    %
    % 構文:
    %   sys = createAntiResQF(f_n, qz, qp, k);
    %
    % 入力:
    %   f_n : 反共振周波数 (Hz)
    %   Q_z : 分子のQ値（大きいほど谷が深くなる。例: 100以上）
    %   Q_p : 分母のQ値（大きいほど谷の幅が狭くなる。例: 0.707 〜 5）
    %   K   : ゲイン
    % 出力:
    %   sys : MATLAB Control System Toolbox の tf オブジェクト
    %
    % 補足:
    % 減衰比を指定する場合はcreateAntiResZETAを使用

    arguments
        f_n (1,1) double {mustBeFinite, mustBeReal, mustBePositive}
        qz  (1,1) double {mustBeFinite, mustBeReal, mustBePositive}
        qp  (1,1) double {mustBeFinite, mustBeReal, mustBePositive}
        k   (1,1) double {mustBeFinite, mustBeReal}
    end
    
    omega_n = 2 * pi * f_n;
    
    % Q値から係数（omega_n / Q）を計算
    num = k * [1, omega_n / qz, omega_n^2];
    den = [1, omega_n / qp, omega_n^2];
    
    sys_out = tf(num, den);

end
