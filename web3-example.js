// Como iremos acessar o contrato:
var abi = /* abi gerada pelo compilador */
var ZombieFactoryContract = web3.eth.contract(abi)
var contractAddress = /* endereço do nosso contrato após implantado */
var ZombieFactory = ZombieFactoryContract.at(contractAddress)
// `ZombieFactory` tem acesso as funções públicas e eventos em nosso contrato

// um tipo de ouvinte para o evento que pega o texto de entrada:
$("#ourButton").click(function(e) {
  var name = $("#nameInput").val()
  // Executa a função em nosso contrato `createRandomZombie`:
  ZombieFactory.createRandomZombie(name)
})

// Ouve por um evento `NewZombie`, e atualiza a interface UI
var event = ZombieFactory.NewZombie(function(error, result) {
  if (error) return
  generateZombie(result.zombieId, result.name, result.dna)
})

// obtém o dna Zumbi e atualiza a nossa imagem
function generateZombie(id, name, dna) {
  let dnaStr = String(dna)
  // preenche o DNA com zeros a esquerda se for menor que 16 caracteres
  while (dnaStr.length < 16)
    dnaStr = "0" + dnaStr

  let zombieDetails = {
    // os primeiros 2 dígitos fazem a cabeça, nós temos 7 possíveis cabeças, então % 7
    // para conseguir um número 0 - 6, então adicionamos 1 para fazer 1 - 7, então nós temos 7
    // os arquivos de imagens chamam-se "head1.png" até "head7.png" nós carregamos
    // baseados neste número:
    headChoice: dnaStr.substring(0, 2) % 7 + 1,
    // os segundos 2 dígitos fazer os olhos com 11 variações:
    eyeChoice: dnaStr.substring(2, 4) % 11 + 1,
    // 6 variações de camisas:
    shirtChoice: dnaStr.substring(4, 6) % 6 + 1,
    // os últimos 6 dígitos controlam a cor. Atualizando o filtro CCS: hue-rotate
    // que tem 360 graus:
    skinColorChoice: parseInt(dnaStr.substring(6, 8) / 100 * 360),
    eyeColorChoice: parseInt(dnaStr.substring(8, 10) / 100 * 360),
    clothesColorChoice: parseInt(dnaStr.substring(10, 12) / 100 * 360),
    zombieName: name,
    zombieDescription: "CryptoZombie nível 1",
  }
  return zombieDetails
}
