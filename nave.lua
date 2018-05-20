Nave = {
    largura = 64,
    altura = 64,
    tiros = {}
}

-- construtor
function Nave:new (obj, largura_tela, altura_tela, img)
  obj = obj or {}
  setmetatable(obj, self)
  self.__index = self
  self.x = largura_tela/2 - self.largura/2 or 0 --seta posição no meio da tela
  self.y = altura_tela - self.altura or 0 --seta nave na posição inferior
  self.imagem_src = img
  return obj
end


function Nave:move(largura_tela, altura_tela)
  if love.keyboard.isDown('w') and self.y >=0 then
      self.y = self.y - 2
  end
  if love.keyboard.isDown('s') and self.y < altura_tela - self.altura then
      self.y = self.y + 2
  end
  if love.keyboard.isDown('a') and self.x >= 0 then
      self.x = self.x - 2
  end
  if love.keyboard.isDown('d') and self.x < largura_tela - self.largura  then
      self.x = self.x + 2
  end
end

return Nave