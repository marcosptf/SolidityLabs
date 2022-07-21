/**
Imutabilidade dos Contratos

Até agora, Solidity pareceu bastante similar a outras linguagens como Javascript. Mas as aplicações distribuídas em Ethereum são um tanto diferentes de aplicações normais em diversas maneiras.
Para começar, após você implantar um contrato em Ethereum, este é imutável, quer dizer que ele nunca poder ser modificado ou melhorado novamente.
O código que você implantou para um contrato esta lá permanentemente, para sempre, na blockchain. Esta é uma das razões na qual a segurança em Solidity é uma grande preocupação. Se houver uma falha no código do contrato, não há maneira de remendar depois. Você precisará dizer aos seus usuários para começarem a usar um outro smart contract que tem a correção.
Mais isto também é uma parte essencial dos smart contracts. O código é a lei. Se você ler o código do smart contract e verificá-lo, você pode ter certeza que toda vez que chamar aquela função sempre irá acontecer exatamente aquilo que o código diz. Ninguém pode mudar essa função depois e retornar resultados inesperados.

Dependências externas

Na Lição 2, nós programamos o endereço do contratos do CryptoKitties em nossa DApp. Mas o que aconteceria se o contrato dos CryptoKitties tivesse um bug e alguém destruísse todos os gatinhos?
É improvável, mas se isso acontecer iria deixar nossa DApp completamente inútil - nossa DApp iria apontar para um endereço que nunca mais retornaria qualquer gatinho. Nossos zumbis não iriam mais poder comer gatinhos, e não poderíamos modificar nosso contrato para corrigir isso.
Por esta razão, faz sentido ter algumas funções que permitem atualizar algumas partes chaves da nossa DApp.
Por exemplo, ao invés de ter um código fixo com o endereço do contrato dos CryptoKitties em nossa DApp, poderíamos ter uma função setKittyContractAddress que permitiria-nos mudar o endereço no futuro se caso algo acontecesse ao contrato do CryptoKitties.

*/

