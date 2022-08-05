/**
Laços `for`

No capítulo anterior, mencionamos que algumas vezes você irá querer usar o laço for
para construir os conteúdos de um array em uma função ao invés de simplesmente salvar esse array no storage.

Veremos o por quê.

Para a nossa função getZombiesByOwner, uma implementação ingênua seria guardar os 
donos dos exércitos de zumbis em um storage (armazenamento) no contrato ZombieFactory:
*/

mapping (address => uint[]) public ownerToZombies

/**
Então toda vez que criamos um novo zumbi, seria simples usar 
*/

ownerToZombies[owner].push(zombieId);

/**
para adicioná-lo no array do dono do zumbi. E getZombiesByOwner seria uma função bem simples:
*/

function getZombiesByOwner(address _owner) external view returns (uint[]) {
  return ownerToZombies[_owner];
}


/**
O problema com esta abordagem

Esta abordagem é tentadora pela sua simplicidade. 
Mas vejamos o que acontece se mais tarde adicionarmos uma função que transfer um zumbi 
para outro dono (e com certeza queremos adicionar em uma lição posterior!).

Esta função de transferência precisaria:
    Inserir o zumbi no array ownerToZombies do novo dono,
    Remover o zumbi do array do antigo ownerToZombies do antigo dono,
    Deslocar todos zumbis no array do antigo do dono para tapar o buraco, e então
    Reduzir o tamanho do array por 1.

O passo 3 seria extremamente caro em gas, uma vez que teremos que escrever para
cada zumbi de que a posição foi trocada. 
Se o dono tiver 20 zumbis e trocar o primeiro da lista, nós teremos que fazer 19 escritas para manter a order da lista.

Um vez que escrever em storage (armazenamento) é uma das operações mais caras em Solidity, 
cada chamada para essa função seria extremamente cara. 
E pior, ela custaria uma quantidade de gas diferente cada vez que fosse chamada, 
dependendo em quantos zumbis o usuário teria em seu exército e o índice que seria trocado. 
Então o usuário não saberia quando em gas precisaria enviar.

Nota: É claro que poderíamos somente mover o último zumbi na lista e preencher um espaço vazio 
para reduzir o tamanho do array. 
Mas então mudaríamos a ordem dos nossos exército de zumbis toda vez que houvesse uma troca.

Desde que funções view não custam gas algum quando chamadas externamente, 
poderíamos simplesmente usar um laço for em getZombiesByOwner para iterar todos os zumbis na 
lista e construir um array de zumbis que pertencem a este usuário específico. 
Então nossa função transfer seria muito mais barata, um vez que não precisamos 
reordenar qualquer array em storage, e de certa maneira não intuitiva essa abordagem é mais barata de todas.


Usando laços for

A sintaxe do laço for em Solidity é similar a de Javascript.
Vejamos um exemplo onde queremos fazer um array de números pares:
*/

function getEvens() pure external returns(uint[]) {
  uint[] memory evens = new uint[](5);

  // Mantêm o registro do índex do novo array:
  uint counter = 0;

  // Itera 1 através de 10 com um laço for:
  for (uint i = 1; i <= 10; i++) {
    // Se `i` é par ...
    if (i % 2 == 0) {

      // Adiciona em nosso array
      evens[counter] = i;

      // Incrementa o contador para o próximo índex vazio em `evens`:
      counter++;
    }
  }

  return evens;
}

/**
Esta função irá retornar um array com o conteúdo [2, 4, 6, 8, 10].
*/


