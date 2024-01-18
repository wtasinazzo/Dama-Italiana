classdef Casella
   properties
      Name 
      Piena {mustBeNumericOrLogical}
      Posizione
      Contenuto 
      Raggiunge
      
   end
   methods
       function obj = Casella(nome,posizione)
           obj.Name = nome;
           obj.Posizione = posizione;
           obj.Piena = false;
           obj.Contenuto = 'empty';
       end
       
       function x = string(obj)
        if nargin == 1
            x=obj.Name;
        end 
       end

       function show(obj)
        if obj.Piena
            colore=obj.Contenuto.Colore;
            if colore=="W"
                colore="white";
            else
                colore="black";
            end
            dama=obj.Contenuto.Dama;
            if dama
                disegno="diamond";
            else
                disegno="o";
            end
            plot(obj.Posizione(1),obj.Posizione(2),"Marker",disegno,"LineWidth",10,"Color",colore)
        end 
       end

       function col = estraiColonna(obj,set)
           vect=char(obj.Name);
           lettera = vect(1);
           col=find(set.colonne==lettera);
       end

       function rig = estraiRiga(obj)
           vect=char(obj.Name);
           rig = vect(2);
           rig = str2double(rig);
       end

       function vettore= raggiunge(obj,set)
           if ~isempty(obj.Raggiunge)
               vettore=obj.Raggiunge;
           else
               vettore=["empty","empty","empty","empty"];
               if contains(obj.Name,"a1")
               vettore(3) = "b2";
               elseif contains(obj.Name,"h8")
                   vettore(2) = "g7";
               elseif contains(obj.Name,"1")
                   vettore(3) = set.colonne(estraiColonna(obj,set)+1)+"2";
                   vettore(4) = set.colonne(estraiColonna(obj,set)-1)+"2";
               elseif contains(obj.Name,"8")
                   vettore(1) = set.colonne(estraiColonna(obj,set)+1)+"7";
                   vettore(2) = set.colonne(estraiColonna(obj,set)-1)+"7";
               elseif contains(obj.Name,"a")
                   vettore(1) = "b"+num2str(estraiRiga(obj)-1);
                   vettore(3) = "b"+num2str(estraiRiga(obj)+1);
               elseif contains(obj.Name,"h")
                   vettore(2) = "g"+num2str(estraiRiga(obj)-1);
                   vettore(4) = "g"+num2str(estraiRiga(obj)+1);
               else 
                   vettore(1) =  set.colonne(estraiColonna(obj,set)+1)+num2str(estraiRiga(obj)-1);
                   vettore(2) =  set.colonne(estraiColonna(obj,set)-1)+num2str(estraiRiga(obj)-1);
                   vettore(3) =  set.colonne(estraiColonna(obj,set)+1)+num2str(estraiRiga(obj)+1);
                   vettore(4) =  set.colonne(estraiColonna(obj,set)-1)+num2str(estraiRiga(obj)+1);
               end
           end
       end

       % function setCasella(val)
       %     obj.Pedina=val

       
      % function r = roundOff(obj)
      %    r = round([obj.Value],2);
      % end
      % function r = multiplyBy(obj,n)
      %    r = [obj.Value]*n;
      % end
   end
end