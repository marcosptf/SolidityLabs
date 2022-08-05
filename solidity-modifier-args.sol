/**
Funções Modificadoras com argumentos

Ótimo! Nosso zumbi agora tem um tempo de resfriamento que funciona.

Seguinte, vamos adicionar alguns métodos adicionais de ajuda. 
Vamos criar um novo arquivo chamado zombiehelper.sol, que importa o zombiefeeding.sol. 
Isto irá nos ajudar a manter o código organizado.

Vamos fazer isso os zumbis ganharão certas habilidades após alcançarem um certo nível. 
Mas para conseguir isso, primeiro nós temos que aprender um pouco mais sobre funções modificadoras.
Funções modificadoras com argumentos

Anteriormente nós vimos um simples exemplo de onlyOwner. 
Mas a função modificadora também pode receber argumentos. 
Por exemplo:
*/

// Um mapeamento para guardar a idade do usuário:
mapping (uint => uint) public age;

// Modificador que requer que o usuário seja mais velho que certa idade:
modifier olderThan(uint _age, uint _userId) {
  require (age[_userId] >= _age);
  _;
}

// Deve ter mais que 16 anos para dirigir um carro (ao menos nos Estados Unidos).
// Podemos chamar o modificador `olderThan` com argumentos desse jeito:
function driveCar(uint _userId) public olderThan(16, _userId) {
  // Alguma lógica de função
}


/**
Como você pode ver o modificador olderThan recebe argumentos como qualquer função. 
E a função driverCar passa os argumentos para o modificador.

Vamos tentar fazer nosso próprio modifier que usa a propriedade level 
do zumbi para restringir o acesso à habilidades especiais.
*/


