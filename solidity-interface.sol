/**
Interagindo com outros contratos

Para que o nosso contrato converse com outro contrato na blockchain que não é nosso, primeiro temos que definir uma interface.
Vamos ver um simples exemplo. Digamos que existe um contrato na blockchain que se parece com isto:
*/

contract LuckyNumber {
  mapping(address => uint) numbers;

  function setNum(uint _num) public {
    numbers[msg.sender] = _num;
  }

  function getNum(address _myAddress) public view returns (uint) {
    return numbers[_myAddress];
  }
}

/**
Este seria um simples contrato onde qualquer um pode guardar um número da sorte, e esse número seria associado ao seu endereço no Ethereum. Então qualquer um pode olhar o número desta pessoa somente passando o endereço dessa pessoa.
Agora digamos que nós temos um contrato externo que quer ler o dado deste contrato usando a função getNum.
Primeiro nós gostaríamos de definir uma interface para o contrato LuckyNumber:
*/

contract NumberInterface {
  function getNum(address _myAddress) public view returns (uint);
}

/**
Perceba que isto parece com a definição de um contrato, com poucas diferenças. Primeiro, declaramos somente as funções que queremos interagir - neste caso getNum - e nós não mencionamos qualquer outra função ou variáveis de estado.
Segundo, nós não definimos os corpos das funções. Ao invés dos "braces" ({ e }), nós simplesmente terminamos declaração da função com um ponto-e-vírgula (;).
Então isso se parece com um esqueleto de contrato. Isto é como o compilador sabe sobre uma interface.
Ao incluir esta interface no código da nossa aplicação distribuída (dapp) nosso contrato sabe como as funções do outro contrato se parecem, e como executá-las, e qual tipo de resposta esperar.
Iremos na verdade executar funções em um outro contrato em nossa próxima lição, mas por enquanto vamos declarar as nossas interfaces para o contrato do CryptoKitties.
*/


