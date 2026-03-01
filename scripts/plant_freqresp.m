%% PLANT_FREQRESP.m
% 

    % メカパラメータ
    m = 3.5; % 3.5kg = 100[mm] * 100[mm] * 50[mm] * 2.7*10^3[kg/m^3]想定
    k = 0; % 十分に剛性はあるものとして k = 0
    c = 10;
    % 粘性抵抗はF=cvとして、定格速度0.5m/sで5N程度生じると仮定すると
    % c = 5[N]/0.5[m/s] = 10 [Ns/m]

    % プラントオブジェクトの生成
    num = 1.0;
    den = [m c k];
    sys_plant = tf(num, den);
    bp = bodeplot(sys_plant);
    bp.XLimits = [1e-2 1e2];
    bp.YLimits(1) = {[-150 50]};
    bp.YLimits(2) = {[-185 5]};

    % sys_rigidbody = tf(1,[3.5 0 0]);
    % hold on
    % bodeplot(sys_rigidbody);

    % saveas(gcf,"docs/plant_freqresp/plant_frd.png");