/**
Função Modificadora onlyOwner

Agora que nosso contrato base ZombieFactory herda de Ownable, nós podemos usar a função modificadora onlyOwner e também em ZombieFeeding.
Isto por que é assim que a herança de contratos funciona. Lembre-se:
*/

ZombieFeeding is ZombieFactory
ZombieFactory is Ownable

/**
Sendo assim ZombieFeeding é também Ownable, e tem acesso as funções / eventos / modificadores do contrato Ownable. Isto se aplica para qualquer contrato que herdar de ZombieFeeding no futuro também.

Funções Modificadoras
Uma função modificadora se parece com uma função, mas usa a palavra reservada modifier ao invés da palavra reservada function. E não pode ser chamada diretamente como um função - ao invés nós podemos anexar o nome da função modificador no final da definição da função para mudar o comportamento da função.
Vamos olhar de perto e examinar o onlyOwner:
*/

/**
 * @dev Lança um erro se for chamada por outra conta que não seja o dono.
 */
modifier onlyOwner() {
  require(msg.sender == owner);
  _;
}

/**
Podemos usar este modificar conforme segue:
*/

contract MyContract is Ownable {
  event LaughManiacally(string laughter);

  // Veja o uso de `onlyOwner` abaixo:
  function likeABoss() external onlyOwner {
    LaughManiacally("Muahahahaha");
  }
}


/**
Perceba que onlyOwner modifica a função likeABoss. Quando você chama likeABoss, o código dentro de onlyOwner executa primeiro. Depois quando chega na declaração _; em onlyOwner, volta e executa o código dentro de likeABoss.
Enquanto há outras maneiras de usar os modificares, um dos casos mais comuns são os de adicionar rapidamente verificações de require antes de uma função executar.
No caso de onlyOwner, adicionar este modificador à função faz com que only (somente) o owner (dono) do contrato (você, se você implantou-o) possa chamar essa função.
    Nota: Dar ao dono poderes especiais sobre o contrato assim frequentemente é necessário, mas isso também pode ser malicioso. Por exemplo, o dono pode adicionar uma função backdoor que permitiria a transferência do zumbi de qualquer pessoa para ele mesmo!
    Então é importante lembrar que somente porque uma DApp está no Ethereum, não quer dizer automaticamente que ela é decentralizado - você tem que ler todo o código fonte para ter certeza que ela é livre de controles especiais impostos pelo dono que você deve se preocupar. Como um desenvolvedor, há um cuidadoso equilíbrio entre manter o controle sobre uma DApp, para que você possar arrumar potenciais problemas, e construir uma plataforma sem dono, para que os usuários possam confiar e manter os dados seguros.

*/
