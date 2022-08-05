Capítulo 5: Zumbis Lutando!

Agora que temos uma fonte de alguma aleatoriedade em nosso contrato, podemos usá-la em nossa batalha zumbi para calcular os resultados.

Nossas batalhas zumbis irão funcionar da seguinte maneira:

    Você escolhe um de seus zumbis, e escolhe um zumbi do oponente para atacar.
    Se você é o zumbi atacante, você terá 70% de chance de vencer. O zumbi defensor terá 30% de chande de vencer.
    Todos zumbis (atacante e defensores) terão um contador de vitórias chamado winCount e um contador de derrotas chamado lossCount que irá incrementar dependendo do resultado da batalha.
    Se o zumbi atacante vence, este aumenta um nível e cria um novo zumbi.
    Se o mesmo perde, nada acontece (exceto o incremento do lossCount).
    Se vence ou perde, o tempo de resfriamento do zumbi atacante será ativado.

É um monte de lógica para implementar, então iremos fazer por partes nos próximos capítulos.
Vamos testar

    Dando ao nosso contrato uma variável uint chamada attackVictoryProbability e atribuindo o valor igual a 70.

    Crie uma função chamada attack. Esta terá dois parâmetros: _zombieId(um uint) e _targetId (também um uint). Esta será uma função do tipo external.

Deixe o corpo da função vazio por enquanto.


Capítulo 6: Refatorando Lógicas

Qualquer pessoa que chamar nossa função attack - queremos ter certeza que o usuário seja o dono do zumbi que esta usando para atacar. Isto seria um problema de segurança se você pudesse atacar com o zumbi de outra pessoa!

Você pode imaginar como podemos adicionar uma verificação para ver se a pessoa que esta chamando a função é a dona do _zombieId que esta passando como parâmetro?

Pense um pouco, e veja se você vem com alguma resposta em mente.

Espere um momento... Lembre de alguns códigos de lições anteriores...

Resposta abaixo, não continue até você ter pensado um pouco.
A Resposta

Fizemos esta mesma checagem várias vezes nas lições anteriores. Em changeName(), changeDna(), e feedAndMultiply(), nós usamos a seguinte verificação:

require(msg.sender == zombieToOwner[_zombieId]);

Esta é mesma lógica que precisamos para nossa função attack. Uma vez que usamos a mesma lógica várias vezes, vamos mover esse código para uma função modificadora (modifier) para limpar o nosso código e evitar repetições de código.
Vamos testar

Estamos de volta a zombiefeeding.sol, uma vez que este foi o primeiro lugar que usamos a lógica. Vamos refatorá-lo em seu próprio modificador (modifier).

    Crie um modifier chamado ownerOf. Este terá 1 argumento, _zombieId (um uint).

    O corpo da função modificadora deverá usar o require para o msg.sender ser igual a zombieToOwner[_zombieId], então continue a função. Você pode usar como referência o zombiehelper.sol se você não lembrar da sintaxe do modifier.

    Mude a definição da função de feedAndMultiply para que use o modificador ownerOf.

    Agora que estamos usando o modifier, você pode remover a linha require(msg.sender == zombieToOwner[_zombieId]);.



Capítulo 8: De Volta ao Ataque!

Chega de refatoração - de volta ao zombieattack.sol.

Vamos continuar a definição da nossa função attack, agora que nós temos a função modificadora ownerOf para usar.
Vamos testar

    Adicione a função modificadora ownerOf em attack para ter certeza que o chamador é o dono do _zombieId.

    A primeira coisa que a nossa função deve fazer é obter um ponteiro do tipo storage para ambos os zumbis e então podemos interagir mais facilmente com eles:

    a. Declare um Zombie storage chamado myZombie, e atribua igual a zombies[_zombieId].

    b. Declare um Zombie storage chamado enemyZombie, e atribua igual a zombies[_targetId].

    Vamos usar o número aleatório entre 0 e 99 para determinar o resultado da nossa batalha. Então declare um uint chamado rand, e atribua o valor igual ao resultado da função randMod com 100 como argumento.


