class_nave = require("nave")

jogo = {
	titulo = "Nave x Asteroides",
	largura_tela = 320,
	altura_tela = 480,
	max_meteoros = 12,
	fim_jogo = false,
	meteoros_atingidos = 0,
	numero_meteoros_objetivo = 100
}

function love.load()
	--propriedades da janela
	love.window.setMode(jogo.largura_tela, jogo.altura_tela, {resizable = false})
    love.window.setTitle(jogo.titulo)

  	--path das imagens-estado da nave
    nave_src = "imagens/nave.png"

    --instancia um objeto da classe Nave
    nave = class_nave:new(nil, jogo.largura_tela, jogo.altura_tela, nave_src)

    --imagens do jogo
    background_img = love.graphics.newImage("imagens/universe.png")
    nave_img = love.graphics.newImage(nave.imagem_src)
  
    --sons do jogo

end
 
function love.update(dt)
	nave:move(jogo.largura_tela, jogo.altura_tela)
end
 
function love.draw()
    love.graphics.draw(background_img, 0, 0)
    love.graphics.draw(nave_img, nave.x, nave.y)

end