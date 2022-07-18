/**
Requerer (Require)

Na lição 1, possibilitamos os usuários de criar novos zumbis chamando a função createRandomZombie e colocando um nome. Porém, se os usuários continuarem chamando esta função e de forma ilimitada criando zumbis em seus exércitos, o jogo não teria tanta graça.
Vamos fazer assim, cada jogador só pode chamar esta função uma vez. Desta maneira novos jogadores irão chamar só quando começarem o jogo pela primeira vez, para criar o primeiro zumbi do exército.
Como podemos fazer esta função ser chamada somente uma vez por jogador?
Para isso nós vamos usar o require (requerer). require faz com que a função lance um erro e pare a execução se alguma condição não for verdadeira:
*/

function sayHiToVitalik(string _name) public returns (string) {
  // Compara se _name é igual à "Vitalik". Lança um erro e termina se não for verdade.
  // (Lembrete: Solidity não tem uma forma nativa de comparar strings, então
  // temos que comparar os hashes keccak256 para verificar a igualdade)
  require(keccak256(_name) == keccak256("Vitalik"));

  // Se é verdade, prossiga com a função:
  return "Olá!";
}

/**
Se você chamar esta função com sayHiToVitalik("Vitalik"), ela irá retornar "Olá!". Se você chamar esta função com outra entrada, ela irá lançar um erro e não irá executar.
Sendo assim, require é muito útil para verificar certas condições que devem ser verdadeiras antes de executar uma função.

*/
