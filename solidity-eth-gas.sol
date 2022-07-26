/**
Gas

Ótimo! Agora sabemos como atualizar porções importantes da DApp enquanto prevenimos que outros usuários estraguem com nossos contratos.

Vamos ver outra maneira que Solidity é um tanto diferente de outras linguagens de programação:
Gas — o combustível utilizado por DApps Ethereum

Em Solidity, seus usuários tem que pagar toda vez que executam uma função em sua DApp usando uma moeda chamada gas. 
Usuários compram gas com Ether (a moeda no Ethereum), então os seus usuários precisam gastar ETH para executar funções em sua DApp.
Quanto gas é preciso para executar uma função depende o quão complexo é a lógica desta função. 
Cada operação individual tem um custo em gas baseado mais ou menos em quanto recursos computacionais 
serão necessários para realizar essa operação (exemplo: escrever em storage é muito mais caro do que adicionar dois inteiros). 
O total de custo em gas da sua função é soma de todos os custo de todas as operações de forma individuais.
E porque executar funções custam dinheiro real para os seus usuários, otimização do código é muito 
mais importante em Ethereum do que em qualquer outra linguagem de programação. 
Se o seu código é desleixado, seus usuários terão que pagar muito mais para executar suas funções - 
e isto pode adicionar milhões de dólares em custos desnecessários através de milhares de usuários.

Por que o gas é necessário?

Ethereum é como um grande, lento, mas extremamente seguro computador.
Quando você executa uma função, cada um dos nós na rede precisa rodar esta mesma função e verificar suas saídas -
milhares de nos verificando cada execução de cada função é o que faz do Ethereum decentralizado, 
e seus dados imutáveis e resistentes a censura.
Os criadores do Ethereum queriam ter certeza que ninguém poderia entupir a rede com laços infinitos, 
ou estragar todos os recursos da rede com computações realmente intensivas. 
Então eles fizeram com que as transações não fossem grátis, e os usuários tem que pagar pelo
tempo de computação como também pela guarda dos dados

Nota: Isto não é necessariamente verdade em sidechains, como a que os autores do CryptoZombies 
estão construindo na Loom Network. 
E provavelmente nunca irá fazer sentido rodar um jogo como World of Warcraft diretamente 
na rede mainnet do Ethereum - o custo em gas seria proibitivamente caro. Mas este pode rodar 
em uma sidechain com um algorítimo de consenso diferente. 
Iremos falar mais sobre os tipos de DApps que você poderia implantar em sidechains vs a mainnet do Ethereum em futuras lições.

Empacotamento da estrutura para economizar gas
Na Lição 1, nós mencionamos que existem outros tipos de uints: uint8, uint16, uint32, etc.
Normalmente não há benefício algum em usar estes subtipos porque Solidity
reserva 256 bits de espaço independente do tamanho do uint.
Por exemplo, usar uint8 ao invés de uint (uint256) não irá economizar gas algum.
Mas há uma exceção para isto: dentro das structs.
Se você tiver múltiplas uints dentro de uma struct, usando um tamanho menor de 
uint quando possível irá permitir o Solidity de empacotar essas variáveis juntas para usar menos espaço. 

Por exemplo:
*/

struct NormalStruct {
  uint a;
  uint b;
  uint c;
}

struct MiniMe {
  uint32 a;
  uint32 b;
  uint c;
}

// `mini` irá custar menos gas que `normal` porque usar o empacotamento
NormalStruct normal = NormalStruct(10, 20, 30);
MiniMe mini = MiniMe(10, 20, 30);

/**
Por essa razão, dentro de uma estrutura você irá querer usar o menor
subtipo de integer que você puder. 
Você também quer juntar tipos de dados idênticos 
(exemplo: colando um perto do outro dentro da estrutura) então Solidity pode 
minimizar o espaço requerido para guardar a estrutura. 
Por exemplo, a estrutura com campos :
*/

uint c; 
uint32 a; 
uint32 b; 

/**
irá custar menos gas que a estrutura com os campos:
*/

uint32 a; 
uint c; 
uint32 b; 

/**
porque o os campos 
*/
uint32 

/**
estão agrupados.
*/

