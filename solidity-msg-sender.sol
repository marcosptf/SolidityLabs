/**

Msg.sender

Agora temos nossos mapeamentos para guardar os registros de quem é dono de cada zumbi, queremos atualizar o método _createZombie para usá-los.

E para fazer isto, precisamos usar algo chamado msg.sender.
msg.sender

Em Solidity, existem certas variáveis globais que estão disponíveis em todas funções. Umas dessas é a msg.sender, que refere-se ao address (endereço) da pessoa (ou smart contract) que chamou a função em atual.

    Nota: Em Solidity, uma função sempre precisa iniciar como uma chamada externa. Um contrato irá somente descansar no blockchain sem fazer nada até que alguém chame alguma das suas funções. Então sempre haverá um msg.sender.

Segue um exemplo de uso do msg.sender e atualização de um mapping:
*/

mapping (address => uint) favoriteNumber;

function setMyNumber(uint _myNumber) public {
  // Atualiza o nosso mapeamento `favoriteNumber` para guardar o `_myNumber` utilizando `msg.sender`
  favoriteNumber[msg.sender] = _myNumber;
  // ^ A sintaxe para guardar o dado em um mapeamento é parecida com a dos arrays
}

function whatIsMyNumber() public view returns (uint) {
  // Recupera o valor guardado em um endereço de quem transmitiu (sender)
  // Será `0` se o transmissor (sender) não chamou a função `setMyNumber` ainda
  return favoriteNumber[msg.sender];
}

/**
Neste exemplo trivial, qualquer um pode chamar a função setMyNumber e guardar um uint em nosso contrato, que será amarrado ao seu endereço. Então quando eles chamarem a função whatIsMyNumber, seria retornado o uint que eles guardaram.
Usar o msg.sender fornece à você a segurança do blockchain do Ethereum - a única maneira de alguém modificar o dado de outra pessoas seria roubando a chave privada associada ao endereço no Ethereum.
*/

