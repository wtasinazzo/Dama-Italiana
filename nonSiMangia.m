function scacchiera=nonSiMangia(scacchiera,set,turno)


% trovo quali sono pedine del turno
tuePedine = [];
for riga=1:set.righe
    for colonna=1:length(set.colonne)
        if scacchiera{colonna,riga}.Piena
            if scacchiera{colonna,riga}.Contenuto.Colore==turno
            tuePedine = [tuePedine, scacchiera{colonna,riga}.Name]; % caselle dove c'è tua pedina
            end
        end
    end
end

% faccio scegliere quale muovere
sceltaSbagliata = true;
while sceltaSbagliata
    X = input('Che pedina muovi? Indica la posizione tra virgolette doppie (es. "a1")... '); % quale muovere


    if sum(contains(tuePedine,X))==0
        disp("Non puoi muovere qualcosa in quella posizione")
        continue
    end

    % Controllo se ha caselle di atterragio disponibili
    diviso=char(X);
    lettera=diviso(1);
    numero=str2double(diviso(2));
    raggiungibili = raggiunge(scacchiera{set.colonne==lettera,numero},set);
    
   if turno=="W" && scacchiera{set.colonne==lettera,numero}.Contenuto.Dama==false
        raggiungibili = raggiungibili(3:4);
    elseif turno=="B" && scacchiera{set.colonne==lettera,numero}.Contenuto.Dama==false
        raggiungibili = raggiungibili(1:2);
    end
        
    checkPuoMuoverla = false;
    contatore=0;
    for i=1:length(raggiungibili)
        if raggiungibili(i)~="empty"
            diviso=char(raggiungibili(i));
            lettera_ragg=diviso(1);
            numero_ragg=str2double(diviso(2));
            if scacchiera{set.colonne==lettera_ragg,numero_ragg}.Piena
                raggiungibili(i)="empty"; % anche se è piena da altro colore non puo atterrarci
                % dovrò gestire nella parte precedente quando puo mangiare
            else
            contatore=contatore+1;
            end
        end
    end
    if contatore>0
        checkPuoMuoverla = true;
    end

    % se ha caselle di atteraggio disponibile ed è tra le mie
    % pedine ha scelto una casella adeguata  
    if sum(contains(tuePedine,X))==1 && checkPuoMuoverla
        sceltaSbagliata=false;
    else
        disp("Non puoi muovere qualcosa in quella posizione")
    end
end

% faccio scegliere dove muovere
sceltaSbagliata = true;

while sceltaSbagliata
    Y = input('Dove la muovi? Indica la posizione tra virgolette doppie (es. "a1")... '); % dove muovere
    if sum(contains(raggiungibili,Y))==1
        sceltaSbagliata=false;
        %%% modificare tutto di conseguenza al movimento
        diviso=char(Y);
        lettera_arrivo=diviso(1);
        numero_arrivo=str2double(diviso(2));
        scacchiera{set.colonne==lettera_arrivo,numero_arrivo}.Contenuto= Pedina(turno,scacchiera{set.colonne==lettera_arrivo,numero_arrivo}.Name);
        scacchiera{set.colonne==lettera_arrivo,numero_arrivo}.Piena= true;
        if numero_arrivo==set.righe && turno=="W"
            scacchiera{set.colonne==lettera_arrivo,numero_arrivo}.Contenuto.Dama=true;
        elseif  numero_arrivo==1 && turno=="B"
            scacchiera{set.colonne==lettera_arrivo,numero_arrivo}.Contenuto.Dama=true;
        else
            scacchiera{set.colonne==lettera_arrivo,numero_arrivo}.Contenuto.Dama=scacchiera{set.colonne==lettera,numero}.Contenuto.Dama;
        end
        scacchiera{set.colonne==lettera,numero}.Piena=false;
        scacchiera{set.colonne==lettera,numero}.Contenuto="empty";
    else
        disp("Non puoi muoverla lì")
    end
end
