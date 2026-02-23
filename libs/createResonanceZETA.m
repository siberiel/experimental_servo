function sys_out = createResonanceZETA(f_n, zeta, k)
    %CREATERESONANCEZETA  周波数 f0 (Hz) を中心周波数とする共振要素の伝達関数を返す
    %
    % 構文:
    % sys  = createResonanceZETA(f_n, zeta, k);
    %
    % 入力:
    %   f_n: 中心周波数 (Hz)
    %   zeta: 減衰比 (0 < zeta < 1)
    %   k: ゲイン
    % 出力:
    %   sys - MATLAB Control System Toolbox の tf オブジェクト
    %
    % 補足:
    % Q値を指定する場合はcreateResonanceQFを使用

    arguments
        f_n (1,1) double {mustBeFinite, mustBeReal, mustBePositive}
        zeta (1,1) double {mustBeFinite, mustBeReal, mustBeGreaterThan(zeta,0), mustBeLessThan(zeta,1)}
        k   (1,1) double {mustBeFinite, mustBeReal}
    end

    omega_n = 2 * pi * f_n; % 角周波数に変換

    % 二次系の標準形伝達関数を作成
    num = [k * omega_n^2];
    den = [1, 2 * zeta * omega_n, omega_n^2];

    sys_out = tf(num, den);

end
