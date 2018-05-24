# Trabalho de Conceitos de Linguagens de Programação
Este projeto se trata de um jogo utilizando linguagem Lua e o framework LÖVE para desenvolvimento de jogos 2D.

## O Jogo
 O objetivo do jogo é destruir uma quantidade objetiva de asteroides.

## Implementação
[x] Menu principal (jogar, sair)

[x] Nave (movimentação, destruição, tiros)

[x] Asteroides (criação, movimentação, destruição)

[x] Telas de gameover e objetivo concluído

[x] Menu secundário (recomeçar, sair)

[x] Pontuação

## Pré-requisitos (Desenvolvimento)
  - [Lua](https://www.lua.org/start.html)
  - [LÖVE](https://love2d.org/)
  - Editor de texto

## Código
- main.lua
 : aplicação principal
  * menuPrincipal(tecla) - lógica do menu principal
  * menuSecundario(tecla)
  * trocaMusicaDeFundo()
  * love.load() - carregamento de arquivos
  * love.update(dt) - lógica do programa
  * love.keypressed() - acionado quando o usuário aperta alguma tecla
  * love.draw() - desenha os objetos na tela
  
- conf.lua
 : contém informações de configuração do jogo
 
- nave.lua
 : contém a classe nave com sua estruturação e funções relacionadas.
  * Nave{} - estrutura tabela de Nave
  * Nave:new(obj, posx, posy, img) - construtor de objeto
  * Nave:move(largura_tela, altura_tela) - movimentação do objeto nave
  * Nave:atira() - atira 
  * Nave:reset(posx, posy) - reseta posição da imagem
  * Nave:destroi() - destrói nave
  
- tiro.lua
 : contém funções relacionadas à manipulação dos tiros da nave
  * criaTiro(posx, posy) - cria um objeto tiro na posição dada
  * moveTiro(tiros) - movimentação de tiros no array
  * limpaTiros(tiros)
  * checaColisaoComTiros(jogo, nave, meteoros)
  
 - meteoro.lua
  * criaMeteoro()
  * moveMeteoros()
  * temColisao(posx1, posy1, largura1, altura1, posx2, posy2, largura2, altura2)
  * checaColisoes(jogo, nave)
  * removeMeteoros()
  * limpaMeteoros()
  * checaColisaoComNave(nave)
  
  
