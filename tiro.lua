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

function limpaTiros(tiros)
  for i = #tiros, 1, -1 do
    table.remove(tiros, i)
  end
end

function checaColisaoComTiros(nave, jogo)
	for i = #nave.tiros, 1, -1 do
		for j = #meteoros, 1, -1 do
			if temColisao(nave.tiros[i].x, nave.tiros[i].y, nave.tiros[i].largura, nave.tiros[i].altura,
					meteoros[j].x, meteoros[j].y, meteoros[j].largura, meteoros[j].altura) then
						table.remove(nave.tiros, i)
						table.remove(meteoros, j)
            jogo.meteoros_atingidos = jogo.meteoros_atingidos + 1
						break
			end
		end
	end
end
