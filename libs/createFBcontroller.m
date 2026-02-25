function sys_out = createFBcontroller(Kp, Kv, Ts, Nsamp)
    % P: 位置ゲイン, V: 速度ゲイン, Ts: サンプリング周期, Nsamp: FB速度計算用サンプル数
    %
    % 入力: [r_pos; y]  (目標位置, 現在位置)
    % 出力: u (制御入力)

    % 状態変数の定義:
    % x1: r_pos(k-1)
    % x2~x(Nsamp+1): y(k-1) ~ y(k-Nsamp)
    nx = 1 + Nsamp;
    A = zeros(nx, nx);
    B = zeros(nx, 2);

    % --- 目標値側のシフトレジスタ (1サンプル遅延) ---
    % x1(k+1) = r_pos(k)
    B(1, 1) = 1;

    % --- フィードバック側のシフトレジスタ (Nsamp遅延) ---
    % x2(k+1) = y(k)
    B(2, 2) = 1;
    if Nsamp > 1
        % x3(k+1)=x2(k), x4(k+1)=x3(k)...
        A(3:end, 2:Nsamp) = eye(Nsamp-1);
    end

    % --- 出力方程式の係数計算 ---
    % 速度指令: v_ref = (r_pos(k) - r_pos(k-1)) / Ts
    % 速度FB:   v_fb  = (y(k) - y(k-Nsamp)) / (Nsamp * Ts)
    % u = P*(r_pos - y) + V*(v_ref - v_fb)
    
    K_v_ref = Kv / Ts;
    K_v_fb  = Kv / (Nsamp * Ts);

    % D行列 (現在の入力 [r_pos(k); y(k)] に掛かる係数)
    % u = (P + K_v_ref)*r_pos(k) - (P + K_v_fb)*y(k) + ...
    D = [(Kp + K_v_ref), -(Kp + K_v_fb)];

    % C行列 (状態変数 [r_pos(k-1); y(k-1); ...; y(k-Nsamp)] に掛かる係数)
    % u = ... - K_v_ref*r_pos(k-1) + K_v_fb*y(k-Nsamp)
    C = zeros(1, nx);
    C(1, 1) = -K_v_ref;      % r_pos(k-1) の項
    C(1, nx) = K_v_fb;       % y(k-Nsamp) の項

    % システム作成
    sys_out = ss(A, B, C, D, Ts);
    sys_out.InputName = {'r_pos', 'y_meas'};
    sys_out.OutputName = {'u'};
end