/**
Time units
Unidades de tempo

Solidity fornece algumas unidades nativas para lidar com o tempo.
A variável now (agora) irá retornar o unix timestamp atual (o número de segundos que passou desde 1 de Janeiro de 1970). 
O tempo unix no momento que escrevo este tutorial é 1515527488.

Nota: O tempo unix é tradicionalmente guardado em um número de 32-bits. 
Isto irá causar o problema do "Ano 2038", quando os unix timestamps irão sobre carregar
e quebrar um monte de sistema legados. 
Então se queremos a nossa DApp continuar rodando mais do que 20 anos a partir de agora, 
podemos usar um número de 64-bits - mas nossos usuários terão que gastar mais gas 
para usar a nossa DApp no momento. Decisões de projeto!

Solidity também contem os tempo em unidades de:
seconds (segundos), 
minutes (minutos), 
hours (horas), 
days (dias), 
weeks (semanas). 

Estes irão converter para um uint do número em segundos no período de tempo. 
Então 1 minutes são 60, 1 hours são 3600(60 segundos x 60 minutos), 1 days são 86400 (24 hours x 60 minutos x 60 segundos), etc.

Segue um exemplo de como essas unidades de tempo são úteis:
*/

uint lastUpdated;

// Atribui `lastUpdated` para `now`
function updateTimestamp() public {
  lastUpdated = now;
}

// Irá retornar `true` se 5 minutos se passaram desde de que `updateTimestamp` foi
// chamado, `false` se os 5 minutos ainda passaram
function fiveMinutesHavePassed() public view returns (bool) {
  return (now >= (lastUpdated + 5 minutes));
}

/**
Podemos usar estas unidades de tempo para o cooldown (esfriar) do Zumbi.
*/
