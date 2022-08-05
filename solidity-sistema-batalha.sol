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




