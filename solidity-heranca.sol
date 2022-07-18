/**
Herança

O código do nosso jogo está ficando um tanto grande. Ao invés de fazer um contrato extremamente grande, as vezes faz mais sentido separar as lógicas em vários contratos para organizar o código.
Umas característica que torna o Solidity mais gerenciável é a herança de contrato:
*/

contract Doge {
  function catchphrase() public returns (string) {
    return "Um papai CryptoDoge";
  }
}

contract BabyDoge is Doge {
  function anotherCatchphrase() public returns (string) {
    return "Um lindo BabyDoge";
  }
}


/**
BabyDoge herda de Doge. Isso significa que se você compilar e implantar BabyDoge, ele terá acesso a ambas catchphrase() e anotherCatchphrase() (e qualquer outra função pública que nós podemos definir em Doge).

Isto pode ser útil para uma herança lógica (assim como uma sub classe, um Cat é um Animal). Mas também pode ser usado para uma simples organização em seu código ao agrupar lógicas similares juntas em diferentes classes.
*/
