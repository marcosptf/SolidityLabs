/**

Pagáveis

Até agora, nós cobrimos algumas funções modificadoras. 
Pode até ser difícil tentar lembrar de tudo, então vamos para uma rápida revisão:

Temos os modificadores de visibilidade que controlam quando em onde a função pode ser chamada: 
private significa que somente pode ser chamada de outras funções dentro do contrato; 
internal é como private mas também pode ser chamada por contratos que herdaram este contrato; 
external pode ser chamada somente de fora do contrato; e finalmente 
public que pode ser chamada de qualquer lugar, tanto internamente quando externamente.

Nós também temos os modificadores de estado, que nós dizem como as funções interagem com o Blockchain: 
view nos diz que ao rodar a função, nenhum dado será salvo/alterado. 
pure nos diz que não somente a função não irá salvar algum dado na blockchain, 
mas também que não irá ler qualquer dado da blockchain. 
Ambas não custam qualquer gas para chamar se forem chamadas externamente ao contrato (mas irão custar se chamadas internamente por outra função).

Então nós temos os modifiers (modificadores personalizáveis), 
que aprendemos sobre na Lição 3: 
onlyOwner e aboveLevel por exemplo. 
Para esses podemos definir uma lógica customizada para determinar como eles irão afetar a função.

Tais modificadores podem ser empilhados juntos na definição da função, conforme exemplo:
*/

function test() external view onlyOwner anotherModifier { /* ... */ }

/**
Neste capítulo, iremos introduzir mais um modificador de função: payable.
O Modificador payable

Funções payable são parte do que faz o Solidity e Ethereum tão legais - 
eles são um tipo de função especial que podem receber Ether.

Vamos imaginar por um minuto. Quando você chama uma função em API em um servidor web, 
você não pode enviar Dólares junto com a sua função — também não pode enviar Bitcoin.

Mas em Ethereum, por que ambos o dinheiro (Ether), e o dado (corpo da transação), 
e o código do contrato todos estão contidos em Ethereum, 
é possível para você chamar uma função e pagar algum dinheiro para um contrato a qualquer momento.

Isto permite um lógica realmente bem interessante, 
como exigir um certo pagamento para que o contrato execute uma função.
Vejamos um exemplo
*/

contract OnlineStore {
  function buySomething() external payable {
    // Verifica para ter certeza que 0.001 ether foi enviado:
    require(msg.value == 0.001 ether);
    // Se enviado, transfira um item digital para o chamador da função
    transferThing(msg.sender);
  }
}

/**
Aqui, msg.value é a forma para ver quanto Ether foi enviado para o contrato, e ether é uma unidade interna.
O que aconteceu aqui é que alguém queria chamar uma função da web3.js 
(de alguma interface JavaScript da DApp) conforme exemplo:

// Assumindo que `OnlineStore` aponta para o seu contrato no Ethereum:
OnlineStore.buySomething({from: web3.eth.defaultAccount, value: web3.utils.toWei(0.001)})
Perceba o campo value (valor), onde a função javascript irá especificar quanto ether à enviar (0.001). 
Se você pensar que a transação é como um envelope, e os parâmetros que você envia para a chamada da 
função são os conteúdos da carta que você colocou dentro, então adicionar o value é como colocar
dinheiro dentro do envelope - a carta e o dinheiro serão entregues juntos ao destinatário.

Nota: Se a função não for marcada como payable e você tentar enviar Ether como feito acima, a função irá rejeitar a sua transação.

*/
