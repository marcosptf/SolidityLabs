/**
Números Aleatórios

Ótimo! Agora vamos entender a lógica da batalha.
Todo bom jogo requer algum nível de aleatoriedade. Então como geramos números aleatórios em Solidity?
A resposta certa é, você não consegue. Bem, ao menos não de forma segura.

Vejamos por quê.
Gerando números aleatórios via keccak256
A melhor forma de aleatoriedade que temos em Solidity é a função de hash keccak256
Podemos fazer algo como a seguir para gerar um número aleatório:
*/

// Gera um número aleatório entre 1 e 100:
uint randNonce = 0;
uint random = uint(keccak256(now, msg.sender, randNonce)) % 100;
randNonce++;
uint random2 = uint(keccak256(now, msg.sender, randNonce)) % 100;

/**
Que seria obter o timestamp de now, e msg.sender, e incrementar um nonce 
(um número que é usado somente uma vez, então nós não iremos rodar a mesma
função de hash com os mesmos parâmetros duas vezes).

O mesmo iria então usar keccak para converter os valores de entrada para o hash aleatório, 
converter este hash para um uint, e então usar % 100 para obter somente os últimos 2 dígitos, 
nos dando uma função totalmente aleatória entre 0 à 99.
Este método é vulnerável a um ataque por um nó desonesto

Em Ethereum, quando você chama uma função em um contrato, você transmite o mesmo para um
nó ou muitos nós na rede como uma transação. 
Os nós na rede então coletam um monte de transações, tentam ser o primeiro a resolver 
um problema matemático e computacionalmente intensivo como uma "Proof of Work" (Prova de Trabalho), 
e então publicam este grupo de transações junto com a Proof Of Work (PoW) como um bloco para o resto da rede da rede.

Uma vez que o nó resolveu o PoW, os outros nós param de tentar resolver o PoW, 
verificam que a lista de transações do outro nó são válidas, e então aceitam o bloco e 
começam a tentar resolver o próximo bloco.

Isto torna a nossa função de números aleatórios explorável.
Digamos que temos um contrato de jogo de moeda - se o resultado for "cara" você dobra
o seu dinheiro, "coroa" você perde tudo. 
Digamos que utilizamos a função geradora de aleatórios acima para determinar 
"cara" ou "coroa". (random >= 50) é "cara", random < 50 é "coroa").

Se estivéssemos rodando um nó da rede, eu poderia publicar uma transação 
somente para o meu nó e não compartilhá-la. 
Eu poderia então rodar a função do jogo da moeda para ver se eu ganho - e se eu perco. 
Eu poderia fazer isso indefinidamente até eu finalmente ganhar o jogo da moeda e resolver o próximo bloco, e lucrar.
Então como podemos gerar número aleatórios de forma segura em Ethereum?

Por que todos os conteúdos da blockchain são visíveis para todos os participantes, 
este é um problema difícil, e sua solução esta além do escopo deste tutorial. 
Você pode ler esta pergunta no StackOverflow para ter algumas ideias. 
Uma ideia seria usar um oracle (oráculo) para acessar uma função de número aleatório de fora da blockchain do Ethereum.

Claro que uma vez que milhares de nós na rede Ethereum estão competindo para resolver o próximo bloco,
minhas chances de resolver o próximo bloco são extremamente baixas. 
E iria me tomar um monte de tempo ou recursos computacionais para tornar esse exploit lucrativo - 
mas se as recompensas fossem altas o suficiente (algo do tipo ganhar uma aposta de $100,000,000 no jogo da moeda), 
então valeria a pena pra mim fazer este ataque.

Então enquanto esta geração de número aleatório NÃO é segura no Ethereum, 
em prática ao menos que a nossa função de número aleatório tenha um monte de dinheiro em jogo, 
os usuários do jogo não usaram recursos o suficiente para atacá-la.

E por que estamos construindo um jogo simples com o propósito de demonstração neste tutorial e
por que não há real dinheiro envolvido, vamos aceitar esse tradeoff de usar um gerador de 
números aleatórios que é simples de implementar, sabendo que não é totalmente seguro.

Em lições futuras, talvez podemos cobrir os oracles (uma forma segura de obter dados fora da rede do Ethereum)
para gerar números aleatórios seguros fora da blockchain.

*/


