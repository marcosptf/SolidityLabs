Capítulo 1: Tokens no Ethereum

Vamos falar sobre tokens.

Se você esteve acompanhando o Ethereum por período de tempo, você provavelmente ouviu pessoas falando sobre tokens - especificamente ERC20 tokens.

Um token no Ethereum é basicamente um smart contract (contrato inteligente) que segue algumas regras comuns — isto é, ele implementa um conjunto padrão de funções que todos os outros contratos de token compartilham, como o transfer(address _to, uint256 _value) e balanceOf(address _owner).

Internamente o smart contract normalmente tem um mapeamento, mapping(address => uint256) balances, que mantêm o registro de quanto em saldo cada endereço tem.

Então basicamente um token é somente contrato que mantem o registro de quem é o dono desse token, e algumas funções, então esses usuários podem transferir seus tokens para outros endereços.
Por que isso importa?

Uma vez que todo token ERC20 compartilha o mesmo conjunto de funções com os mesmos nomes, todos eles podem interagir da mesma maneira.

Isto significa se você construir uma aplicação que é capaz de interagir com um token ERC20, ela será capaz de interagir com qualquer token ERC20. Deste jeito mais tokens podem facilmente serem adicionados a sua aplicação no futuro sem a necessidade the qualquer código customizado. Você pode simples plugar um novo contrato de token.

Um exemplo disso poderia ser uma exchange. Quando uma exchange adiciona um novo token ERC20, na verdade ela só precisa adicionar um outro smart contract para funcionar. Usuários podem dizer para este contrato enviar tokens para o endereço da carteira da exchange, e a exchange pode dizer ao contrato para enviar os tokens de volta para os usuários quando eles requisitarem um saque.

A exchange só precisa implementar esta lógica da transferência uma vez, então quando quiser adicionar um novo token ERC20, é simplesmente um problema de adicionar um novo endereço de contrato no banco de dados.
Outros padrões de token

Tokens ERC20 são realmente legais para tokens que agem como moedas. Mas eles não são particularmente úteis para representar zumbis em nosso jogo de zumbi.

Primeiro, zumbis não são divisíveis como moedas — Eu posso enviar para você 0.237 ETH, mas transferir pra você 0.237 de um zumbi realmente não faz sentido algum.

Segundo, todos os zumbis não são criados iguais. Seu zumbi Nível 2 "Steve" é totalmente diferente do meu zumbi Nível 732 "H4XF13LD MORRIS 💯💯😎💯💯". (Nem mesmo perto, Steve).

Há um outro padrão de token que se encaixa bem melhor para cripto-colecionáveis como CryptoZombies – e eles chamados de tokens ERC721.

Tokens ERC721_ não são intercambiáveis uma vez que cada um é suposto para ser único, e não divisíveis. Você somente pode trocá-los em unidades inteiras, e cada um tem um ID único. Então esses se encaixam perfeitamente para fazer nossos zumbis trocáveis.

    Note que usando um padrão como ERC721 tem o benefício que não precisamos ter que implementar uma lógica de leilão ou garantia dentro do nosso contrato que determina como os jogadores devem trocar / vender nossos zumbis. Se obedecer-mos a especificação, qualquer um poderia criar uma plataforma de troca para ativos cripto-colecionáveis ERC721, e nossos zumbis ERC721 seriam utilizáveis nesta plataforma. Então os benefícios são claros de usar um padrão de token ao invés de criar a sua própria lógica de trocas.





