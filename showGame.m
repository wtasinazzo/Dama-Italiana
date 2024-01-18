function showGame(scacchiera,set)
imshow(set.imm);
hold on

for i=1:set.righe
    for j=1:length(set.colonne)
        show(scacchiera{i,j})
    end
end