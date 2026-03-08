function sys_out = createMotor(k)
    %CREATEMOTOR モーターの線形システムオブジェクトを作成
    %
    % 構文:
    % sys = createMotor(k);
    %
    % 入力:
    %   k: 推力定数[N/A]
    %
    % 出力:
    %   sys: 線形システムオブジェクト (tf)
    %

    arguments
        k (1,1) {mustBeNumeric, mustBeFinite, mustBePositive}
    end

    % 線形システムオブジェクト (状態空間表現) を作成
    sys_out = tf(k);
    
    % システムのプロパティを設定
    sys_out.Name = 'Motor Thrust Model';
    sys_out.InputName = 'Current (A)';
    sys_out.OutputName = 'Thrust (N)';

end
