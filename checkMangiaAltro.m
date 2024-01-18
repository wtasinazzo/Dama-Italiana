function [check,daMuovere,doveMuovere,mangiate] = checkMangiaAltro(scacchiera,set,tuaPedina,turno)

check = false;
daMuovere = [];
mangiate = [];
doveMuovere = [];

% trovo se la tua pedina ha tra le raggiungibili una pedina
% avversaria NON DAMA e in quale direzione ce l'hanno
direzione=[];
pedine_avv_raggiunte=[];
candidate=[];

% trovo le raggiungibili
raggiungibili = raggiunge(scacchiera{tuaPedina(1),tuaPedina(2)},set);

if turno=="W" && scacchiera{tuaPedina(1),tuaPedina(2)}.Contenuto.Dama==false
    raggiungibili(1) = "empty";
    raggiungibili(2) = "empty";
elseif turno=="B" && scacchiera{tuaPedina(1),tuaPedina(2)}.Contenuto.Dama==false
    raggiungibili(3) = "empty";
    raggiungibili(4) = "empty";
end

% trovo raggiungibili che contengono pedina NON DAMA SE LA MIA NON E DAMA
% avversaria e in che direzione ce l'hanno
for k=1:4
    if raggiungibili(k)~="empty"
        diviso=char(raggiungibili(k));
        lettera_ragg=diviso(1);
        numero_ragg=str2double(diviso(2));
        
        if scacchiera{set.colonne==lettera_ragg,numero_ragg}.Piena
            if scacchiera{set.colonne==lettera_ragg,numero_ragg}.Contenuto.Colore~=turno ... % pedina avversaria
                    && (~scacchiera{set.colonne==lettera_ragg,numero_ragg}.Contenuto.Dama || ... % pedina avversaria non sia dama
                    (scacchiera{set.colonne==lettera_ragg,numero_ragg}.Contenuto.Dama && scacchiera{tuaPedina}.Contenuto.Dama) ) % o se lo è che lo sia anche la mia
                candidate = tuaPedina; % pedina che potrebbe mangiare (numerocolonna, numeroriga)
                direzione=[direzione, k]; % direzione in cui c'è pedina avversaria
                pedine_avv_raggiunte=[pedine_avv_raggiunte,...
                    scacchiera{set.colonne==lettera_ragg,numero_ragg}.Name]; % Pedina che puo essere mangiata
            end
        end
    end

end


% Trovo se pedine avversarie vicine possono essere mangiate

for i=1:length(direzione) %per ciascuna delle candidate

    diviso=char(pedine_avv_raggiunte(i));
    lettera=diviso(1);
    numero=str2double(diviso(2));
    raggiungibili = raggiunge(scacchiera{set.colonne==lettera,numero},set);
        

    % cerco se la raggiungibile nella direzione in cui vorrei mangiare è
    % vuota
    diviso=char(raggiungibili(direzione(i)));
    lettera_ragg=diviso(1);
    numero_ragg=str2double(diviso(2));
    if diviso~="empty"
        if ~ scacchiera{set.colonne==lettera_ragg,numero_ragg}.Piena
            check = true;
            daMuovere=[daMuovere; tuaPedina];
            mangiate = [mangiate, pedine_avv_raggiunte(i)];
            doveMuovere = [doveMuovere, scacchiera{set.colonne==lettera_ragg,numero_ragg}.Name];
        end
    end
end

