function sys_out = createPDcontroller(Kp, Kd)
    % 複素変数 s の定義
    s = tf('s');

    % PDコントローラーの生成
    sys_out = Kp + Kd * s;
end