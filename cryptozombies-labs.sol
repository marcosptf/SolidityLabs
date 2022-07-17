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
    
    
    
    function _generateRandomDna(string _str) private view returns (uint) {
        uint rand = uint(keccak256(_str));
        return rand % dnaModulus;
    }

//6e91ec6b618bb462a4a6ee5aa2cb0e9cf30f7a052bb467b0ba58b8748c00d2e5
keccak256("aaaab");

//b1f078126895a1424524de5321b339ab00408010b7cf0e6ed451514981e58aa9
keccak256("aaaac");

Conversão de Tipos

Algumas vezes você precisa converter tipos diferentes. Pegue por exemplo o seguinte:

uint8 a = 5;
uint b = 6;

// lança um erro, porque a * b retorna um uint, não um uint8:
uint8 c = a * b;

// nós temos de converter b em uint8 para isso funcionar:
uint8 c = a * uint8(b); 

Logo acima, a * b retorna um uint, mas nós estamos tentando guardar o seu valor em um uint8, que potencialmente pode causar problemas. Ao converter-lo como um uint8, a conversão irá funcionar e o compilador não irá reclamar.

   function createRandomZombie(string _name) public {
        uint randDna;
        randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }
    
    function createRandomZombie(string _name) public {
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }
    


}
