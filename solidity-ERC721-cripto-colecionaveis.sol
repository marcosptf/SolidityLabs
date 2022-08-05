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



Capítulo 2: Padrão ERC721, Múltipla Herança

Vamos dar uma olhada no padrão ERC721:

contract ERC721 {
  event Transfer(address indexed _from, address indexed _to, uint256 _tokenId);
  event Approval(address indexed _owner, address indexed _approved, uint256 _tokenId);

  function balanceOf(address _owner) public view returns (uint256 _balance);
  function ownerOf(uint256 _tokenId) public view returns (address _owner);
  function transfer(address _to, uint256 _tokenId) public;
  function approve(address _to, uint256 _tokenId) public;
  function takeOwnership(uint256 _tokenId) public;
}

Esta é a lista de métodos que precisamos implementar, que iremos fazer em partes nos próximos capítulos.

Isso parece um monte, mas sinta-se sobrecarregado! Estamos aqui para guiar você.

    Nota: O padrão ERC721 é atualmente um rascunho, e ainda não há oficialmente um acordo de implementação. Neste tutorial usamos a versão atual da biblioteca do OpenZeppelin, mas é possível que mude no futuro antes do lançamento oficial. Então considere esta uma possível implementação, mas não considere uma versão oficial dos tokens ERC721.

Implementando um contrato de token

Quando implementar um contrato de token, a primeira coisa que fazemos é copiar a interface para o nosso próprio arquivo Solidity e importá-lo. import "./erc721.sol";. Então nós teremos o nosso contrato herdando-o, e iremos sobrepor cada método com a definição da função.

Mas espere – ZombieOwnership já esta herdando do ZombieAttack – como pode também herdar do ERC721?

Para a nossa sorte em Solidity, seu contrato pode herdar de múltiplos contrato conforme segue:

contract SatoshiNakamoto is NickSzabo, HalFinney {
  // Meu deus, os segredos do universo foram revelados!
}

Como você pode ver, quando usando a múltipla herança, você pode separar os múltiplos contrato que você estar herdando com um vírgula, ,. Neste caso, nosso contrato esta herdando de NickSzabo e HalFinney.



Capítulo 3: balanceOf & ownerOf

Ótimo, vamos mergulhar na implementação do ERC721!

Já saímos na frente e copiamos uma casca vazia de todos as funções que você irá implementar nesta lição.

Neste capítulos, iremos implementar os dois primeiros métodos: balanceOf e ownerOf.
balanceOf

  function balanceOf(address _owner) public view returns (uint256 _balance);

Esta função simplesmente recebe um address, e retorna quantos tokens que o address tem.

Em nosso caso, nossos "tokens" são Zumbis. Você lembra onde em nossa DApp nós guardamos quantos zumbis um dono tem?
ownerOf

  function ownerOf(uint256 _tokenId) public view returns (address _owner);

Esta função recebe um token ID (em nosso caso, um ID Zumbi), e retorna o address da pessoa que o possui.

Novamente, esta é muito fácil para implementar-mos, uma vez que já temos um mapping (mapeamento) em nossa DApp que guarda esta informação. Podemos implementar esta função em uma linha, só uma declaração de return.

    Nota: Lembre, uint256 é equivalente à uint. Estávamos usando uint em nosso código até agora, mas nós usamos uint256 aqui por que copiamos e colamos da especificação.

Capítulo 4: Refatorando

Opa! Nós introduzimos um erro em nosso código que vai impedir de compilar. Você percebeu?

No capítulo anterior nós definimos a função chamada de ownerOf. Mas se você lembrar da Lição 4, nós também criamos um modifier (modificador) com o mesmo nome, ownerOf, em zombiefeeding.sol.

Se você tentar compilar este código, o compilador irá retornar um erro dizendo que você não pode ter um modificador e uma função com o mesmo nome.

Então devemos somente mudar o nome da função em ZombieOwnership para qualquer coisa?

Não, não podemos fazer isso!!! Lembre-se, estamos usando o token padrão ERC721, que significa que outros contratos irão esperar que o nosso contrato tenha as funções com os nomes definidos exatamente. Isto é o que faz estes padrões úteis – se outro contrato sabe que nosso contrato é compatível com ERC721, este pode simplesmente conversar conosco sem a necessidade de saber qualquer coisa sobre as nossas decisões de implementação interna.

Então significa que iremos ter que refatorar o nosso código da Lição 4 para mudar o nome do modifier para outra coisa.


Capítulo 5: ERC721: Lógica de Transferência

