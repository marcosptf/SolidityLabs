/**

Mapeamentos e Endereços (Mappings / Addresses)

Vamos fazer o nosso jogo multi-jogador dando aos zumbis em nosso banco de dados um proprietário.

Para fazer isto, nós vamos precisar de 2 novos tipos de dados: mapping e address.
Endereços

O blockchain do Ethereum é feito de accounts (contas), que você pode imaginar como contas de banco. Um conta tem um saldo Ether (a moeda usada no blockchain do Ethereum), e você pode enviar e receber pagamentos de outras contas, como a sua conta de banco que você pode enviar uma transferência (DOC/TED) em dinheiro para outras contas.

Cada conta tem um address (endereço), que você pode imaginar como o número da conta bancária. Esse número é um identificador único que indica a conta, e se parece com isto:

0x0cE446255506E92DF41614C46F1d6df9Cc969183

(Este endereço pertence ao time do CryptoZombies. Se você esta gostando do CryptoZombies, você pode nos enviar algum Ether! 😉)

Nós vamos entrar nos detalhes minuciosos dos endereços em futuras lições, por enquanto você só precisa entender que um endereço é propriedade de um usuário específico (ou um smart contract).

Então nós podemos usar este ID único como propriedade dos nossos zumbis. Quando um usuário interagir com a nossa aplicação e criar um novo zumbi, nós iremos definir a propriedade desses zumbis para o endereço de Ethereum que chamou a função.
Mapeamentos

Na Lição 1 nós vimos as structs (estruturas) e arrays (listas). Mapeamentos são uma outra forma de guardar dados organizados em Solidity.
Um mapeamento é essencialmente um armazenamento chave-valor para guardar e buscar dados. No primeiro exemplo, a chave é o address (endereço) e o valor é um uint, e no segundo exemplo a chave é um uint e o valor é uma string.

Definindo um mapping (mapeamento) se parece com isto:
*/

// Para uma aplicação financeira, guardando um uint que guarda o saldo da conta do usuário
mapping (address => uint) public accountBalance;

// Ou pode ser usado para guardar nomes de usuários baseados no userId (id do usuário)
mapping (uint => string) userIdToName;














