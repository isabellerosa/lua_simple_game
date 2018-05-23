-- ----------------------------------------
-- ----------------------------------------
-- ----------------------------------------
-- Funções e caracteristicas dos Asteróides
-- ----------------------------------------
-- ----------------------------------------
-- ----------------------------------------

meteoros = {}

function criaMeteoro()
	meteoro = {
		x = math.random(jogo.largura_tela),
		y = -70,
		largura = 50,
		altura = 43,
		peso = math.random(3),
		deslocamento_horizontal = math.random(-1,1)
		
	}

	table.insert(meteoros, meteoro)
end

function moveMeteoros()
	for i,meteoro in pairs(meteoros) do
		meteoro.y = meteoro.y + meteoro.peso
		meteoro.x = meteoro.x + meteoro.deslocamento_horizontal
	end
end

function temColisao(X1, Y1, L1, A1, X2, Y2, L2, A2) 
	return  X2 < X1 + L1 and
			X1 < X2 + L2 and
			Y1 < Y2 + A2 and
			Y2 < Y1 + A1
end

function checaColisoes(jogo, nave)
	for k,meteoro in pairs(meteoros) do
		if temColisao(meteoro.x, meteoro.y, meteoro.largura, meteoro.altura,
		 nave.x, nave.y, nave.largura, nave.altura) then
			trocaMusicaDeFundo()
			nave:destroi()
			jogo.fim_jogo = true
			jogo.menu_secundario = true
		end
	end
end

function removeMeteoros()
	for i = #meteoros,1,-1 do
		if meteoros[i].y > jogo.altura_tela then
			table.remove(meteoros, i)
		end
	end
end

--function destroiNave()
--	
--	love.audio.play(musica_destruicao)
--	nave.imagem_src  = "imagens/tiro.png"
--	nave.imagem = love.graphics.newImage(nave.imagem_src )
--	nave.altura = 16
--	nave.largura = 16
--end

function limpaMeteoros()
	for i = #meteoros,1,-1 do
		table.remove(meteoros, i)
	end
end