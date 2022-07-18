/**
Importar (Import)

Uau! Você vai perceber que nós limpamos todo o código a direita, e agora você tem as abas no topo do seu editor. Vá em frente, clique nas abas e veja o que acontece.
Nosso código estava ficando um tanto grade, então separamos em vários arquivos para torná-los mais gerenciáveis. Esta é a forma normal de gerenciar grandes bases de código em seus projetos em Solidity.
Quando você tiver vários arquivos e você quiser importar um arquivo em outro, Solidity usa a palavra reservada import.
Então se temos o arquivo chamado someothercontract.sol no mesmo diretório que este contrato (por isso o ./), ele será importado pelo compilador.

*/

import "./someothercontract.sol";
contract newContract is SomeOtherContract { }

