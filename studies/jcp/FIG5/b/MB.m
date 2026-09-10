clear; clc; close all;

BASE_DIR  = pwd;
DUMP_FILES = {'static.lammpstrj', '10G10A.lammpstrj', '20G20A.lammpstrj'};

LEGEND     = {'0 m/s', '10 m/s', '40 m/s'};
LEGEND_fit = {'0 m/s - fit', '10 m/s - fit', '40 m/s - fit'};

WATER_TYPE = 1;
N_LAST     = 10;

BIN_WIDTH = 0.00005;
V_MIN     = 0.0;
V_MAX     = 0.02;
EDGES     = V_MIN:BIN_WIDTH:V_MAX;
CENTERS   = (EDGES(1:end-1) + EDGES(2:end)) / 2;

defaultColors = [
    0.0000 0.4470 0.7410
    0.8500 0.3250 0.0980
    0.9290 0.6940 0.1250
];

nCases = numel(DUMP_FILES);

avgPdfAll = cell(nCases,1);
meanAll   = nan(nCases,1);
pSigma    = nan(nCases,1);
fitPdfAll = cell(nCases,1);
fitStats  = struct([]);

figure('Position',[100 100 600 400]); 
hold on; box on;

for i = 1:nCases

    dumpPath = fullfile(BASE_DIR, DUMP_FILES{i});

    if ~isfile(dumpPath)
        error('File not found: %s', dumpPath);
    end

    [avgPdfAll{i}, meanAll(i)] = read_speed_lastN_frames( ...
        dumpPath, WATER_TYPE, EDGES, N_LAST);

    [pSigma(i), fitPdfAll{i}, st] = fit_maxwell_sigma(CENTERS, avgPdfAll{i});

    fitStats(i).R2  = st.R2;
    fitStats(i).SSE = st.SSE;

    sigma = pSigma(i);

    fprintf('\n===== %s =====\n', LEGEND{i});
    fprintf('Fitted sigma = %.6g\n', sigma);
    fprintf('f(v) = sqrt(2/pi) * (v^2 / %.6g^3) * exp(-v^2 / (2*%.6g^2))\n', ...
        sigma, sigma);
    fprintf('R^2 = %.5f\n', fitStats(i).R2);

end

for i = 1:nCases

    scatter(CENTERS, avgPdfAll{i}, 8, ...
        'MarkerEdgeColor', defaultColors(i,:), ...
        'MarkerFaceColor', defaultColors(i,:), ...
        'DisplayName', LEGEND{i});

    plot(CENTERS, fitPdfAll{i}, '--', ...
        'Color', defaultColors(i,:), ...
        'LineWidth', 2, ...
        'DisplayName', LEGEND_fit{i});

    fprintf('%-6s | mean(speed, water) over last %d frames = %.6g\n', ...
        LEGEND{i}, N_LAST, meanAll(i));

end

xlabel('Velocity magnitude (\AA/fs)', 'Interpreter', 'latex');
ylabel('Probability density (fs/\AA)', 'Interpreter', 'latex');

legend('Location', 'best', 'Interpreter', 'latex');

ax = gca;
ax.LineWidth = 1.5;
ax.FontSize = 20;
ax.TickLabelInterpreter = 'latex';