Ótimo, consertamos o conflito!

Agora iremos continuar nossa implementação do ERC721 olhando na transferência de propriedade de uma pessoa para outra.

Note que a especificação ERC721 tem duas maneiras diferentes de transferir tokens:

function transfer(address _to, uint256 _tokenId) public;
function approve(address _to, uint256 _tokenId) public;
function takeOwnership(uint256 _tokenId) public;

    A primeira forma é o dono do token chamar transfer com o address que ele quer transferir, e o _tokenId do token que ele quer transferir.

    A segunda forma é o dono do token primeiro chama approve, e envia a mesma informação acima. O contrato então guarda quem esta aprovado para pegar o token, normalmente um mapping (uint256 => address). Então quando alguém chamar takeOwnership, o contrato checa se o msg.sender esta aprovado pelo dono para pegar o token, se estiver transfere o token para ele.

Se você notar, ambos transfer e takeOwnership irão conter a mesma lógica de transferência, em ordem inversa. (Em um caso o remetente do token chama a função; na outra o destinatário do token a chama).

Então faz sentido abstrairmos esta lógica em uma função privada, _transfer, que então será chamada por ambas funções. Desta maneira não precisamos repetir o mesmo código duas vezes.



Capítulo 7: ERC721: Approve

Agora, vamos implementar approve.

Lembre-se, com approve / takeOwnership, a transferência acontece em 2 passos:

    Você, o dono, chama approve e informa o address do novo dono, e o _tokenId que você quer ele pegue

    O novo dono chama takeOwnership com o _tokenId, o contrato verifica para certeza que ele já foi aprovado, e então transfer a ele o token.

Por que isto acontece em 2 chamadas de funções, precisamos de uma estrutura de dados para guardar quem esta sendo aprovado para que entre as chamadas das funções.


Capítulo 8: ERC721: takeOwnership

Ótimo, agora vamos terminar a nossa implementação do ERC721 com a última função! (Não se preocupe, ainda há a mais para cobrir na Lição 5 após isso 😉)

A função final, takeOwnership, deve simplesmente verificar o msg.sender para ter certeza que foi aprovado para pegar este token / zumbi, e chamar _transfer se ok.



Capítulo 9: Prevenindo Overflows

Parabéns, isto conclui a nossa implementação do ERC721!

Isso não foi tão difícil, foi? Um monte destas coisas em Ethereum soa complicado quando você ouve as pessoas falando, então a melhor maneira de entender é na verdade ir implementar você mesmo.

Tenha em mente que isto é o mínimo de implementação. Existem recursos extras que queremos adicionar a nossa implementação, como algumas checagem extras para ter certeza que os usuários acidentalmente não transfiram os zumbis para o endereço 0 (que é conhecido como "queimando" um token – basicamente enviado para um endereço que ninguém tem a chave privada, essencialmente tornando-o irrecuperável). Ou colocar uma lógica básica de um leilão na própria DApp (Você consegue pensar em algumas maneiras de implementar-mos isto?)

Mas queremos manter esta lição manejável, então fomos com a lógica de implementação mais básica. Se você quiser ver um exemplo de uma implementação mais à fundo, você pode dar uma olhada no contrato ERC721 do OpenZeppelin após este tutorial.
Melhorias de segurança no contrato: Overflows e Underflows

Vamos olhar para um dos principais recursos de segurança que você deve estar ciente ao escrever smart contracts: Prevenção de overflows e underflows.

O que é um overflow (transbordamento) ?

Digamos que você tem um uint8, que pode ter somente 8 bits. Isso significa que o maior número que podemos guardar é o binário 11111111 (ou um decimal, 2^8 - 1 = 255).

De uma olhada no seguinte código. Qual é o number igual no final?

uint8 number = 255;
number++;

Neste caso, nós causamos um "overflow" – então o number é contraintuitivamente igual a 0 mesmo após nós aumentarmos. (Se você adicionar 1 para um binário 11111111, ele restabelece de volta para 00000000, como um relógio indo de 23:59 para 00:00).

Um "underflow" é parecido, onde se você subtrair 1 de um uint8 que é igual a 0, este agora é igual à 255 (porque uints são sem sinal, e não podem ser negativos).

Enquanto não usamos uint8 aqui, parece improvável que o uint256 irá transbordar quando incrementarmos em 1 toda vez (2^256 é realmente um número grande), ainda é bom colocar proteções em nossos contratos então nossa DApp nunca terá um comportamento indesejável no futuro.
Usando SafeMath

