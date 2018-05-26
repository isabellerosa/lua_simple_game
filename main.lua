class_nave = require("nave")
require("tiro")
require("conf")
require("meteoroide")

meta = 1

function scoreRecorde()
	local file = io.open("score.dat", "a+")
	score = file:read() or 0
	file:close()
	return score+0
end

function salvaScore(score)
	local file = io.open("score.dat", "w")
	file:write(score)
	file:flush()
	file:close()
end

function resetGame()
	love.audio.stop(musica_vitoria)
	love.audio.stop(musica_destruicao)
	love.audio.stop(musica_game_over)
	love.audio.stop(musica_ambiente)

	nave:reset(jogo.largura_tela, jogo.altura_tela)
	nave.imagem = nave_img
	limpaMeteoroides()
	limpaTiros(nave.tiros)
	jogo.meteoroides_atingidos = 0
	jogo.fim_jogo = false
	jogo.velocidade = 3
	meta = 1

end

function menuPrincipal(tecla)
	if jogo.menu.jogar and ( tecla == 's' or tecla == 'down') then 
		jogo.menu.jogar = false
		jogo.menu.sair = true
	elseif jogo.menu.sair and (tecla == 'w' or tecla == 'up') then
		jogo.menu.jogar = true
		jogo.menu.sair = false
	end	

	if jogo.menu.jogar and tecla == 'space' then
		jogo.menu_principal = false
		jogo.ativo = true
	elseif jogo.menu.sair and tecla == 'space' then
		love.event.quit()
	end
end

function menuSecundario(tecla)
	if jogo.menu.recomecar and ( tecla == 's' or tecla == 'down') then 
		jogo.menu.recomecar = false
		jogo.menu.sair = true
	elseif jogo.menu.sair and (tecla == 'w' or tecla == 'up') then
		jogo.menu.recomecar = true
		jogo.menu.sair = false
	end	

	if jogo.menu.recomecar and tecla == 'space' then
		jogo.fim_jogo = false
		jogo.ativo = true
		resetGame()
	elseif jogo.menu.sair and tecla == 'space' then
		love.event.quit()
	end	
end

function trocaMusicaDeFundo()
	love.audio.stop(musica_ambiente)
	if jogo.meteoroides_atingidos == jogo.numero_meteoroides_objetivo then
	    love.audio.play(musica_vitoria)		
	else
		love.audio.play(musica_game_over)
	end
end

function love.load()
	--propriedades da janela
	love.window.setMode(jogo.largura_tela, jogo.altura_tela, {resizable = false})
    love.window.setTitle(jogo.titulo)

    --relogio
    start = love.timer.getTime()

    --Garante que o Math.random não seja igual em cada inicialização
    math.randomseed(os.time())

    --menu principal
    menu = jogo.menu

    --imagens do jogo
    background_img = love.graphics.newImage("imagens/universe.png")
    cover_img= love.graphics.newImage("imagens/menu/cover.png")

    nave_img = love.graphics.newImage("imagens/nave.png")
    navedestroy_img = love.graphics.newImage("imagens/explosao_nave.png")
    tiro_img = love.graphics.newImage("imagens/tiro.png")
  	start_img = love.graphics.newImage("imagens/menu/jogar.png")
  	exit_img = love.graphics.newImage("imagens/menu/sair.png")
  	startact_img = love.graphics.newImage("imagens/menu/sjogar.png")
  	exitact_img = love.graphics.newImage("imagens/menu/ssair.png")
  	restart_img = love.graphics.newImage("imagens/menu/repetir.png")
  	restartact_img = love.graphics.newImage("imagens/menu/srepetir.png")

  	comandos_img = love.graphics.newImage("imagens/menu/comandos.png")
  	meteoroide_img = love.graphics.newImage("imagens/asteroide.png")

  	winner_img = love.graphics.newImage("imagens/vencedor.png")
  	gameover_img = love.graphics.newImage("imagens/gameover.png")

    --sons do jogo
    musica_ambiente = love.audio.newSource("audios/ambiente.mp3","stream")
    musica_ambiente:setLooping(true)
	--love.audio.play(musica_ambiente)

    musica_destruicao = love.audio.newSource("audios/destruicao.wav","stream")
	musica_game_over = love.audio.newSource("audios/game_over.wav","stream")
	musica_vitoria = love.audio.newSource("audios/applause.mp3","stream")
	
	musica_disparo = love.audio.newSource("audios/disparo.wav","stream")

    --instancia um objeto da classe Nave
    nave = class_nave:new(nil, jogo.largura_tela/2, jogo.altura_tela, nave_img)