function [avgPdf, meanSpeed] = read_speed_lastN_frames(dumpFile, waterType, edges, nLast)

    fid = fopen(dumpFile, 'r');
    if fid < 0
        error('Cannot open file: %s', dumpFile);
    end
    cleanupObj = onCleanup(@() fclose(fid));

    nBins = numel(edges) - 1;
    binW  = diff(edges);

    bufPdf  = zeros(nLast, nBins);
    bufMean = nan(nLast, 1);

    sumPdf  = zeros(1, nBins);
    sumMean = 0.0;

    frameIdx = 0;

    while ~feof(fid)

        line = fgetl(fid);
        if ~ischar(line)
            break;
        end

        if ~startsWith(line, 'ITEM: TIMESTEP')
            continue;
        end

        fgetl(fid);

        fgetl(fid);
        nAtoms = str2double(fgetl(fid));

        fgetl(fid); 
        fgetl(fid); 
        fgetl(fid); 
        fgetl(fid);

        header = fgetl(fid);
        toks = strsplit(strtrim(header));
        colNames = toks(3:end);
        nCols = numel(colNames);

        idxType = find(strcmp(colNames, 'type'), 1);
        idxVx   = find(strcmp(colNames, 'vx'),   1);
        idxVy   = find(strcmp(colNames, 'vy'),   1);
        idxVz   = find(strcmp(colNames, 'vz'),   1);

        fmt  = repmat('%f', 1, nCols);
        data = textscan(fid, fmt, nAtoms, ...
            'Delimiter', ' ', ...
            'MultipleDelimsAsOne', true, ...
            'CollectOutput', true);

        A = data{1};

        isWater = A(:, idxType) == waterType;

        vx = A(isWater, idxVx);
        vy = A(isWater, idxVy);
        vz = A(isWater, idxVz);

        good = isfinite(vx) & isfinite(vy) & isfinite(vz);

        vx = vx(good);
        vy = vy(good);
        vz = vz(good);

        if isempty(vx)
            continue;
        end

        vx = vx - mean(vx);
        vy = vy - mean(vy);
        vz = vz - mean(vz);

        speed = sqrt(vx.^2 + vy.^2 + vz.^2);

        counts = histcounts(speed, edges);

        if sum(counts) == 0
            continue;
        end

        pdf = counts ./ (sum(counts) * binW);
        mu  = mean(speed);

        frameIdx = frameIdx + 1;
        slot = mod(frameIdx-1, nLast) + 1;

        if frameIdx > nLast
            sumPdf  = sumPdf  - bufPdf(slot,:);
            sumMean = sumMean - bufMean(slot);
        end

        bufPdf(slot,:) = pdf;
        bufMean(slot)  = mu;

        sumPdf  = sumPdf  + pdf;
        sumMean = sumMean + mu;

    end

    nUsed = min(frameIdx, nLast);

    if nUsed == 0
        error('No frames found in file: %s', dumpFile);
    end

    avgPdf    = sumPdf  ./ nUsed;
    meanSpeed = sumMean ./ nUsed;

end

function [sigmaHat, pdfFit, stats] = fit_maxwell_sigma(v, pdfObs)

    v = v(:);
    y = pdfObs(:);

    mask = isfinite(v) & isfinite(y) & v >= 0 & y >= 0;

    v = v(mask);
    y = y(mask);

    if numel(v) < 10
        error('Not enough points to fit Maxwell distribution.');
    end

    vMean = sum(v .* y) / sum(y);
    sigma0 = max(vMean / (2 * sqrt(2/pi)), eps);

    obj = @(s) y - maxwell_pdf(v, s);

    opts = optimoptions('lsqnonlin', 'Display', 'off');
    sigmaHat = lsqnonlin(@(s) obj(s), sigma0, 1e-12, Inf, opts);

    pdfFit = maxwell_pdf(v, sigmaHat);

    resid = y - pdfFit;
    SSE = sum(resid.^2);
    SST = sum((y - mean(y)).^2);
    R2 = 1 - SSE / max(SST, eps);

    stats.SSE = SSE;
    stats.R2  = R2;

    pdfFitFull = nan(size(pdfObs(:)));
    pdfFitFull(mask) = pdfFit;
    pdfFit = reshape(pdfFitFull, size(pdfObs));

end

function f = maxwell_pdf(v, sigma)

    v = v(:);
    sigma = max(sigma, eps);

    f = sqrt(2/pi) .* ...
        (v.^2 ./ sigma.^3) .* ...
        exp(-(v.^2) ./ (2*sigma.^2));

end