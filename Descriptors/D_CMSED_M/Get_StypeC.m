function t = Get_StypeC(ce,cu,dm,lm,cm,ne)        

if ce == 1
    t=1;
    
elseif ce == 7
        t=2;
    
elseif ce == 2 && dm == 6
        t=3;
elseif ce == 2 && dm == 5
        t=4;
elseif ce == 2 && dm == 4
        t=5;
elseif ce == 2 && dm == 3
        t=6;
    
elseif ce == 6 && lm == 6
        t=7;
elseif ce == 6 && lm == 5
        t=8;
elseif ce == 6 && lm == 4
        t=9;
elseif ce == 6 && lm == 3
        t=10;
    
elseif ce == 3 && cu == 2
        t=11;
elseif ce == 3 && cu == 4 && dm == 4
        t=12;
elseif ce == 3 && cu == 4 && dm == 3
        t=13;
elseif ce == 3 && cu == 6 && dm == 3
        t=14;
elseif ce == 3 && dm == 2
        t=15;

elseif ce == 5 && cu == 2
        t=16;
elseif ce == 5 && cu == 4 && lm == 4
        t=17;
elseif ce == 5 && cu == 4 && lm == 3
        t=18;
elseif ce == 5 && cu == 6 && lm == 3
        t=19;
elseif ce == 5 && lm == 2
        t=20;

elseif ce == 4 && cu == 2
        t=21;
elseif ce == 4 && lm == 3 && dm == 3
        t=22;
elseif ce == 4 && lm == 3 && dm == 2
        t=23;
elseif ce == 4 && lm == 2 && dm == 3
        t=24;
elseif ce == 4 && cu == 6 && cm == 2
        t=25;
elseif ce == 4 && cu == 6 && cm == 0
        t=26;
elseif ce == 4 && cu == 4 && cm == 4
        t=27;
elseif ce == 4 && cu == 8
        t=28;
elseif ne == 30 && ce == 0
        t=29;
elseif ne == 30 && ce == 8
        t=30;
else
    t=0;
end

end