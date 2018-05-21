function criaTiro(posx, posy)
  	local tiro = {
       largura = 16,
       altura = 16,
       x = posx,
       y = posy
   }

   return tiro
end


function moveTiro(tiros)
  for i = #tiros, 1, -1 do --percorre o array de trás pra frente
      if tiros[i].y > 0 then
          tiros[i].y = tiros[i].y - 2
      else
          table.remove(tiros, i)
      end
  end
end
