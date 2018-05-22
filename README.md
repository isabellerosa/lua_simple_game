# Trabalho de Conceitos de Linguagens de Programação
Este projeto se trata de um jogo utilizando linguagem Lua e o framework LÖVE para desenvolvimento de jogos 2D.

## O Jogo
 O objetivo do jogo é destruir uma quantidade objetiva de asteroides.

## Implementação
[x] Menu principal (jogar, sair)

[ ] Nave (movimentação, destruição, tiros)

[ ] Asteroides (criação, movimentação, destruição)

[ ] Telas de gameover e objetivo concluído

[ ] Menu secundário (recomeçar, sair)

[ ] Pontuação

## Pré-requisitos (Desenvolvimento)
  - [Lua](https://www.lua.org/start.html)
  - [LÖVE](https://love2d.org/)
  - Editor de texto

## Código
- main.lua
 : aplicação principal
  * logicaMenu() - lógica do menu principal
  * love.load() - carregamento de arquivos
  * love.update(dt) - lógica do programa
  * love.keypressed() - acionado quando o usuário aperta alguma tecla
  * love.draw() - desenha os objetos na tela
  
- conf.lua
 : contém informações de configuração do jogo
 
- nave.lua
 : contém a classe nave com sua estruturação e funções relacionadas.
  * Nave{} - estrutura tabela de Nave
  * Nave:new - construtor de objeto
  * Nave:move - movimentação do objeto nave
  * Nave:atira - atira
  
- tiro.lua
 : contém funções relacionadas à manipulação dos tiros da nave
  * criaTiro(posx, posy) - cria um objeto tiro na posição dada
  * moveTiro(tiros) - movimentação de tiros no array