end

function love.update(dt)
	-- se o jogo tiver começado
	if jogo.ativo and not jogo.info_controles and not jogo.fim_jogo then
		love.audio.play(musica_ambiente)
		nave:move(jogo.largura_tela, jogo.altura_tela)
		moveTiro(nave.tiros)

		removeMeteoroides()

	    if #meteoroides < jogo.max_meteoroides then
	    	criaMeteoroide(jogo.velocidade)
	    end

	    moveMeteoroides()
	    checaColisoes(jogo, nave)
		
	    if jogo.meteoroides_atingidos%10 == 0 and jogo.meteoroides_atingidos > meta*10  then
	    	jogo.velocidade = jogo.velocidade + 1
	    	nave:aumentaVelocidade()
	    	meta = meta + 1
	    end

	end

	if (jogo.fim_jogo and jogo.meteoroides_atingidos > scoreRecorde())	then
		salvaScore(jogo.meteoroides_atingidos)
	end
	
end

function love.keypressed(tecla)

	if not jogo.fim_jogo then

		-- logica do menu principal
		if jogo.menu_principal then
			jogo.info_controles = true
			menuPrincipal(tecla)

		-- some com o guia e comeca o jogo
		elseif jogo.ativo and jogo.info_controles then
			jogo.info_controles = false

		--tecla de tiro com intervalo entre tiros
		elseif tecla == "space" and (love.timer.getTime() - start) >= 0.5 then
				nave:atira()
				start = love.timer.getTime() 

		elseif tecla == 'escape' then
			jogo.ativo = false
			resetGame()
			jogo.menu_principal = true		
		end
	else
		--menu secundario
		if (love.timer.getTime() - start) >= 1 then
			menuSecundario(tecla)
		end
	end
end
 
function love.draw()
    love.graphics.draw(background_img, 60, 0)

    --desenha menu principal
	if jogo.menu_principal then 
		love.graphics.draw(cover_img, jogo.largura_tela/2-160, 0)
		if jogo.menu.jogar then
			love.graphics.draw(startact_img, jogo.largura_tela/2-99, 240)
			love.graphics.draw(exit_img, jogo.largura_tela/2-99, 310)
		else
			love.graphics.draw(start_img, jogo.largura_tela/2-99, 240)
			love.graphics.draw(exitact_img, jogo.largura_tela/2-99, 310)
		end
	--exibe controles antes do jogo começar
	elseif jogo.info_controles and jogo.ativo then
		love.graphics.draw(comandos_img, jogo.largura_tela/2-115.5, jogo.altura_tela/2-49.5)
		love.graphics.draw(nave_img, nave.x, nave.y)

	elseif jogo.fim_jogo then
			love.graphics.draw(nave.imagem, nave.x, nave.y)
			love.graphics.draw(gameover_img, jogo.largura_tela/2-160, 0)
	
		--exibe menu secundario
		if jogo.menu.recomecar then
			love.graphics.draw(restartact_img, jogo.largura_tela/2-99, 240)
			love.graphics.draw(exit_img, jogo.largura_tela/2-99, 310)
		else
			love.graphics.draw(restart_img, jogo.largura_tela/2-99, 240)
			love.graphics.draw(exitact_img, jogo.largura_tela/2-99, 310)
		end
	--jogo
	else
	    love.graphics.draw(nave.imagem, nave.x, nave.y)

	    --desenha tiros
	    for k, tiro in pairs(nave.tiros) do
	        love.graphics.draw(tiro_img, tiro.x, tiro.y) 
	    end
	    -- desenha os asteroides
		for i,meteoroide in pairs(meteoroides) do
	    	love.graphics.draw(meteoroide_img, meteoroide.x, meteoroide.y)
	    end

	    love.graphics.print("Meteoroides atingidos: "..jogo.meteoroides_atingidos, 0, 0)
	    love.graphics.print("Recorde: "..scoreRecorde(), 0, 12)
	end
end