Para prevenir isto, OpenZeppelin criou uma library (biblioteca) chamada SafeMath que previne estes erros por padrão.

Mas antes de disso... O que é uma biblioteca?

Uma biblioteca é tipo especial de contrato em Solidity. Uma das coisas que são úteis para anexar funções em tipos de dados nativos.

Por exemplo, como a biblioteca SafeMath, podemos usar a sintaxe using SafeMath for uint256. A biblioteca SafeMath tem 4 funções – add (adição), sub (subtração), mul (multiplicação) e div (divisão). E como nós podemos acessar essas funções de uint256 conforme segue:

using SafeMath for uint256;

uint256 a = 5;
uint256 b = a.add(3); // 5 + 3 = 8
uint256 c = a.mul(2); // 5 * 2 = 10

Vamos ver o que estas funções fazem no próximo capítulo, mas por agora vamos adicionar a biblioteca SafeMath em nosso contrato.


Capítulo 10: SafeMath Parte 2

Vamos dar uma olhada no código por trás da SafeMath:

library SafeMath {

  function mul(uint256 a, uint256 b) internal pure returns (uint256) {
    if (a == 0) {
      return 0;
    }
    uint256 c = a * b;
    assert(c / a == b);
    return c;
  }

  function div(uint256 a, uint256 b) internal pure returns (uint256) {
    // assert(b > 0); // Solidity automaticamente lança uma exceção quando dividindo por 0
    uint256 c = a / b;
    // assert(a == b * c + a % b); // Não há nenhum caso que isso não contenha
    return c;
  }

  function sub(uint256 a, uint256 b) internal pure returns (uint256) {
    assert(b <= a);
    return a - b;
  }

  function add(uint256 a, uint256 b) internal pure returns (uint256) {
    uint256 c = a + b;
    assert(c >= a);
    return c;
  }
}

Primeiro nós temos a palavra reservada library (biblioteca) – bibliotecas são similares a contracts mas com poucas diferenças. Para nosso propósito, bibliotecas permitem-nos o uso da palavra reservada using, que automaticamente acrescenta todos os métodos da biblioteca em outro tipo de dado:

using SafeMath for uint;
// agora podemos usar estes métodos em qualquer uint
uint test = 2;
test = test.mul(3); // test agora é igual a 6
test = test.add(5); // test agora é igual a 11

Note que as funções mul e add cada uma requer 2 argumentos, mas quando nós declaramos using SafeMath for uint, o uint que chamamos a função (test) é automaticamente passado como o primeiro argumento.

Vamos dar uma olhada no código por de trás de add para ver o que SafeMath faz:

function add(uint256 a, uint256 b) internal pure returns (uint256) {
  uint256 c = a + b;
  assert(c >= a);
  return c;
}

Basicamente add só adiciona 2 uints como +, mas este também contem uma declaração assert para ter certeza que a soma é maior do que a. Isto nos protege contra overflows.

assert é similar o require, onde este irá lançar um erro se falso. A diferença entre assert e require é que require irá reembolsar o usuário o resto do seu gás quando a função falhar, enquanto que assert não irá. Então a maior parte do tempo você quer usar o require em seu código; assert é tipicamente usando quando algo de terrível houve com o código (como um uint transbordar).

Então, simplesmente use, As funções add, sub, mul e div da SafeMath que fazem as 4 operações matemáticas básicas, mas lançam um erro se um overflow ou underflow ocorrer.
Usando SafeMath em nosso código.

Para prevenir overflow and underflow, podemos procurar por lugares em nosso código onde usamos +, -, *, or /, e substituí-los por add, sub, mul e div.

Ex: Ao invés de fazer:

myUint++;

Nós deveríamos fazer:
myUint = myUint.add(1);


Capítulo 11: SafeMath Parte 3

Ótimo, agora nossa implementação ERC721 esta segura de overflows & underflows!

Voltando ao código que escrevemos em lições anteriores, existem uns poucos outros lugares onde o nosso código poderia estar vulnerável a overflows ou underflows.

Por exemplo, em ZombieAttack nós temos:

myZombie.winCount++;
myZombie.level++;
enemyZombie.lossCount++;

Deveríamos prevenir overflows aqui também só para estar seguro. (É uma boa ideia em geral só usar SafeMath ao invés de usar operações matemáticas básicas. Talvez em versões futuras de Solidity estes estejam implementados por padrão, mas por agora nós temos que ter precaução extra com a segurança em nosso código).

