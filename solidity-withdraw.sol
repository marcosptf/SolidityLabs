/**

Saques

No capítulo anterior, aprendemos como enviar Ether para um contrato. Então o que acontece após o envio?

Após você enviar Ether para um contrato, este fica guardado na conta Ethereum do contrato, 
e ficará preso no contrato - ao menos que você adicione uma função para sacar o Ether do contrato.

Você pode escrever a função para sacar o Ether do contrato conforme exemplo:
*/

contract GetPaid is Ownable {
  function withdraw() external onlyOwner {
    owner.transfer(this.balance);
  }
}

/**
Note que usamos owner e onlyOwner do contrato Ownable, assumindo que foi importado.
Você pode transferir Ether para um endereço usando a função transfer, e this.balance irá retornar o 
saldo total guardado no contrato. 
Então se 100 usuários pagarem 1 Ether para nos contrato, this.balance irá ser igual a 100 Ether.

Você pode usar transfer para enviar fundos para qualquer endereço Ethereum. 
Por exemplo, você poderia ter uma função que transfere Ether de volta para o msg.sender se eles pagarem à mais por um item:
*/

uint itemFee = 0.001 ether;
msg.sender.transfer(msg.value - itemFee);

/**
Ou dentro de um contrato com um comprador e um vendedor, você poderia salvar o endereço do 
vendedor em memória permanente (storage), então quando alguém comprar o item deste vendedor, 
transfira para o mesmo o custo que o comprador pagou: seller.transfer(msg.value).

Estes são alguns exemplos que fazem a programação em Ethereum tão legal - 
você pode ter marketplaces decentralizados como este que não são controlados por ninguém.

*/






