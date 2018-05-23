class_nave = require("nave")
require("tiro")
require("conf")
require("meteoro")

function logicaMenu(tecla)
	if jogo.menu_principal.jogar and ( tecla == 's' or tecla == 'down') then 
		jogo.menu_principal.jogar = false
		jogo.menu_principal.sair = true
	elseif jogo.menu_principal.sair and (tecla == 'w' or tecla == 'up') then
		jogo.menu_principal.jogar = true
		jogo.menu_principal.sair = false
	end	

	if jogo.menu_principal.jogar and tecla == 'space' then
		jogo.menu_principal_ativo = false
		jogo.ativo = true
	elseif jogo.menu_principal.sair and tecla == 'space' then
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
  	comandos_img = love.graphics.newImage("imagens/menu/comandos.png")
  	meteoro_img = love.graphics.newImage("imagens/asteroide.png")

    --sons do jogo
    musica_ambiente = love.audio.newSource("audios/ambiente.mp3","stream")
    musica_ambiente:setLooping(true)
    love.audio.play(musica_ambiente)

    musica_destruicao = love.audio.newSource("audios/destruicao.wav","stream")
    musica_game_over = love.audio.newSource("audios/game_over.wav","stream")
end
 
function love.update(dt)
	-- se o jogo tiver começado
	if jogo.menu_principal_ativo == false and jogo.fim_jogo == false then
		nave:move(jogo.largura_tela, jogo.altura_tela)
		moveTiro(nave.tiros)

		if jogo.info_controles == false and jogo.ativo == true then
			removeMeteoros()

		    if #meteoros < jogo.max_meteoros then
		    	criaMeteoro()
		    end

		    moveMeteoros()
		    checaColisoes()
		end    

	end
		

end

function love.keypressed(tecla)
	-- logica do menu principal
	if jogo.menu_principal_ativo then
		jogo.info_controles = true
		logicaMenu(tecla)
	-- some com o guia e comeca o jogo
	elseif jogo.ativo and jogo.info_controles then
		jogo.info_controles = false

	--tecla de tiro com intervalo entre tiros
	elseif tecla == "space" and (love.timer.getTime() - start) >= 0.5 then
			nave:atira()
			start = love.timer.getTime() 

	elseif tecla == 'escape' then
		jogo.menu_principal_ativo = true		
	end
end
 
function love.draw()
    love.graphics.draw(background_img, 0, 0)

    --desenha menu principal
	if jogo.menu_principal_ativo then 
		love.graphics.draw(cover_img, 0, 0)
		if jogo.menu_principal.jogar then
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
	--jogo
	else
	    love.graphics.draw(nave_img, nave.x, nave.y)

	    --desenha tiros
	    for k, tiro in pairs(nave.tiros) do
	        love.graphics.draw(tiro_img, tiro.x, tiro.y) 
	    end
	end

	-- desenha os asteroides
	for i,meteoro in pairs(meteoros) do
    	love.graphics.draw(meteoro_img, meteoro.x, meteoro.y)
    end
end