Capítulo 9: Zumbi Vence e Perde

Para o nosso jogo zumbi, queremos manter o registro de quantas batalhas os nossos zumbis ganharam e perderam. Desta maneira podemos ter um quadro com os líderes no jogo.

Poderíamos guardar esse dado de diferentes maneiras em nossa DApp - como mapeamentos usando mapping, em uma struct, ou na própria estrutura Zombie.

Cada maneira tem as suas vantagens e desvantagens dependendo de como iremos interagir com o dado. Neste tutorial, vamos guardar os status em nossa estrutura Zombie por simplicidade, e chamá-las winCount e lossCount.

Então vamos voltar para zombiefactory.sol, e adicionar estas propriedades para a nossa estrutura Zombie.
Vamos testar

    Modifique a nossa estrutura Zombie para ter duas propriedades a mais:

    a. winCount, com uint16

    b. lossCount, também com uint16

        Nota: Lembre-se, uma vez que podemos empacotar uints dentro das estruturas, nós queremos usar os menores uints que pudermos. Um uint8 é muito pequeno, uma vez que 2^8 = 256 - se nossos zumbis atacarem uma vez por dia, eles podem estourar esse valor em um ano. Mas 2^16 é 65536 - então ao menos que o usuário ganhe ou perca a cada dia em 179 anos, estaremos seguros.

    Agora que temos novas propriedades em nossa estrutura Zombie, precisamos mudar a definição da função em _createZombie().

    Altere a definição da criação de zumbi então a cada novo zumbi criado este começa com 0 vitórias e 0 derrotas.

    zombiefactory.sol
    zombieattack.sol
    zombiehelper.sol
    zombiefeeding.sol
    ownable.sol



Capítulo 10: Vitória Zumbi 😄

Agora que temos um winCount e lossCount, podemos atualizá-los dependendo de qual zumbi venceu a luta.

No capítulo 6 nós calculamos um número aleatório entre 0 e 100. Agora vamos usar este número para determinar quem vence a luta, e atualizar os nossos status de acordo.
Vamos testar

    Crie uma declaração if que verifica se rand é menor que ou igual a attackVictoryProbability.

    Se esta condição for verdadeira, nosso zumbi venceu! Então:

    a. Incremente myZombie winCount.

    b. Incremente myZombie level. (Subiu um nível!!!!!!!)

    c. Incremente enemyZombie lossCount. (Perdedor!!!!!! 😫 😫 😫)

    d. Execute a função feedAndMultiply. Verifique zombiefeeding.sol para ver sintaxe de como chamá-lo. Para o terceiro argumento (_species), passe o valor "zombie". (No momento isto não faz nada, mas para mais tarde quando adicionarmos funcionalidades extras para criar zumbis baseados em zumbis).


Capítulo 11: Derrota Zumbi 😞

Agora que nós codificamos o que acontece quando o seu zumbi vence, vamos resolver o que acontece quando estes são derrotados.

Em nosso jogo, quando zumbis são derrotados, eles não perdem nível - eles simplesmente incrementam seus lossCount, e seus resfriamentos são ativados então eles devem esperar um dia antes de atacar novamente.

Para implementar esta lógica, iremos precisar da declaração else.

Declarações else são escritas como em JavaScript e muitas outras linguagens:

if (zombieCoins[msg.sender] > 100000000) {
  // Você esta rico!!!
} else {
  // Precisamos de mais ZombieCoins...
}

Vamos testar

    Adicione uma declaração else. Se nosso zumbi perdeu:

    a. Incremente myZombie lossCount.

    b. Incremente enemyZombie winCount.

    Fora da declaração else, execute o código da função _triggerCooldown em myZombie. Desta maneira o zumbi só poderá atacar uma vez por dia.

