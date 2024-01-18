set.righe = 8;
set.colonne=["a","b","c","d","e","f","g","h"];
set.imm=imread("damiera.jpg");

set.grafica.angoloUpSx=[125,125]; % h1
set.grafica.angoloUpDx=[880,125]; % a1

startingPointX = set.grafica.angoloUpDx(1) - (set.grafica.angoloUpDx(1)-set.grafica.angoloUpSx(1))/(set.righe*2);
startingPointY = set.grafica.angoloUpDx(2) + (set.grafica.angoloUpDx(1)-set.grafica.angoloUpSx(1))/(set.righe*2);
set.grafica.x_centri=ones(1,set.righe);
set.grafica.y_centri=ones(1,set.righe);
for i=0:set.righe-1
    set.grafica.x_centri(i+1)= startingPointX - i* (set.grafica.angoloUpDx(1)-set.grafica.angoloUpSx(1))/(set.righe);
    set.grafica.y_centri(i+1)= startingPointY + i* (set.grafica.angoloUpDx(1)-set.grafica.angoloUpSx(1))/(set.righe);
end

save('impostazioni.mat','set')