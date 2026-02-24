function sys = resonantTF(f0,varargin)
% RESONANTTF  周波数 f0 (Hz) を中心周波数とする共振要素の伝達関数を返す
%
% sys = resonantTF(f0)                         % デフォルト: Q=10, Gain=1, Type='bandpass'
% sys = resonantTF(f0,'Q',20,'Gain',2,'Type','secondorder')
%
% 入力:
%   f0    - 中心周波数 [Hz] (正のスカラー)
% Name-Value:
%   'Q'    - 品質係数 (正のスカラー). デフォルト 10
%   'zeta' - 減衰比 (正のスカラー). 指定された場合は 'Q' を上書き
%   'Gain' - ゲイン (スカラー). デフォルト 1
%   'Type' - 'bandpass' または 'secondorder' (デフォルト 'bandpass')
%
% 出力:
%   sys - MATLAB Control System Toolbox の tf オブジェクト
%
% 備考:
%   角周波数は $\omega_0 = 2\pi f_0$ とする。
%
% 入力は下で inputParser により検証します
% パーサ (Name-Value)
p = inputParser;
addRequired(p,'f0',@(x)isnumeric(x) && isscalar(x) && x>0);
addParameter(p,'Q',10,@(x)isnumeric(x) && isscalar(x) && x>0);
addParameter(p,'zeta',[],@(x) isempty(x) || (isnumeric(x) && isscalar(x) && x>0));
addParameter(p,'Gain',1,@(x)isnumeric(x) && isscalar(x));
addParameter(p,'Type','bandpass',@(s) any(validatestring(s,{'bandpass','secondorder'})));
parse(p,f0,varargin{:});

f0 = p.Results.f0;
Q = p.Results.Q;
zeta = p.Results.zeta;
G = p.Results.Gain;
type = validatestring(p.Results.Type,{'bandpass','secondorder'});

if ~isempty(zeta)
    % zeta が明示されている場合は優先
    z = zeta;
else
    % Q から減衰比を計算: zeta = 1/(2Q)
    z = 1/(2*Q);
end

omega0 = 2*pi*f0;

% 伝達関数を作成
s = tf('s');
switch type
    case 'bandpass'
        % 標準2次帯域通過形: G * (2*zeta*omega0*s) / (s^2 + 2*zeta*omega0*s + omega0^2)
        sys = G * (2*z*omega0*s) / (s^2 + 2*z*omega0*s + omega0^2);
    case 'secondorder'
        % 標準2次系 (並列ピーク): G * (omega0^2) / (s^2 + 2*zeta*omega0*s + omega0^2)
        sys = G * (omega0^2) / (s^2 + 2*z*omega0*s + omega0^2);
    otherwise
        error('Unsupported Type.');
end

end
