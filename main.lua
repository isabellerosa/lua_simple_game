class_nave = require("nave")
require("tiro")
require("conf")
require("meteoro")


function resetGame()
	nave:reset(jogo.largura_tela, jogo.altura_tela)
	limpaMeteoros()
	jogo.meteoros_atingidos = 0
	jogo.fim_jogo = false
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

function love.load()
	--propriedades da janela
	love.window.setMode(jogo.largura_tela, jogo.altura_tela, {resizable = false})
    love.window.setTitle(jogo.titulo)

    --relogio
    start = love.timer.getTime()

  	--path das imagens-estado da nave
    nave_src = "imagens/nave.png"

    --Garante que o Math.random não seja igual em cada inicialização
    math.randomseed(os.time())

    --instancia um objeto da classe Nave
    nave = class_nave:new(nil, jogo.largura_tela/2, jogo.altura_tela, nave_src)
    --menu principal
    menu = jogo.menu

    --imagens do jogo
    background_img = love.graphics.newImage("imagens/universe.png")
    cover_img= love.graphics.newImage("imagens/menu/cover.png")

    nave_img = love.graphics.newImage(nave.imagem_src)
    tiro_img = love.graphics.newImage("imagens/tiro.png")
  	start_img = love.graphics.newImage("imagens/menu/jogar.png")
  	exit_img = love.graphics.newImage("imagens/menu/sair.png")
  	startact_img = love.graphics.newImage("imagens/menu/sjogar.png")
  	exitact_img = love.graphics.newImage("imagens/menu/ssair.png")
  	restart_img = love.graphics.newImage("imagens/menu/repetir.png")
  	restartact_img = love.graphics.newImage("imagens/menu/srepetir.png")

  	comandos_img = love.graphics.newImage("imagens/menu/comandos.png")
  	meteoro_img = love.graphics.newImage("imagens/asteroide.png")

  	winner_img = love.graphics.newImage("imagens/vencedor.png")
  	gameover_img = love.graphics.newImage("imagens/gameover.png")

    --sons do jogo
    musica_ambiente = love.audio.newSource("audios/ambiente.mp3","stream")
    musica_ambiente:setLooping(true)
    love.audio.play(musica_ambiente)

    musica_destruicao = love.audio.newSource("audios/destruicao.wav","stream")
    musica_game_over = love.audio.newSource("audios/game_over.wav","stream")
end
 
function love.update(dt)
	-- se o jogo tiver começado
	if jogo.ativo and not jogo.info_controles and not jogo.fim_jogo then
		nave:move(jogo.largura_tela, jogo.altura_tela)
		moveTiro(nave.tiros)


		removeMeteoros()

	    if #meteoros < jogo.max_meteoros then
	    	criaMeteoro()
	    end

	    moveMeteoros()
	    checaColisoes(jogo, nave)
		

	end
		

end

function love.keypressed(tecla)
	-- logica do menu principal
	if jogo.menu_principal then
		jogo.info_controles = true
		menuPrincipal(tecla)
	elseif jogo.fim_jogo then
		menuSecundario(tecla)
	-- some com o guia e comeca o jogo
	elseif jogo.ativo and jogo.info_controles then
		jogo.info_controles = false

	--tecla de tiro com intervalo entre tiros
	elseif tecla == "space" and (love.timer.getTime() - start) >= 0.5 then
			nave:atira()
			start = love.timer.getTime() 

	elseif tecla == 'escape' then
		jogo.menu_principal = true		
	end
end
 
function love.draw()
    love.graphics.draw(background_img, 0, 0)

    --desenha menu principal
	if jogo.menu_principal then 
		love.graphics.draw(cover_img, 0, 0)
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
		--se o jogador tiver vencido
		if jogo.meteoros_atingidos == jogo.numero_meteoros_objetivo  then
			love.graphics.draw(vencedor_img, 0, 0)
		--se o jogador tiver perdido
		else
			love.graphics.draw(gameover_img, 0, 0)
		end

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
	    love.graphics.draw(nave_img, nave.x, nave.y)

	    --desenha tiros
	    for k, tiro in pairs(nave.tiros) do
	        love.graphics.draw(tiro_img, tiro.x, tiro.y) 
	    end
	    -- desenha os asteroides
		for i,meteoro in pairs(meteoros) do
	    	love.graphics.draw(meteoro_img, meteoro.x, meteoro.y)
	    end
	end
end



