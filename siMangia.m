function scacchiera=siMangia(scacchiera,set,daMuovere,doveMuovere,mangiate,turno)

disp("Devi mangiare")

% caselle movibili
movibile=[];
    for i=1:size(daMuovere,1)
        movibile=[movibile, scacchiera{daMuovere(i,1),daMuovere(i,2)}.Name];
    end

% faccio scegliere quale muovere
sceltaSbagliata = true;
while sceltaSbagliata

    X = input('Che pedina muovi? Indica la posizione tra virgolette doppie (es. "a1")... '); % quale muovere

    if sum(contains(movibile,X))>0 
        contatore1 = contains(movibile,X);
        sceltaSbagliata=false;
        atterraggi = doveMuovere(contains(movibile,X));
    else
        disp("Quella pedina non puo mangiare")
    end
end

% faccio scegliere dove muovere
sceltaSbagliata = true;
while sceltaSbagliata

    X = input('Dove arriva la tua pedina dopo aver mangiato? Indica tra virgolette doppie... '); % dove muovere
    if sum(contains(atterraggi,X))>=1 
        contatore2= contains(atterraggi,X);
        idx_mangiata = find(contatore1.*contatore2==1);
        sceltaSbagliata=false;
        %%% modificare tutto di conseguenza al movimento
        diviso=char(X);
        lettera_arrivo=diviso(1);
        numero_arrivo=str2double(diviso(2));
        scacchiera{set.colonne==lettera_arrivo,numero_arrivo}.Contenuto= Pedina(turno,scacchiera{set.colonne==lettera_arrivo,numero_arrivo}.Name);
        scacchiera{set.colonne==lettera_arrivo,numero_arrivo}.Piena= true;
        if numero_arrivo==set.righe && turno=="W" 
            scacchiera{set.colonne==lettera_arrivo,numero_arrivo}.Contenuto.Dama=true;
        elseif  numero_arrivo==1 && turno=="B"
            scacchiera{set.colonne==lettera_arrivo,numero_arrivo}.Contenuto.Dama=true;
        else
            scacchiera{set.colonne==lettera_arrivo,numero_arrivo}.Contenuto.Dama=scacchiera{daMuovere(idx_mangiata,1),daMuovere(idx_mangiata,2)}.Contenuto.Dama;
        end
        scacchiera{daMuovere(idx_mangiata,1),daMuovere(idx_mangiata,2)}.Piena=false;
        scacchiera{daMuovere(idx_mangiata,1),daMuovere(idx_mangiata,2)}.Contenuto="empty";

        % elimino la pedina mangiata
        diviso=char(mangiate(idx_mangiata));
        lettera_mang=diviso(1);
        numero_mang=str2double(diviso(2));
        scacchiera{set.colonne==lettera_mang,numero_mang}.Piena=false;
        scacchiera{set.colonne==lettera_mang,numero_mang}.Contenuto="empty";

    else
        disp("Non può atterare lì")
    end
end

% controllo se la pedina puo mangiare altro e se puo deve mangiare altro

tuaPedina=[estraiColonna(scacchiera{set.colonne==lettera_arrivo,numero_arrivo},set),...
    estraiRiga(scacchiera{set.colonne==lettera_arrivo,numero_arrivo})];

[check,daMuovere,doveMuovere,mangiate] = checkMangiaAltro(scacchiera,set,tuaPedina,turno);
if check
    showGame(scacchiera,set);
    disp('Devi mangiare ancora')
    scacchiera=siMangia(scacchiera,set,daMuovere,doveMuovere,mangiate,turno);
end
