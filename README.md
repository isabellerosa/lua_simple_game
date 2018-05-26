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
## Sobre Lua
Lua é uma linguagem de script de multiparadigma, pequena, reflexiva e leve, projetada para expandir aplicações em geral, por ser uma linguagem extensível (que une partes de um programa feitas em mais de uma linguagem), para prototipagem e para ser embarcada em softwares complexos. 
Oferece suporte a programação procedural, orientada a objeto, funcional, orientada a dados e definição de dados. É tipada dinamicamente, interpretada a partir de bytecodes, e tem gerenciamento automático de memória com coleta de lixo.

*Nota: Lua não foi construída com suporte para programação orientada a objeto. Não contém apoio explícito à herança, mas permite que ela seja executada com relativa facilidade com metatables. Do mesmo modo, Lua permite que programadores quando implementam nomes, classes, e outras funções, empreguem poderosas técnicas de programação funcional e completos escopos lexicais.*

## Sobre LÖVE
LÖVE é um framework para criação de jogos 2D em Lua. É gratuito, código-aberto e funciona em Windows, Mac OS X, Linux, Android e iOS.


## Arquivos e funções
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
 