Porém temos um leve problema – winCount e lossCount são uint16, e level é um uint32. Então se nós usarmos o método add da SafeMath com estes argumentos, este não nos protegerão de overflows uma vez que isto irá converter estes tipos para uint256:

function add(uint256 a, uint256 b) internal pure returns (uint256) {
  uint256 c = a + b;
  assert(c >= a);
  return c;
}

// Se nós chamarmos `.add` em um `uint8`, este será convertido para um `uint256`.
// Então este não terá um overflow em 2^8, uma vez que um valor 256 é valido para um `uint256`.

Isto significa que teremos que implementar 2 bibliotecas a mais para prevenir overflows/underflows com os nossos uint16 e uint32. Iremos chamá-las de SafeMath16 e SafeMath32.

O código será exatamente o mesmo que SafeMath, exceto todas instâncias de uint256 serão substituídas com uint32 ou uint16.

Nós saímos na frente e implementamos o código pra você – vá em frente e veja em safemath.sol para ver o código.

Agora precisamos implementar em ZombieFactory.


Capítulo 12: SafeMath Parte 4

Ótimo, agora podemos implementar SafeMath em todos os tipos de uint que usamos em nossa DApp!

Vamos consertar todos esse potências problemas em ZombieAttack. (Ainda há um zombies[_zombieId].level++; que precisa ser consertado em ZombieHelper, mas nós cuidamos deste pra você então nós não precisamos de um capítulo extra 😉).



Capítulo 13: Comentários

O código Solidity para o nosso jogo zumbi finalmente terminou!

Nas próximas lições, iremos olhar em como implantar o código no Ethereum, e como interagir com ele usando a Web3.js.

Mas uma coisa final antes de deixá-lo ir na Lição 5: Vamos falar sobre comentando o seu código.
Sintaxe para comentários

Comentando um código em Solidity e como em JavaScript. Você já viu alguns exemplos de uma simples linha de comentário nas lições do CryptoZombies.

// Este é um comentário de uma linha. É tipo uma nota própria (ou para outros)

Somente adicione duas // em qualquer lugar e você esta comentando. É tão fácil que você deveria fazer toda hora.

Mas eu entendo você – algumas vezes uma linha não é o suficiente. Você nasceu um escritor, afinal!

Assim, nós também temos comentários multi-linhas:

contract CryptoZombies {
  /* Este é um comentário multi-linha. Eu gostaria de agradecer à todos vocês
    que usaram o seu tempo para tentar este curso de programação.
    Eu sei que é grátis para todos vocês, e continuará grátis
    para sempre, mas ainda colocamos nossos corações e almas para fazer
    isto tão bom quanto o possível.

    Saiba que este ainda é o início do desenvolvimento do Blockchain.
    Chegamos muito longe, mas ainda existem várias maneiras de fazer esta
    comunidade melhor. Se cometemos um erro em algum lugar, você pode
    nos ajudar e abrir um pull request aqui:
    https://github.com/loomnetwork/cryptozombie-lessons

    Ou se você tiver algumas ideias, comentários, ou só dizer um Olá –
    envie pela nossa comunidade Telegram em https://t.me/loomnetworkdev
  */
}

Em particular, é uma boa prática comentar o seu código para explicar o comportamento esperado de cada função em seu contrato. Desta maneira outro desenvolvedor (ou você, após seis meses de hiato de um projeto!) pode rapidamente ler e entender em alto nível o que seu código faz sem ter que ler o próprio código.

O padrão na comunidade Solidity é usar o formato chamado natspec, que se parece com isso:

/// @title Um contrato para operações básicas de matemática
/// @author H4XF13LD MORRIS 💯💯😎💯💯
/// @notice No momento, este contrato somente adiciona uma função de multiplicação
contract Math {
  /// @notice Multiplica dois números juntos
  /// @param x o primeiro uint.
  /// @param y o segundo uint.
  /// @return z o produto de (x * y)
  /// @dev Esta função não atualmente não checa por overflows
  function multiply(uint x, uint y) returns (uint z) {
    // Este é somente um comentário normal, e não sera lido pelo natspec
    z = x * y;
  }
}

@title e @author são simples.

@notice explica para o usuário o que o contrato / função faz. @dev é para explicar detalhes extras para os desenvolvedores.

@param e @return são para descrever o que cada parâmetro e valor de retorno da função fazem.

Note que você não precisa ter que usar todas essas tags para cada função - todas as tags são opcionais. Mas pelo menos, deixa uma nota com @dev explicando o que cada função faz.





