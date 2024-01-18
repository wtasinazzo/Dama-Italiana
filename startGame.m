function scacchiera = startGame(set)

scacchiera=cell(set.righe,set.righe);
%% Creare la scacchiera con valori
for riga= 1:set.righe
    for colonna=1:length(set.colonne)
        scacchiera{colonna,riga}= Casella(set.colonne(colonna)+num2str(riga), [set.grafica.x_centri(colonna),set.grafica.y_centri(riga)]);
    end
end

%% Riempire la scacchiera
scacchiera=riempiScacchiera(scacchiera);

showGame(scacchiera,set);

%% Turni
continua = true;
turnoNero = true;
while continua
    turnoNero = ~turnoNero; % primo turno lo imposta bianco poi cambia ad ogni turno
    if turnoNero
        turno = "B";
    else
        turno = "W";
    end

    disp("Turno "+turno);

    % Check se ci sono mosse obbligatorie
    check = checkObbligatorie(scacchiera,set,turno);

    if check
        [~,daMuovere,doveMuovere,mangiate] = checkObbligatorie(scacchiera,set,turno);
        scacchiera=siMangia(scacchiera,set,daMuovere,doveMuovere,mangiate,turno);
    else
        scacchiera=nonSiMangia(scacchiera,set,turno);
    end


    showGame(scacchiera,set);

    % Check se è finita la partita
    check = checkWin(scacchiera,set,turno);
    check_altraPartita = false;

    if check
        continua=false;
        disp([turno, 'HAI VINTO!'])
        check_altraPartita=input('Vuoi Giocare una partita? (rispondi "y" o "n") ... ');
    end

end

% Se vuole cominciare una nuova partita gliela faccio ricomincia
if check_altraPartita=="y"
    scacchiera = startGame(set);
end
