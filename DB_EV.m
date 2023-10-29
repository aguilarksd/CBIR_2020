DB={
    'Corel-1k'
    'Corel-5k';
    'CorelDB';
    'Caltech-101';
    };
N_Des={
        'CMSD' 88 [72 6 10];
        'PCMSD' 352 [288 24 40];
        'PCMSD1' 298 [234 24 40];
        'PCMSD2' 88 [72 6 10];
        'MIFH' 102 [54 48];
        'MIFH-1' 87 [54 33];
        'MIFH-2' 102 [54 48];
        'MIFH-3' 102 [54 48];
        'MIFH-4' 90 [54 36];
        'MIFH-2-1' 94 [54 40];
        'MIFH-C' 102 [54 48];
        'MIFH-1C' 87 [54 33];
        'MIFH-2C' 102 [54 48];
        'MIFH-2-1C' 94 [54 40];
        'SED' 360 [];
        'MSD' 72 [];
	'CMTH' 283 [];
	'CLD' 192 [];
	'EHD' 85 []
        };
Met={
    'M'
    'E'
    'S'
    'M2'
    'M3'
    };
qi=1; % 1 if you queri image list exist or 0 don't exist

Do_Traning(DB,N_Des)
Do_Testing(DB,N_Des,Met,qi)

