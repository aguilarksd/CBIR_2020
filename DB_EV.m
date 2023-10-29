DB={
    'Corel-1k'
    %'Corel-5k';
    %'CorelDB';
    %'Caltech-101';
    };
%DesN='EHD';lng=85;
%DesN='CLD';lng=192;
%DesN='CMTH';lng=283;
%DesN='MSD';lng=72;
%DesN='SED';lng=360;
N_Des={
        %'CMSD' 88 [72 6 10];
        %'PCMSD' 352 [288 24 40];
        'CMSED' {2 28 'CC' 'AND'} 172 [84 88];
        'CMSED' {2 30 'CC' 'AND'} 178 [90 88];
        'CMSED' {1 7 'CC' 'AND'} 109 [21 88];
        'CMSED' {1 9 'CC' 'AND'} 115 [27 88];
        'CMSED' {2 28 'DC' 'AND'} 172 [84 88];
        'CMSED' {2 30 'DC' 'AND'} 178 [90 88];
        'CMSED' {1 7 'DC' 'AND'} 109 [21 88];
        'CMSED' {1 9 'DC' 'AND'} 115 [27 88];
        %'PCMSED' 325 [27 298];
        %'PCMSED1' 325 [27 298];
        %'PCMSED2' 406 [108 298];
        %'PCMSEDp' [2] 325 [27 298];
        %'PCMSEDp' [3] 325 [27 298];
        %'PCMSEDp' [4] 325 [27 298];
        %'PCMSEDp' [1 2] 325 [27 298];
        %'PCMSEDp' [1 3] 325 [27 298];
        %'PCMSEDp' [1 4] 325 [27 298];
        %'PCMSD1' [2] 167 [135 12 20];
        %'PCMSD1' [3] 237 [189 18 30];
        %'PCMSD1' [5] 350 [270 30 50];
        %'PCMSD1' [6] 393 [297 36 60];
        %'PCMSD1' [7] 427 [315 42 70];
        %'PCMSD1' [8] 452 [324 48 80];
        %'PCMSED2' [2] 221 [54 167];
        %'PCMSED2' [3] 318 [54 237];
        %'PCMSED2' [5] 485 [135 350];
        %'PCMSED2' [6] 555 [162 393];
        %'PCMSED2' [7] 616 [189 427];
        %'PCMSED2' [8] 668 [216 452];
        %'PCMSD1' 298 [234 24 40];
        %'PCMSD2' 88 [72 6 10];
        %'MIFH' 102 [54 48];
        %'MIFH-1' 87 [54 33];
        %'MIFH-2' 102 [54 48];
        %'MIFH-3' 102 [54 48];
        %'MIFH-4' 90 [54 36];
        %'MIFH-2-1' 94 [54 40];
        %'MIFH-C' 102 [54 48];
        %'MIFH-1C' 87 [54 33];
        %'MIFH-2C' 102 [54 48];
        %'MIFH-2-1C' 94 [54 40]
        };
Met={
    'M'
    %'E'
    %'S'
    %'M2'
    %'M3'
    };
qi=1;%1 queri image list o 0 dont have

Do_Traning(DB,N_Des)
Do_Testing(DB,N_Des,Met,qi)

