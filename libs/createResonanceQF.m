function sys_out = createResonanceQF(f_n, qf, k)
    %CREATERESONANCEQF  周波数 f0 (Hz) を中心周波数とする共振要素の伝達関数を返す
    %
    % 構文:
    % sys  = createResonanceQF(f_n, qf, k);
    %
    % 入力:
    %   f_n: 中心周波数 (Hz)
    %   qf: Q値(Quality Factor) qf = 1/(2*zeta)
    %   k: ゲイン
    % 出力:
    %   sys - MATLAB Control System Toolbox の tf オブジェクト
    %
    % 補足:
    % 減衰比を指定する場合はcreateResonanceZETAを使用

    arguments
        f_n (1,1) double {mustBeFinite, mustBeReal, mustBePositive}
        qf  (1,1) double {mustBeFinite, mustBeReal, mustBePositive}
        k   (1,1) double {mustBeFinite, mustBeReal}
    end

    omega_n = 2 * pi * f_n; % 角周波数に変換

    % 二次系の標準形伝達関数を作成
    num = k * omega_n^2;
    den = [1, 1/qf * omega_n, omega_n^2];

    sys_out = tf(num, den);

end
