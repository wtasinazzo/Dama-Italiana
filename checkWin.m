function check = checkWin(scacchiera,set,turno)

% trovo quante sono pedine del tuo avversario
pedine_avv = 0;
for numero=1:set.righe
    for lettera_num=1:length(set.colonne)
        if scacchiera{lettera_num,numero}.Piena
            if scacchiera{lettera_num,numero}.Contenuto.Colore~=turno
            pedine_avv = pedine_avv+1; % n° pedine avv
            end
        end
    end
end

if pedine_avv>0
    check=false;
else
    check=true;
end