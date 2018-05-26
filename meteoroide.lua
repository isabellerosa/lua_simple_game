-- ----------------------------------------
-- ----------------------------------------
-- ----------------------------------------
-- Funções e caracteristicas dos Asteróides
-- ----------------------------------------
-- ----------------------------------------
-- ----------------------------------------

meteoroides = {}

function criaMeteoroide(dificuldade)
	meteoroide = {
		x = math.random(jogo.largura_tela),
		y = -70,
		largura = 50,
		altura = 43,
		peso = math.random(dificuldade),
		deslocamento_horizontal = math.random(-1,1)
		
	}

	table.insert(meteoroides, meteoroide)
end

function moveMeteoroides()
	for i,meteoroide in pairs(meteoroides) do
		meteoroide.y = meteoroide.y + meteoroide.peso
		meteoroide.x = meteoroide.x + meteoroide.deslocamento_horizontal
	end
end

function temColisao(X1, Y1, L1, A1, X2, Y2, L2, A2) 
	return  X2 < X1 + L1 and
			X1 < X2 + L2 and
			Y1 < Y2 + A2 and
			Y2 < Y1 + A1
end

function checaColisoes(jogo, nave)

	checaColisaoComNave(nave)
	checaColisaoComTiros(nave, jogo)

end

function removeMeteoroides()
	for i = #meteoroides,1,-1 do
		if meteoroides[i].y > jogo.altura_tela then
			table.remove(meteoroides, i)
		end
	end
end

function limpaMeteoroides()
	for i = #meteoroides,1,-1 do
		table.remove(meteoroides, i)
	end
end

function checaColisaoComNave(nave)
	for k,meteoroide in pairs(meteoroides) do
		if temColisao(meteoroide.x, meteoroide.y, meteoroide.largura, meteoroide.altura,
		 nave.x, nave.y, nave.largura, nave.altura) then
			trocaMusicaDeFundo()
			nave:destroi()
			jogo.fim_jogo = true
			jogo.menu_secundario = true
		end
	end
end
