/**
Armazenamento é Caro

Uma das operações mais caras em Solidity é usar o storage (armazenamento) - particularmente escrever.

Isto porque toda vez que você escreve uma mudança em um pedaço de dado, 
ela escreve permanentemente na blockchain. 
Para sempre! Milhares de nós em todo o mundo precisam guardar esse dados em seus discos rígidos, 
e esta quantidade de dado continua crescendo continuamente com o tempo conforme o blockchain cresce.
Então há um custo para isso.

E para manter os custos baixos, você precisa evitar escritas de dados no storage
armazenamento exceto quando absolutamente necessário.
Algumas vezes envolve uma lógica de programação ineficiente -
como reconstruir um array em memory (memória) toda vez que a função é chamada ao 
invés de simplesmente salvar o array em uma variável para buscas rápidas.

Na maioria das linguagens, percorrer grande quantidade de dados é caro. 
Mas em Solidity, esta é a maneira mais barata do que usar storage se estiver 
em uma função external view, uma vez que funções view não custam qualquer gas 
para os seus usuários. 
(E gas custa dinheiro real para os seus usuários!).

Iremos aprender os laços for no próximo capítulo, mas primeiro, vamos ver como declarar listas em memória.
Declarando listas em memória
Você pode usar a palavra reservada memorycom arrays (litas) para criar um novo
array dentro da função sem precisar do storage para nada. 
O array só existirá até o fim da função, e isto é um muito mais barato que atualizar 
um array em storage - de graça se for uma função view chamada externamente.

Aqui esta como declarar uma lista em memória:
*/

function getArray() external pure returns(uint[]) {
  // Estancia um novo array em memory com o tamanho de 3
  uint[] memory values = new uint[](3);

  // Adiciona alguns valores
  values.push(1);
  values.push(2);
  values.push(3);

  // Retorna o array
  return values;
}

/**
Este é um exemplo trivial para somente mostrar para você a sintaxe, 
mas no próximo capítulo iremos ver como combinar este laço for em casos reais.

Nota: Arrays em memória precisam ser criados com argumento de tamanho (neste caso 3). 
Atualmente não podem ser redimensionados como arrays em storage com o array.push(),
apesar de que isto pode mudar em uma futura versão do Solidity.

*/






