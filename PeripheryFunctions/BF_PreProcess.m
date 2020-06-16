function y = BF_PreProcess(y,preProcessHow)
% BF_PreProcess   Preprocess a time series, y

% ------------------------------------------------------------------------------
% Copyright (C) 2020, Ben D. Fulcher <ben.d.fulcher@gmail.com>,
% <http://www.benfulcher.com>
%
% If you use this code for your research, please cite the following two papers:
%
% (1) B.D. Fulcher and N.S. Jones, "hctsa: A Computational Framework for Automated
% Time-Series Phenotyping Using Massive Feature Extraction, Cell Systems 5: 527 (2017).
% DOI: 10.1016/j.cels.2017.10.001
%
% (2) B.D. Fulcher, M.A. Little, N.S. Jones, "Highly comparative time-series
% analysis: the empirical structure of time series and their methods",
% J. Roy. Soc. Interface 10(83) 20130048 (2013).
% DOI: 10.1098/rsif.2013.0048
%
% This function is free software: you can redistribute it and/or modify it under
% the terms of the GNU General Public License as published by the Free Software
% Foundation, either version 3 of the License, or (at your option) any later
% version.
%
% This program is distributed in the hope that it will be useful, but WITHOUT
% ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
% FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
% details.
%
% You should have received a copy of the GNU General Public License along with
% this program. If not, see <http://www.gnu.org/licenses/>.
% ------------------------------------------------------------------------------

if ~isempty(preProcessHow)
    switch preProcessHow
    case 'diff1'
        % Takes incremental differences of the input time series
        y = diff(y);
    case 'rescale_tau'
        % Coarse-graining at a given scale, as in multiscale entropy approaches
        % Find first zero of the autocorrelation function
        tau = CO_FirstZero(y,'ac');
        % Buffer the time series into nonoverlapping windows of length tau
        y_buffer = BF_MakeBuffer(y,tau);
        % Mean each window to get a coarse-grained time series
        y = mean(y_buffer,2);
    otherwise
        error('Unknown preprocessing setting: ''%s''',preProcessHow);
    end
end

end