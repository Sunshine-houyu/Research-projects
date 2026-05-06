clc; clear; close all;

    %% ========== 1) 内置200条地震数据 ==========
    % 格式: { '地点名', 地震等级, 发生时间, 设防烈度, 震源深度,
    %         最大破坏烈度, 当地人口密度, 余震次数, 房屋破坏数量, 预报水平, 受灾人口，转移人口 地震季节 }
    allData = {
     6.2, 2, 7, 6, 8, 53.06, 14, 8240, 3, 218500, 43700;
6.4, 2, 7, 5, 8, 56.8, 23, 284300, 1, 672000, 268800;
6.1, 1, 7, 10, 8, 154.7, 10, 232000, 2, 476000, 190400;
6.6, 1, 7, 12, 8, 4.8, 16, 12800, 2, 81600, 32640;
4.9, 2, 8, 8, 7, 222.72, 5, 45600, 1, 141120, 56448;
6.0, 2, 7, 10, 8, 83.19, 13, 72000, 3, 960000, 384000;
7.1, 1, 7, 14, 9, 8, 10.02, 20160, 2, 268800, 107520;
5.8, 1, 7, 10, 8, 75.44, 9, 168000, 1, 369600, 147840;
5.2, 2, 8, 10, 7, 109, 4, 17280, 2, 27360, 10944;
5.7, 1, 8, 11, 8, 59.5, 6, 5040, 3, 90720, 36288;
5.7, 1, 8, 14, 8, 53.07, 8, 504000, 1, 537600, 215040;
5.5, 1, 7, 9, 7, 112, 5, 89600, 2, 179200, 71680;
7.0, 1, 7, 13, 9, 102, 95, 1104300, 2, 1827000, 730800;
5.3, 1, 6, 6, 5, 53.76, 6, 10080, 3, 40320, 16128;
6.6, 1, 7, 20, 8, 117, 10, 85140, 2, 652860, 261144;
5.9, 1, 8, 10, 8, 15.8, 14, 16120, 1, 151840, 60736;
5.5, 1, 8, 8, 7, 105, 9, 25200, 2, 100800, 40320;
5.6, 2, 6, 10, 5, 0.44, 2, 1200, 2, 4000, 1600;
7.3, 1, 6, 12, 9, 6.39, 45, 94500, 1, 500220, 200088;
6.5, 1, 7, 12, 9, 108, 20, 850000, 1, 1200000, 480000;
6.6, 2, 7, 5, 8, 294, 8, 8000, 2, 150480, 60192;
6.3, 1, 9, 16, 8, 10.45, 5, 34820, 1, 179300, 71720;
5.8, 1, 7, 10, 7, 2.11, 3, 6980, 2, 9870, 3948;
6.5, 1, 7, 10, 8, 16, 25, 13760, 2, 248400, 99360;
6.7, 2, 8, 10, 8, 10, 35, 2480, 3, 4920, 1968;
7.0, 2, 8, 10, 9, 11.35, 30, 74350, 2, 198600, 79440;
6.0, 2, 6, 16, 8, 331, 18, 29780, 1, 201200, 80480;
6.4, 2, 8, 10, 8, 45.99, 14, 14930, 2, 79600, 31840;
7.4, 2, 8, 17, 10, 0.41, 40, 4980, 1, 39800, 15920;
6.9, 2, 7, 10, 9, 20.31, 15, 4470, 3, 17600, 7040;
6.1, 1, 7, 17, 8, 85.76, 2, 2980, 3, 17900, 7160;
6.8, 1, 8, 16, 9, 36.95, 20, 54720, 2, 129600, 51840;
6.2, 2, 7, 10, 8, 253, 15, 17840, 2, 899200, 359680;
7.1, 2, 8, 22, 9, 22.02, 68, 4470, 3, 59800, 23920;
6.8, 2, 7, 10, 9, 4.34, 28, 34560, 2, 69300, 27720;
5.6, 2, 7, 9, 8, 88.2, 7, 48300, 2, 124600, 24920;
6.8, 1, 7, 14, 9, 45, 28, 198400, 1, 312000, 62400;
5.4, 1, 7, 7, 7, 132, 6, 68900, 3, 89700, 17940;
6.0, 2, 7, 11, 8, 28, 10, 15200, 2, 42500, 8500;
5.9, 2, 7, 13, 8, 6.5, 9, 7840, 1, 18300, 3660;
6.3, 1, 8, 8, 9, 205, 12, 324000, 2, 548000, 109600;
5.1, 2, 6, 10, 6, 12.3, 3, 3210, 3, 7890, 1578;
5.7, 1, 7, 9, 8, 158, 8, 102500, 1, 228000, 45600;
5.5, 2, 6, 12, 7, 64, 5, 24600, 2, 58400, 11680;
6.5, 1, 7, 15, 9, 3.2, 18, 12300, 1, 29500, 5900;
5.6, 2, 8, 9, 8, 12, 7, 14300, 2, 34500, 6900;
5.4, 1, 6, 16, 6, 2.3, 4, 4320, 3, 8900, 1780;
5.7, 2, 7, 12, 7, 14, 8, 13200, 1, 29600, 5920;
6.1, 1, 7, 10, 8, 55, 11, 58300, 2, 132000, 26400;
6.4, 2, 8, 8, 9, 124, 17, 285000, 1, 610000, 122000;
5.5, 1, 7, 13, 7, 6.3, 6, 5840, 2, 10800, 2160;
5.6, 2, 7, 9, 8, 112, 9, 62100, 3, 148000, 29600;
6.3, 1, 6, 15, 8, 5.8, 13, 11200, 1, 25400, 5080;
5.8, 2, 6, 10, 7, 8.5, 7, 15600, 2, 34800, 6960;
5.2, 1, 7, 7, 6, 38, 4, 17300, 3, 39200, 7840;
5.9, 2, 8, 8, 8, 76, 10, 82400, 2, 189000, 37800;
5.0, 1, 6, 12, 6, 12, 3, 6750, 1, 14500, 2900;
6.5, 2, 7, 11, 9, 18, 19, 132000, 1, 295000, 59000;
5.7, 1, 7, 8, 7, 94, 8, 54200, 2, 127000, 25400;
5.4, 2, 6, 14, 7, 4.2, 5, 7890, 3, 15200, 3040;
5.3, 2, 8, 7, 7, 48, 4, 22100, 2, 51000, 10200;
6.1, 1, 6, 13, 8, 11, 12, 28400, 1, 63200, 12640;
5.8, 2, 7, 9, 8, 29, 8, 34500, 2, 78400, 15680;
5.6, 1, 7, 16, 7, 0.7, 6, 2950, 3, 5600, 1120;
5.5, 2, 7, 8, 7, 68, 7, 37800, 1, 89300, 17860;
6.0, 1, 6, 14, 8, 1.5, 10, 8420, 2, 18900, 3780;
6.2, 2, 8, 7, 9, 82, 14, 148000, 1, 328000, 65600;
5.2, 1, 6, 11, 6, 9.4, 3, 5670, 3, 12800, 2560;
5.9, 2, 7, 10, 8, 6.8, 9, 14300, 1, 32100, 6420;
5.7, 1, 7, 9, 7, 73, 8, 49500, 2, 112000, 22400;
5.4, 2, 7, 12, 7, 3.8, 5, 6320, 1, 14200, 2840;
6.3, 1, 7, 11, 9, 16, 16, 68400, 2, 152000, 30400;
5.8, 2, 7, 8, 8, 105, 10, 92100, 3, 210000, 42000;
5.5, 1, 7, 17, 7, 0.9, 4, 3150, 2, 6700, 1340;
6.0, 1, 8, 9, 8, 96, 12, 115000, 1, 258000, 51600;
5.3, 2, 6, 13, 6, 7.2, 4, 7890, 3, 17400, 3480;
5.7, 1, 7, 10, 7, 21, 8, 23500, 2, 52800, 10560;
5.9, 2, 7, 8, 8, 44, 9, 38700, 1, 88200, 17640;
6.1, 1, 6, 15, 8, 4.5, 11, 10800, 2, 24300, 4860;
6.5, 2, 8, 7, 9, 112, 18, 285000, 1, 635000, 127000;
5.2, 1, 6, 12, 6, 11, 4, 8450, 3, 18900, 3780
5.8, 2, 7, 9, 8, 78, 9, 67200, 2, 154000, 30800;
5.6, 1, 7, 10, 7, 37, 7, 29800, 1, 68400, 13680;
5.4, 2, 7, 14, 7, 5.6, 5, 6150, 2, 13800, 2760;
6.0, 1, 8, 8, 8, 89, 11, 102000, 2, 228000, 45600;
5.5, 2, 6, 11, 7, 14, 6, 12300, 3, 27600, 5520;
6.2, 1, 7, 10, 9, 12, 13, 54600, 1, 122000, 24400;
5.9, 2, 6, 16, 8, 2.8, 8, 9870, 2, 22100, 4420;
5.7, 1, 7, 9, 7, 26, 7, 21400, 2, 48300, 9660;
6.4, 2, 8, 7, 9, 18, 15, 138000, 1, 308000, 61600;
5.2, 1, 6, 11, 6, 9.4, 3, 5670, 3, 12800, 2560;
5.9, 2, 7, 10, 8, 6.8, 9, 14300, 1, 32100, 6420;
5.7, 1, 7, 9, 7, 73, 8, 49500, 2, 112000, 22400;
6.0, 2, 6, 14, 8, 3.5, 7, 9250, 1, 19800, 3960;
5.8, 1, 7, 10, 8, 88, 12, 76500, 2, 172000, 34400;
5.6, 2, 6, 12, 7, 8.7, 6, 13200, 3, 24500, 4900;
5.4, 1, 7, 9, 7, 54, 5, 28700, 2, 62300, 12460;
5.7, 2, 7, 15, 8, 4.1, 8, 11200, 1, 23400, 4680;
5.3, 1, 6, 8, 6, 19, 4, 8450, 2, 17800, 3560;
6.1, 2, 8, 9, 8, 76, 11, 89200, 1, 195000, 39000;
6.7, 2, 7, 12, 8, 287.41, 18, 14782, 2, 122300, 54300;
5.2, 1, 8, 8, 9, 45.67, 9, 6850, 3, 87450, 31200;
7.1, 2, 6, 18, 9, 3.15, 42, 18975, 1, 234500, 98700;
5.8, 1, 7, 10, 8, 75.44, 6, 136122, 2, 282500, 127100;
6.3, 2, 7, 15, 9, 102.33, 21, 30505, 1, 166407, 16459;
6.6, 1, 7, 20, 8, 117.00, 7, 78243, 2, 603100, 280000;
5.9, 2, 8, 10, 8, 15.80, 16, 14955, 1, 122705, 28970;
5.5, 1, 8, 8, 7, 105.00, 10, 23235, 2, 93638, 35015;
5.6, 2, 6, 10, 5, 0.44, 1, 985, 2, 3189, 1161;
7.3, 1, 6, 12, 9, 6.39, 31, 83040, 1, 455573, 54648;
6.5, 1, 7, 12, 9, 108.00, 12, 80900, 1, 1088400, 229700;
6.6, 2, 7, 5, 8, 294.00, 7, 6988, 2, 124600, 56880;
6.3, 1, 9, 16, 8, 10.45, 1, 30505, 1, 166407, 16459;
5.8, 1, 7, 10, 7, 2.11, 2, 6132, 2, 8798, 2570;
6.5, 1, 7, 10, 8, 16.00, 48, 12000, 2, 225790, 81600;
6.7, 2, 8, 10, 8, 10.00, 43, 2100, 3, 4589, 980;
7.0, 2, 8, 10, 9, 11.35, 30, 73671, 2, 176492, 61500;
6.0, 2, 6, 16, 8, 331.00, 11, 28054, 1, 168000, 15897;
6.4, 2, 8, 10, 8, 45.99, 13, 14122, 2, 72317, 25942;
7.4, 2, 8, 17, 10, 0.41, 36, 4675, 1, 35431, 23000;
6.9, 2, 7, 10, 9, 20.31, 12, 4052, 3, 14988, 6895;
6.1, 1, 7, 17, 8, 85.76, 1, 2766, 3, 14427, 13028;
6.8, 1, 8, 16, 9, 36.95, 16, 52108, 2, 114536, 60000;
6.2, 2, 7, 10, 8, 253.00, 11, 15181, 2, 772000, 112346;
7.1, 2, 8, 22, 9, 22.02, 76, 3877, 3, 64578, 12426;
6.8, 2, 7, 10, 9, 4.34, 33, 30860, 2, 61500, 46525;
6.5, 1, 7, 12, 9, 108.00, 12, 80900, 1, 1088400, 229700;
6.6, 2, 7, 5, 8, 294.00, 7, 6988, 2, 124600, 56880;
6.3, 1, 9, 16, 8, 10.45, 1, 30505, 1, 166407, 16459;
5.8, 1, 7, 10, 7, 2.11, 2, 6132, 2, 8798, 2570;
6.5, 1, 7, 10, 8, 16.00, 48, 12000, 2, 225790, 81600;
6.7, 2, 8, 10, 8, 10.00, 43, 2100, 3, 4589, 980;
7.0, 2, 8, 10, 9, 11.35, 30, 73671, 2, 176492, 61500;
6.0, 2, 6, 16, 8, 331.00, 11, 28054, 1, 168000, 15897;
6.4, 2, 8, 10, 8, 45.99, 13, 14122, 2, 72317, 25942;
7.4, 2, 8, 17, 10, 0.41, 36, 4675, 1, 35431, 23000;
6.9, 2, 7, 10, 9, 20.31, 12, 4052, 3, 14988, 6895;
6.1, 1, 7, 17, 8, 85.76, 1, 2766, 3, 14427, 13028;
6.8, 1, 8, 16, 9, 36.95, 16, 52108, 2, 114536, 60000;
6.2, 2, 7, 10, 8, 253.00, 11, 15181, 2, 772000, 112346;
7.1, 2, 8, 22, 9, 22.02, 76, 3877, 3, 64578, 12426;
6.8, 2, 7, 10, 9, 4.34, 33, 30860, 2, 61500, 46525;
6.5, 1, 7, 12, 9, 108.00, 12, 80900, 1, 1088400, 229700;
6.6, 2, 7, 5, 8, 294.00, 7, 6988, 2, 124600, 56880;
6.3, 1, 9, 16, 8, 10.45, 1, 30505, 1, 166407, 16459;
5.8, 1, 7, 10, 7, 2.11, 2, 6132, 2, 8798, 2570;
6.5, 1, 7, 10, 8, 16.00, 48, 12000, 2, 225790, 81600;
6.7, 2, 8, 10, 8, 10.00, 43, 2100, 3, 4589, 980;
7.0, 2, 8, 10, 9, 11.35, 30, 73671, 2, 176492, 61500;
6.0, 2, 6, 16, 8, 331.00, 11, 28054, 1, 168000, 15897;
5.9, 1, 7, 9, 8, 68.50, 8, 12450, 2, 185300, 75200;
6.4, 2, 8, 11, 9, 28.90, 14, 23980, 1, 234560, 89000;
5.5, 1, 6, 7, 7, 95.20, 5, 8450, 3, 67400, 24500;
6.1, 2, 7, 14, 8, 12.30, 9, 15670, 2, 98700, 43200;
6.8, 1, 8, 13, 9, 45.80, 22, 35600, 1, 456200, 167000;
5.7, 2, 7, 10, 8, 78.60, 7, 13200, 2, 210500, 91000;
6.2, 1, 6, 8, 7, 3.80, 3, 2450, 3, 15800, 5200;
7.0, 2, 7, 16, 9, 8.90, 28, 18900, 2, 345600, 123400;
6.5, 1, 8, 12, 9, 15.40, 17, 27600, 1, 287000, 105000;
5.8, 2, 7, 9, 8, 102.70, 6, 11500, 2, 198400, 87400;
6.3, 1, 7, 11, 8, 54.30, 10, 16780, 3, 123500, 45600;
6.7, 2, 8, 15, 9, 23.10, 19, 29800, 1, 389000, 145000;
5.6, 1, 6, 6, 6, 0.95, 2, 890, 2, 4320, 1500;
6.9, 2, 7, 17, 9, 7.20, 25, 21000, 3, 267800, 98700;
5.4, 1, 7, 8, 7, 88.50, 4, 7650, 2, 65400, 23400;
6.0, 2, 8, 10, 8, 33.80, 8, 14300, 1, 178900, 65400;
6.5, 1, 7, 12, 8, 19.60, 12, 19800, 2, 234500, 87600;
5.9, 2, 6, 9, 7, 1.50, 1, 670, 3, 3200, 1200;
6.1, 1, 7, 14, 8, 10.80, 7, 12340, 2, 98700, 34500;
6.4, 2, 8, 11, 9, 27.40, 15, 22700, 1, 245600, 89000;
5.7, 1, 7, 10, 8, 76.20, 6, 12800, 2, 205400, 90500;
6.2, 2, 6, 8, 7, 4.20, 3, 2350, 3, 16200, 5300;
7.0, 1, 7, 16, 9, 9.50, 27, 19200, 2, 352000, 124500;
6.5, 2, 8, 12, 9, 16.30, 18, 28100, 1, 293000, 106000;
5.8, 1, 7, 9, 8, 104.80, 5, 11800, 2, 201500, 88200;
6.3, 2, 7, 11, 8, 56.70, 11, 17200, 3, 127800, 46200;
6.7, 1, 8, 15, 9, 24.60, 20, 30500, 1, 396000, 148000;
5.6, 2, 6, 6, 6, 1.20, 3, 920, 2, 4450, 1600;
6.9, 1, 7, 17, 9, 8.10, 26, 21500, 3, 275300, 99500;
5.4, 2, 7, 8, 7, 90.30, 5, 7800, 2, 66800, 24100;
6.0, 1, 8, 10, 8, 35.20, 9, 14700, 1, 183500, 66700;
6.5, 2, 7, 12, 8, 20.80, 13, 20300, 2, 239000, 89100;
5.9, 1, 6, 9, 7, 1.80, 2, 710, 3, 3350, 1250;
6.1, 2, 7, 14, 8, 11.20, 8, 12700, 2, 99500, 35200;
6.4, 1, 8, 11, 9, 28.90, 16, 23300, 1, 251000, 90500;
5.7, 2, 7, 10, 8, 78.90, 7, 13100, 2, 208400, 91200;
6.2, 1, 6, 8, 7, 4.50, 4, 2400, 3, 16500, 5400;
7.0, 2, 7, 16, 9, 10.20, 28, 19500, 2, 358000, 126000;
6.5, 1, 8, 12, 9, 17.60, 19, 28700, 1, 297000, 108000;
5.8, 2, 7, 9, 8, 106.50, 6, 12100, 2, 204500, 89000;
6.3, 1, 7, 11, 8, 58.30, 12, 17600, 3, 129800, 46800;
6.7, 2, 8, 15, 9, 25.90, 21, 31200, 1, 401000, 150000;
5.6, 1, 6, 6, 6, 1.50, 4, 950, 2, 4600, 1650;
6.9, 2, 7, 17, 9, 8.70, 27, 21800, 3, 278000, 100200;
5.4, 1, 7, 8, 7, 92.10, 6, 7950, 2, 67500, 24600;
6.0, 2, 8, 10, 8, 36.50, 10, 15100, 1, 187000, 67200;
6.5, 1, 7, 12, 8, 21.40, 14, 20800, 2, 243500, 89600;
5.9, 2, 6, 9, 7, 2.00, 3, 750, 3, 3450, 1300;
6.1, 1, 7, 14, 8, 11.80, 9, 12900, 2, 100200, 35800;
5.2, 1, 7, 12, 7, 21.33, 11, 23214, 2, 67433, 24500;
    };

    numSamples = size(allData,1);

    %% ========== 2) 输入输出调整 ==========
    % 输入: 第2~11列（新增受灾人口作为输入特征）
    X_raw = cell2mat(allData(:, 1:10));  % [35 x 10]
    Y_raw = cell2mat(allData(:, 11));    % [35 x 1] 转移安置人口

   %% ========== 3) 数据归一化 ==========
    [X_normAll, psX] = mapminmax(X_raw', 0, 1);
    X_normAll = X_normAll';
    [Y_normAll, psY] = mapminmax(Y_raw', 0, 1);
    Y_normAll = Y_normAll';

   %% ========== 4) 5折交叉验证 ==========
    K = 5;
    indices = crossvalind('Kfold', numSamples, K);
    hiddenSize = [11];  % 隐藏层结构（可调整）
    maxIter = 150;         % 优化算法参数
    popSize = 50;

    maeCIWOA_vec = zeros(K,1);  rmseCIWOA_vec= zeros(K,1);  mapeCIWOA_vec= zeros(K,1);
    maeGWO_vec   = zeros(K,1);  rmseGWO_vec  = zeros(K,1);  mapeGWO_vec  = zeros(K,1);
    maeBP_vec    = zeros(K,1);  rmseBP_vec   = zeros(K,1);  mapeBP_vec   = zeros(K,1);

    disp(['数据总条数=', num2str(numSamples),', 开始 ',num2str(K),'折交叉验证...']);
    for fold_i = 1:K
        testMask  = (indices == fold_i);
        trainMask = ~testMask;
        X_train = X_normAll(trainMask,:);
        Y_train = Y_normAll(trainMask,:);
        X_test  = X_normAll(testMask,:);
        Y_test  = Y_normAll(testMask,:);

       [netCIWOA, ~] = CIWOA_BP_Train( ...
            X_train, Y_train, 10, hiddenSize, 1, maxIter, popSize); % 输入层10
        [netGWO, ~] = GWO_BP_Train( ...
            X_train, Y_train, 10, hiddenSize, 1, maxIter, popSize);
        netBP = feedforwardnet(hiddenSize, 'trainlm');
        netBP = configure(netBP, X_train', Y_train');
        netBP.trainParam.epochs = 200;
        netBP.trainParam.goal = 1e-5;
        netBP = train(netBP, X_train', Y_train');
  %% 预测与误差计算
        predCIWOA_norm = netCIWOA(X_test');
        predGWO_norm   = netGWO(X_test');
        predBP_norm    = netBP(X_test');

        predCIWOA    = mapminmax('reverse', predCIWOA_norm, psY);
        predGWO      = mapminmax('reverse', predGWO_norm, psY);
        predBP       = mapminmax('reverse', predBP_norm, psY);
        Y_test_real  = mapminmax('reverse', Y_test', psY);

        % 误差指标
        epsilon = 1e-6;  % -- 修改点3: 防止MAPE除零错误 --
        maeCIWOA_vec(fold_i) = mean(abs(predCIWOA - Y_test_real));
        rmseCIWOA_vec(fold_i)= sqrt(mean((predCIWOA - Y_test_real).^2));
        mapeCIWOA_vec(fold_i)= mean(abs((predCIWOA - Y_test_real)./Y_test_real))*100;

        maeGWO_vec(fold_i)   = mean(abs(predGWO - Y_test_real));
        rmseGWO_vec(fold_i)  = sqrt(mean((predGWO - Y_test_real).^2));
        mapeGWO_vec(fold_i)  = mean(abs((predGWO - Y_test_real)./Y_test_real))*100;

        maeBP_vec(fold_i)    = mean(abs(predBP - Y_test_real));
        rmseBP_vec(fold_i)   = sqrt(mean((predBP - Y_test_real).^2));
        mapeBP_vec(fold_i)   = mean(abs((predBP - Y_test_real)./Y_test_real))*100;

        disp([' Fold=', num2str(fold_i), ...
              ': CIWOA-MAE=', num2str(maeCIWOA_vec(fold_i)), ...
              ', GWO-MAE=',   num2str(maeGWO_vec(fold_i)), ...
              ', BP-MAE=',    num2str(maeBP_vec(fold_i))]);
    end
     [netCIWOA_final, ~] = CIWOA_BP_Train(X_normAll, Y_normAll, 10, hiddenSize, 1, maxIter, popSize);
    [netGWO_final, ~]   = GWO_BP_Train(X_normAll, Y_normAll, 10, hiddenSize, 1, maxIter, popSize);
    netBP_final = feedforwardnet(hiddenSize, 'trainlm');
    netBP_final = configure(netBP_final, X_normAll', Y_normAll');
    netBP_final = train(netBP_final, X_normAll', Y_normAll');

    %% 物资需求模型（直接使用输入中的受灾人口，X_raw第10列）
   S_pred_all = zeros(numSamples,1);
for i = 1:numSamples
    x_i = X_raw(i,:);
    x_norm = mapminmax('apply', x_i', psX);
    y_pred_norm = netCIWOA_final(x_norm);
    S_pred_all(i) = mapminmax('reverse', y_pred_norm, psY);
end  % 直接从输入获取受灾人口
    % ...（物资计算公式保持不变，但确保引用S_pred_all）


    % （可选）查看最终的网络结构示意图（以CIWOA-BP为例）
    figure;
    plotNetworkArchitecture(9, hiddenSize, 1);
    title('CIWOA-BP Final Network Architecture (示意图)');

    % 4.2 算例分析: 例如指定第3行(四川汶川)
    caseIdx = 35;  % 可自行修改
    sampleCase = X_raw(caseIdx,:);  % [1x9]
    realValCase= Y_raw(caseIdx);
    sampleCase_norm = mapminmax('apply', sampleCase', psX);

    predC_norm = netCIWOA_final(sampleCase_norm);
    predG_norm = netGWO_final(sampleCase_norm);
    predB_norm = netBP_final(sampleCase_norm);

    predC = mapminmax('reverse', predC_norm, psY);
    predG = mapminmax('reverse', predG_norm, psY);
    predB = mapminmax('reverse', predB_norm, psY);

    disp(['=== 算例(第', num2str(caseIdx),'行) ===']);
    disp(['地点=', allData{caseIdx,1}, ...
          ', 实际转移人口=', num2str(realValCase), ...
          ', CIWOA预测=', num2str(predC), ...
          ', GWO预测=', num2str(predG), ...
          ', BP预测=',   num2str(predB)]);

    % 4.3 新的物资需求模型(基于CIWOA最终预测为例)
    %    假设有 4 类物资: 食物, 水, 医疗, 帐篷
    S_pred_all = zeros(numSamples,1);
    for i = 1:numSamples
        x_i = X_raw(i,:);
        x_norm = mapminmax('apply', x_i', psX);
        y_pred_norm = netCIWOA_final(x_norm);
        S_pred_all(i) = mapminmax('reverse', y_pred_norm, psY);  % 预测受灾人口
    end

    % 下面是一些假设系数(可自行调整)
    seasonData = X_raw(:,2);  % 第13列为发生季节（1=春,2=夏,3=秋,4=冬）
    alpha_food    = [5,  0.8,  0.1];
    alpha_water   = [10, 0.5,  0.2];
    alpha_medical = [2,  0.5,  0.05];
    alpha_tent    = [0.1,0.08, 0.02];
    beta_food    = 0.001;
    beta_water   = 0.0005;
    beta_medical = 0.0003;
    beta_tent    = 0.005;
    gamma_season_food    = [1.0, 1.0, 1.0, 1.2];
    gamma_season_water   = [1.1, 1.3, 1.2, 1.1];
    gamma_season_medical = [1.2, 1.1, 1.1, 1.3];
    gamma_season_tent    = [1.2, 1.0, 1.1, 1.3];

    demands_food    = zeros(numSamples,1);
    demands_water   = zeros(numSamples,1);
    demands_medical = zeros(numSamples,1);
    demands_tent    = zeros(numSamples,1);

    for i = 1:numSamples
        S   = S_pred_all(i);  % 预测的受灾人口
        Imax= X_raw(i,5);     % 最大破坏烈度
        Is  = X_raw(i,3);     % 设防烈度(或地震等级等)
        diffVal = max(0, Imax - Is);  % 烈度差
        N_af= X_raw(i,7);     % 当地人口密度(或其他)
        Hf  = X_raw(i,8);     % 房屋破坏数量
        season = seasonData(i);  % 使用修正后的季节参数 地震季节(1~4)
         % 季节因子索引（确保值在1-4之间）
    season_idx = max(1, min(4, round(season)));

        % 食物
        demands_food(i) = ( alpha_food(1)*S + alpha_food(2)*N_af + alpha_food(3)*diffVal ...
                            + beta_food*Hf ) ...
                          * gamma_season_food(season_idx);
        % 饮水
        demands_water(i)= ( alpha_water(1)*S + alpha_water(2)*N_af + alpha_water(3)*diffVal ...
                            + beta_water*Hf ) ...
                          * gamma_season_water(season_idx);
        % 医疗
        demands_medical(i)= ( alpha_medical(1)*S + alpha_medical(2)*N_af + alpha_medical(3)*diffVal ...
                              + beta_medical*Hf ) ...
                            * gamma_season_medical(season_idx);
        % 帐篷
        demands_tent(i)  = ( alpha_tent(1)*S + alpha_tent(2)*N_af + alpha_tent(3)*diffVal ...
                             + beta_tent*Hf ) ...
                           * gamma_season_tent(season_idx);
    end

    disp('=== 前5条地震的物资需求预测(基于CIWOA-BP) ===');
    for i=1:min(5,numSamples)
        disp(['第', num2str(i),'条(地点=', allData{i,1},'): ', ...
              '食物(kg)=', num2str(demands_food(i)), ...
              ', 水(L)=', num2str(demands_water(i)), ...
              ', 医疗(件)=', num2str(demands_medical(i)), ...
              ', 帐篷(顶)=', num2str(demands_tent(i))]);
    end
    

    %% ========== 5) 额外绘图(误差对比 & 预测对比) ==========

    % 5.1 平均误差柱状图(MAE,RMSE,MAPE)
    figure;
    bar([mean(maeCIWOA_vec), mean(maeGWO_vec), mean(maeBP_vec)]);
    set(gca, 'XTickLabel', {'CIWOA-BP','GWO-BP','BP'});
    ylabel('MAE');
    title('MAE Comparison (Average over 5 folds)');

    figure;
    bar([mean(rmseCIWOA_vec), mean(rmseGWO_vec), mean(rmseBP_vec)]);
    set(gca, 'XTickLabel', {'CIWOA-BP','GWO-BP','BP'});
    ylabel('RMSE');
    title('RMSE Comparison (Average over 5 folds)');

    figure;
    bar([mean(mapeCIWOA_vec), mean(mapeGWO_vec), mean(mapeBP_vec)]);
    set(gca, 'XTickLabel', {'CIWOA-BP','GWO-BP','BP'});
    ylabel('MAPE (%)');
    title('MAPE Comparison (Average over 5 folds)');

    % 5.2 每折误差分布(分组柱状图)
    figure;
    MAE_matrix = [maeCIWOA_vec, maeGWO_vec, maeBP_vec];
    bar(MAE_matrix);
    legend('CIWOA-BP','GWO-BP','BP','Location','Best');
    xlabel('Fold index'); ylabel('MAE');
    title('MAE by fold');

    figure;
    RMSE_matrix = [rmseCIWOA_vec, rmseGWO_vec, rmseBP_vec];
    bar(RMSE_matrix);
    legend('CIWOA-BP','GWO-BP','BP','Location','Best');
    xlabel('Fold index'); ylabel('RMSE');
    title('RMSE by fold');

    figure;
    MAPE_matrix = [mapeCIWOA_vec, mapeGWO_vec, mapeBP_vec];
    bar(MAPE_matrix);
    legend('CIWOA-BP','GWO-BP','BP','Location','Best');
    xlabel('Fold index'); ylabel('MAPE(%)');
    title('MAPE by fold');

    % 5.3 最终模型对所有数据的预测对比(折线+散点)
    allPred_C = zeros(numSamples,1);
    allPred_G = zeros(numSamples,1);
    allPred_B = zeros(numSamples,1);
    for i=1:numSamples
        x_i = X_raw(i,:);
        x_norm = mapminmax('apply', x_i', psX);
        pc_norm = netCIWOA_final(x_norm);
        pg_norm = netGWO_final(x_norm);
        pb_norm = netBP_final(x_norm);

        allPred_C(i) = mapminmax('reverse', pc_norm, psY);
        allPred_G(i) = mapminmax('reverse', pg_norm, psY);
        allPred_B(i) = mapminmax('reverse', pb_norm, psY);
    end

    figure;
    plot(1:numSamples, Y_raw, 'k-o','LineWidth',1.5); hold on;
    plot(1:numSamples, allPred_C, 'r-*','LineWidth',1.5);
    plot(1:numSamples, allPred_G, 'g-d','LineWidth',1.5);
    plot(1:numSamples, allPred_B, 'b-x','LineWidth',1.5);
    legend('Actual','CIWOA-BP','GWO-BP','BP','Location','Best');
    xlabel('Sample index'); ylabel('Affected People');
    title('Final Model Prediction vs. Actual (Line Plot)');

    disp('程序运行结束。');

%% ========== 子函数1: CIWOA-BP 训练(手动构造多层network) ==========
function [netTrained, bestFit] = CIWOA_BP_Train( ...
    X, Y, inSize, hidSize, outSize, maxIter, popSize)

    lb = -1;  
    ub =  1;  
    dim = calcNetDim(inSize, hidSize, outSize);

    % 初始化种群
    whalePop = lb + (ub-lb).*rand(popSize, dim);
    fitnessVal = zeros(popSize,1);
    for i = 1:popSize
        fitnessVal(i) = CalcBPError(whalePop(i,:), X, Y, inSize, hidSize, outSize);
    end
    [bestFit, bestIdx] = min(fitnessVal);
    bestPos = whalePop(bestIdx,:);

    for t = 1:maxIter
        a = 2 - 2*(t/maxIter);
        for i = 1:popSize
            r1 = rand(); r2 = rand();
            A = 2*a*r1 - a;
            C = 2*r2;
            p = rand();
            b = 1;
            l = -1 + 2*rand();

            D_leader = abs(C*bestPos - whalePop(i,:));
            if p < 0.5
                if abs(A) < 1
                    % 包围猎物
                    newPos = bestPos - A.*D_leader;
                else
                    % 搜索猎物
                    rand_idx = randi([1, popSize]);
                    X_rand = whalePop(rand_idx,:);
                    D_rand = abs(C*X_rand - whalePop(i,:));
                    newPos = X_rand - A.*D_rand;
                end
            else
                % 蜿蜒机制
                distance2leader = abs(bestPos - whalePop(i,:));
                newPos = distance2leader*exp(b*l).*cos(l*2*pi) + bestPos;
            end

            % 边界处理
            newPos = max(newPos, lb);
            newPos = min(newPos, ub);

            newFit = CalcBPError(newPos, X, Y, inSize, hidSize, outSize);
            if newFit < fitnessVal(i)
                whalePop(i,:) = newPos;
                fitnessVal(i) = newFit;
            end
            if fitnessVal(i) < bestFit
                bestFit = fitnessVal(i);
                bestPos = whalePop(i,:);
            end
        end
    end

    netTrained = BuildCustomNetwork(bestPos, inSize, hidSize, outSize);
end

%% ========== 子函数2: GWO-BP 训练(手动构造多层network) ==========
function [netTrained, bestFit] = GWO_BP_Train( ...
    X, Y, inSize, hidSize, outSize, maxIter, popSize)

    lb = -1;  
    ub =  1;  
    dim = calcNetDim(inSize, hidSize, outSize);

    % 初始化狼群
    wolfPop = lb + (ub-lb).*rand(popSize, dim);
    fitVal  = zeros(popSize,1);
    for i = 1:popSize
        fitVal(i) = CalcBPError(wolfPop(i,:), X, Y, inSize, hidSize, outSize);
    end

    % 排序，确定 Alpha / Beta / Delta
    [valSorted, idxSort] = sort(fitVal);
    alphaPos = wolfPop(idxSort(1),:); alphaFit = valSorted(1);
    betaPos  = wolfPop(idxSort(2),:);
    deltaPos = wolfPop(idxSort(3),:);

    for t = 1:maxIter
        a = 2 - 2*(t/maxIter);
        for i = 1:popSize
            % 向 Alpha 靠近
            r1 = rand(); r2 = rand();
            A1 = 2*a*r1 - a;
            D_alpha = abs(r2*alphaPos - wolfPop(i,:));
            X1 = alphaPos - A1.*D_alpha;

            % 向 Beta 靠近
            r1 = rand(); r2 = rand();
            A2 = 2*a*r1 - a;
            D_beta = abs(r2*betaPos - wolfPop(i,:));
            X2 = betaPos - A2.*D_beta;

            % 向 Delta 靠近
            r1 = rand(); r2 = rand();
            A3 = 2*a*r1 - a;
            D_delta = abs(r2*deltaPos - wolfPop(i,:));
            X3 = deltaPos - A3.*D_delta;

            newPos = (X1 + X2 + X3)/3;
            % 边界处理
            newPos = max(newPos, lb);
            newPos = min(newPos, ub);

            newFit = CalcBPError(newPos, X, Y, inSize, hidSize, outSize);
            if newFit < fitVal(i)
                wolfPop(i,:) = newPos;
                fitVal(i) = newFit;
            end
        end

        % 更新 Alpha / Beta / Delta
        [valSorted2, idxS2] = sort(fitVal);
        alphaPos = wolfPop(idxS2(1),:); alphaFit = valSorted2(1);
        betaPos  = wolfPop(idxS2(2),:);
        deltaPos = wolfPop(idxS2(3),:);
    end

    bestFit = alphaFit;
    netTrained = BuildCustomNetwork(alphaPos, inSize, hidSize, outSize);
end

%% ========== 子函数3: 计算网络误差(MSE) ==========
function mseVal = CalcBPError(position, X, Y, inSize, hidSize, outSize)
    netTmp = BuildCustomNetwork(position, inSize, hidSize, outSize);
    Y_pred = netTmp(X');
    mseVal = mean((Y_pred' - Y).^2);
end

%% ========== 子函数4: 手动构造多层 network(权重+偏置写入net) ==========
function net = BuildCustomNetwork(position, inSize, hidSize, outSize)
    % 1) 新建空网络
    net = network;
    net.numInputs  = 1;  
    net.numLayers  = length(hidSize) + 1;  
    net.biasConnect = ones(net.numLayers,1);
    net.inputConnect(1,1) = true;
    for L = 2:net.numLayers
        net.layerConnect(L,L-1) = true;
    end
    net.outputConnect(net.numLayers) = true;

    % 设置每层大小, 激活函数
    net.inputs{1}.size = inSize;
    for L = 1:length(hidSize)
        net.layers{L}.size = hidSize(L);
        net.layers{L}.transferFcn = 'tansig'; % 可改 'logsig' 等
    end
    net.layers{end}.size = outSize;
    net.layers{end}.transferFcn = 'purelin';
    net.trainFcn = 'trainlm'; 

    % 2) 解析 position -> W,b
    dimNeeded = calcNetDim(inSize, hidSize, outSize);
    if length(position) ~= dimNeeded
        error('Position长度与网络结构不匹配！');
    end
    idxPos = 1;
    prevSize = inSize;
    nHid = length(hidSize);

    % 若有多层隐藏层
    for L=1:nHid
        wCount = hidSize(L)*prevSize;
        wTemp  = reshape(position(idxPos:idxPos+wCount-1), [hidSize(L), prevSize]);
        idxPos = idxPos + wCount;
        bCount = hidSize(L);
        bTemp  = reshape(position(idxPos:idxPos+bCount-1), [bCount,1]);
        idxPos = idxPos + bCount;

        if L==1
            net.IW{1,1} = wTemp;
        else
            net.LW{L, L-1} = wTemp;
        end
        net.b{L} = bTemp;
        prevSize = hidSize(L);
    end

    % 输出层
    wCountOut = outSize*prevSize;
    wOut = reshape(position(idxPos:idxPos+wCountOut-1), [outSize, prevSize]);
    idxPos = idxPos + wCountOut;
    bOut = reshape(position(idxPos:idxPos+outSize-1), [outSize,1]);
    idxPos = idxPos + outSize;

    net.LW{nHid+1, nHid} = wOut;
    net.b{nHid+1} = bOut;
end

%% ========== 子函数5: 计算多层网络参数总数 ==========
function d = calcNetDim(inSize, hidSize, outSize)
    d = 0;
    prev = inSize;
    for L = 1:length(hidSize)
        d = d + hidSize(L)*prev; % W
        d = d + hidSize(L);      % b
        prev = hidSize(L);
    end
    d = d + outSize*prev; 
    d = d + outSize;
end

%% ========== 子函数6: 简单绘制网络结构示意图 ==========
function plotNetworkArchitecture(inSize, hidSize, outSize)
    % 仅用于示意：输入层、若干隐藏层、输出层的节点分布
    % 圆形表示神经元，直线表示连线。可以根据需要美化。

    layerCount = length(hidSize) + 2;  % Input + hidden(s) + Output
    maxNeurons = max([inSize, hidSize, outSize]);

    % 为布局做准备
    xGap = 2;  % 相邻层的水平距离
    yGap = 1;  % 节点间垂直距离
    figureLayerWidth = (layerCount-1)*xGap;
    figureLayerHeight = (maxNeurons-1)*yGap;
    hold on;

    % 坐标 x 从 0开始
    xPositions = 0:xGap:(layerCount-1)*xGap;

    % 定义各层神经元个数
    neuronCounts = [inSize, hidSize, outSize];

    % 为存储每个神经元的(x,y)
    neuronPositions = cell(layerCount,1);

    for L = 1:layerCount
        if L == 1
            nCount = inSize;
        elseif L == layerCount
            nCount = outSize;
        else
            nCount = hidSize(L-1);
        end
        % 让当前层居中排布
        yStart = -(nCount-1)*yGap/2; 
        for iNeuron = 1:nCount
            xPos = xPositions(L);
            yPos = yStart + (iNeuron-1)*yGap;
            neuronPositions{L}(iNeuron,:) = [xPos, yPos];
            % 画神经元（圆）
            plot(xPos, yPos, 'o', 'MarkerSize', 12, 'MarkerFaceColor','w','Color','k');
        end
    end

    % 画层间连线
    for L = 1:(layerCount-1)
        A = neuronPositions{L};
        B = neuronPositions{L+1};
        for iA = 1:size(A,1)
            for iB = 1:size(B,1)
                plot([A(iA,1), B(iB,1)], [A(iA,2), B(iB,2)], 'k-');
            end
        end
    end

    % 额外标注文字(可根据需要添加)
    text(neuronPositions{1}(1,1), neuronPositions{1}(1,2)+1.2, 'Input Layer','FontWeight','bold');
    text(neuronPositions{layerCount}(1,1), neuronPositions{layerCount}(1,2)+1.2, 'Output Layer','FontWeight','bold');
    for L = 2:(layerCount-1)
        text(neuronPositions{L}(1,1), neuronPositions{L}(1,2)+1.2, ...
             ['Hidden Layer ',num2str(L-1)],'FontWeight','bold');
    end

    axis equal;
    axis off;
    hold off;
end