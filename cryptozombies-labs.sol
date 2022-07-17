pragma solidity ^0.4.19;

/**
* contrato fabrica de Zombie
*/
contract ZombieFactory {

    //variaveis com as caracteristicas de dna
    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    //struct com as caracteristicas do zombie
    struct Zombie {
        string name;
        uint dna;
    }

    /*
    * aqui estamos declarando uma variavel array
    * do tipo structs de acesso public
    */
    Zombie[] public zombies;

    /**
    * function publica para criacao de zombies
    * que recebe 2 variavies publicas do contrato
    * e elas sao atribuidas para o array de zombies;
    * o padrao para variaveis nos parametros de function
    * para se diferenciar de variavies de globais
    * eh que elas comecem com "_variavel"
    * esta function eh private, entao o patrao para
    * funcoes privadas eh que o nome dela seja iniciada
    * com "_" e private no acesso
    */
    function _createZombie(string _name, uint _dna) private {
        zombies.push(Zombie(_name, _dna));
    }
    
    /**
    * Modificadores das Funções
    * Na verdade a função acima não altera estado algum em Solidity 
    * em outras palavras não altera qualquer valor ou escreve qualquer coisa.
    * Neste caso nós podemos declará-la como uma função com palavra reservada 
    * view (observa), que significa: somente uma observação do dado, mas nenhuma alteração de fato.
    */
    function sayHello() public view returns (string) { }
    
    /**
    * Em Solidity também existem funções puras usando a palavra reservada pure, 
    * que significa que nenhum dado será acessado na aplicação. Pense na seguinte situação:
    * Esta função nem mesmo lê um estado da aplicação - os seus valores retornados 
    * dependem somente dos parâmetros da função. Então neste caso nós podemos declarar a 
    * função como pura usando a palavra reservada pure.
    */
    function _multiply(uint a, uint b) private pure returns (uint) {
      return a * b;
    }
    
    

}
