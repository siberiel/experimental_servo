function sys_out = createAmp(k, tau)
    %CREATEAmp アンプの線形システムオブジェクトを作成
    %
    % 構文:
    % sys = createAmp(k, tau);
    %
    % 入力:
    %   k: 推力定数[N/A]
    %   tau: 時定数[s]
    %
    % 出力:
    %   sys: 線形システムオブジェクト (tf)
    %

    arguments
        k (1,1) {mustBeNumeric, mustBeFinite, mustBePositive}
        tau (1,1) {mustBeNumeric, mustBeFinite, mustBePositive}
    end

    % 線形システムオブジェクト (状態空間表現) を作成
    num = k;
    den = [tau 1];
    sys_out = tf(num,den);
    
    % システムのプロパティを設定
    sys_out.Name = 'Amplifier Model';
    sys_out.InputName = 'Voltage (V)';
    sys_out.OutputName = 'Current (A)';

end
