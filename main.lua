class_nave = require("nave")

jogo = {
	titulo = "Nave x Asteroides",
	largura_tela = 320,
	altura_tela = 480,
	max_meteoros = 12,
	fim_jogo = false,
	meteoros_atingidos = 0,
	numero_meteoros_objetivo = 100,
	menu_ativo = true,
}

jogo.menu = {
	jogar = true,
	sair = false
}

function logicaMenu(tecla)
	if menu.jogar and ( tecla == 's' or tecla == 'down') then 
		menu.jogar = false
		menu.sair = true
	elseif menu.sair and (tecla == 'w' or tecla == 'up') then
		menu.jogar = true
		menu.sair = false
	end	

	if menu.jogar and tecla == 'space' then
		jogo.menu_ativo = false
	elseif menu.sair and tecla == 'space' then
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

    --instancia um objeto da classe Nave
    nave = class_nave:new(nil, jogo.largura_tela, jogo.altura_tela, nave_src)
    --menu principal
    menu = jogo.menu

    --imagens do jogo
    background_img = love.graphics.newImage("imagens/universe.png")

    nave_img = love.graphics.newImage(nave.imagem_src)
    tiro_img = love.graphics.newImage("imagens/tiro.png")
  	start_img = love.graphics.newImage("imagens/menu/play.png")
  	exit_img = love.graphics.newImage("imagens/menu/exit.png")
  	startact_img = love.graphics.newImage("imagens/menu/play_active.png")
  	exitact_img = love.graphics.newImage("imagens/menu/exit_active.png")
  	comandos_img = love.graphics.newImage("imagens/menu/comandos.png")


    --sons do jogo

end
 
function love.update(dt)
	-- se o jogo tiver começado
	if jogo.menu_ativo == false and jogo.fim_jogo == false then
		nave:move(jogo.largura_tela, jogo.altura_tela)
		nave:moveTiro()
	end
end

function love.keypressed(tecla)
	-- logica do menu principal
	if jogo.menu_ativo then
		logicaMenu(tecla)

	--tecla de tiro com intervalo entre tiros
	elseif tecla == "space" and (love.timer.getTime() - start) >= 0.75 then
			nave:atira()
			start = love.timer.getTime() 
	end
end
 
function love.draw()
    love.graphics.draw(background_img, 0, 0)

    --desenha menu principal
	if jogo.menu_ativo then 
		if menu.jogar then
			love.graphics.draw(startact_img, jogo.largura_tela/2-99, 250)
			love.graphics.draw(exit_img, jogo.largura_tela/2-99, 350)
		else
			love.graphics.draw(start_img, jogo.largura_tela/2-99, 250)
			love.graphics.draw(exitact_img, jogo.largura_tela/2-99, 350)
		end

		--love.graphics.draw(comandos_img, jogo.largura_tela/2-115.5, 350)

	else
	    love.graphics.draw(nave_img, nave.x, nave.y)


	    --desenha tiros
	    for k, tiro in pairs(nave.tiros) do
	        love.graphics.draw(tiro_img, tiro.x, tiro.y) 
	    end
	end
end