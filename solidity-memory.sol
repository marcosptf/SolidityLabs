/**
Armazenamento vs Memória (Storage vs Memory)

Em Solidity, existem dois lugares onde você pode guardar as variáveis - na storage (armazenamento) e na memory (memória).
Storage (Armazenamento) refere-se as variáveis guardadas permanentemente na blockchain. Memory (Memória) são variáveis temporárias, e são apagadas entre as chamadas externas para o seu contrato. Imagine como o disco rígido do seu computador vs memória RAM.
Na maior parte do tempo você não precisa usar essas palavras-reservadas porque a Solidity cuida disso pra você por padrão. Variáveis de estado (variáveis declaradas fora das funções) são por padrão storage e são escritas permanentemente na blockchain, enquanto variáveis declaradas dentro das funções são memory e irão desaparecer quando a função terminar.
Porém, haverão momentos em que você precisará usar tais palavras-reservadas, por exemplo quando trabalhar com struct e arrays dentro das funções:
Não se preocupe se você não entendeu completamente quando usar qual ainda - através deste tutorial nós iremos lhe mostrar quando usar storage e quando usar memory, e o compilador do Solidity também irá lhe avisar quando você deve usar uma dessas palavras-reservadas.
Por enquanto, é o suficiente para entender que há casos onde você precisará declarar explicitamente storage ou memory!
*/

contract SandwichFactory {
  struct Sandwich {
    string name;
    string status;
  }

  Sandwich[] sandwiches;

  function eatSandwich(uint _index) public {
    // Sandwich mySandwich = sandwiches[_index];

    // ^ Parece bem simples, mas solidity vai dar-lhe um alerta
    // avisando que você deve explicitamente declarar `storage` ou `memory` aqui.

    // Então ao invés, você deve declarar com `storage`, assim:
    Sandwich storage mySandwich = sandwiches[_index];
    // ...neste caso `mySandwich` é um ponteiro `sandwiches[_index]`
    // em armazenamento, e...
    mySandwich.status = "Eaten!";
    // ...e isto permanentemente muda `sandwiches[_index]` na blockchain.

    // Se você só quer uma copia, você deve usar `memory`:
    Sandwich memory anotherSandwich = sandwiches[_index + 1];
    // ...neste caso `anotherSandwich` será somente uma cópia
    // do dado em memória, e...
    anotherSandwich.status = "Eaten!";
    // ...e só irá alterar a variável temporária e não terá efeito
    // em `sandwiches[_index + 1]`. Mas você pode fazer isso:
    sandwiches[_index + 1] = anotherSandwich;
    // ...se você quer a cópia das mudanças salvas na blockchain.
  }
}

