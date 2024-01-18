classdef Pedina
   properties
      Colore 
      Posizione
      Dama
   end
   methods
       function obj = Pedina(colore,pos)
        if nargin == 2
            obj.Colore = colore;
            obj.Posizione= pos;
            obj.Dama = false;
        end 
       end

       function x = string(obj)
        if nargin == 1
            x=obj.Colore;
        end 
       end

              
      % function r = roundOff(obj)
      %    r = round([obj.Value],2);
      % end
      % function r = multiplyBy(obj,n)
      %    r = [obj.Value]*n;
      % end
   end
end