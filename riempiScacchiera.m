function scacchiera=riempiScacchiera(scacchiera)
whitePlaces = [1,3,5,7,10,12,14,16,17,19,21,23];
for i=whitePlaces
    scacchiera{i}.Contenuto=Pedina('W',scacchiera{i}.Name);
    scacchiera{i}.Piena=true;
end

blackPlaces = [64,62,60,58,55,53,51,49,48,46,44,42];
for i=blackPlaces
    scacchiera{i}.Contenuto=Pedina('B',scacchiera{i}.Name);
    scacchiera{i}.Piena=true;  
end