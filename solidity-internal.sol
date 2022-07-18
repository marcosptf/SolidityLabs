/**
Interno e Externo

Em adição a public e private, Solidity tem mais dois tipos visibilidade em funções: internal (interno) and external (externo).
internal é o mesmo que private, exceto que é também acessível para contratos que herdam a partir do contrato. (Ei, isso soa com o que precisamos!).
external é similar ao public, exceto que essas funções podem ser SOMENTE chamadas fora do contrato - elas não podem ser executadas por outras funções dentro do contrato. Nós vamos falar sobre como você pode usar external vs public mais tarde.
Para declarar funções internal ou external, a sintaxe é a mesma que private and public:
*/

contract Sandwich {
  uint private sandwichesEaten = 0;

  function eat() internal {
    sandwichesEaten++;
  }
}

contract BLT is Sandwich {
  uint private baconSandwichesEaten = 0;

  function eatWithBacon() public returns (string) {
    baconSandwichesEaten++;
    // Podemos chamar aqui porque é uma função `internal`
    eat();
  }
}
