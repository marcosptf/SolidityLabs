/**
Contratos Proprietários

Você percebeu a falha de segurança no capítulo anterior?
setKittyContractAddress é um external, então qualquer um pode chamá-lo! Isso quer dizer que qualquer um que chamar a função pode mudar o endereço do contrato do CryptoKitties, e quebrar a nossa aplicação para todos os usuários.
Nós queremos uma maneira de atualizar este endereço em nosso contrato, mas nós não queremos que qualquer um possa atualizá-lo.
Para lidar com casos assim, uma prática que se tornou comum é tornar o contrato Ownable (Proprietário) - quer dizer que tem um dono (você no caso) que tem privilégios especiais.
Contratos Ownable do OpenZeppelin
Abaixo um contrato Ownable pego da biblioteca Solidity do OpenZeppelin. OpenZeppelin é uma biblioteca de contratos seguros e auditados pela comunidade que você pode usar em suas próprias DApps. Após esta lição, recomendamos fortemente que você visite o site deles para maior aprendizado.
Leia com atenção o contrato abaixo. Você verá algumas coisas que nós já aprendemos, mas não se preocupe, iremos falar mais sobre isso em seguida.
*/

/**
 * @title Ownable
 * @dev Um contrato Ownable tem um endereço de dono, e fornece funções básicas de autorização,
 * que simplificam a implementação de "permissões de usuário".
 */
contract Ownable {
  address public owner;
  event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

  /**
   * @dev O construtor Ownable define o `owner` (dono) original do contrato como o sender
   * da conta
   */
  function Ownable() public {
    owner = msg.sender;
  }

  /**
   * @dev Lança um erro se chamado por outra conta que não seja o dono.
   */
  modifier onlyOwner() {
    require(msg.sender == owner);
    _;
  }

  /**
   * @dev Permite que o atual dono transfira o controle do contrato para um novo dono.
   * @param newOwner O endereço de transferência para o novo dono.
   */
  function transferOwnership(address newOwner) public onlyOwner {
    require(newOwner != address(0));
    OwnershipTransferred(owner, newOwner);
    owner = newOwner;
  }
}

/**
Um pouco de novas coisas que não vimos antes:

    Construtores: function Ownable() é um construtor, que é uma função opcional e especial que tem o mesmo nome do contrato. Esta será executada somente uma vez, quando o contrato é criado a primeira vez.
    Funções Modificadoras: modifier onlyOwner(). Modificadores são um tipo de meia-função que são usadas para modificar outras funções, normalmente usadas para checar algo requerido antes da execução. Neste caso, onlyOwner pode ser usada para limitar o acesso então only (somente) o owner (dono) do contrato pode executar esta função. Nós iremos falar mais sobre funções modificadoras no próximo capítulo, e o que esse _; faz.
    Palavra-chave indexed: não se preocupe com isso, nós ainda não precisamos.

Então o contrato Ownable basicamente faz o seguinte:

    Quando o contrato é criado, este construtor define o owner (dono) para msg.sender (a pessoa que implantou-o na blockchain)

    Este adiciona um modificador onlyOwner, que restringe o acesso a certas função somente para o owner (dono)

    Também permite a transferência de um contrato para o novo owner (dono)

O onlyOwner é um requisito muito comum na maior parte dos contratos de DApps em Solidity que já começam com um copia/cola do contrato Ownable, e o primeiro contrato já o herda.

Já que nós queremos limitar o setKittyContractAddress para onlyOwner, teremos que fazer o mesmo para o nosso contrato.
*/



