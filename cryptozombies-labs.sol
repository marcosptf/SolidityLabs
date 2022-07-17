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

    //aqui estamos declarando uma variavel array
    //do tipo structs de acesso public
    Zombie[] public zombies;

    /**
    * function publica para criacao de zombies
    * que recebe 2 variavies publicas do contrato
    * e elas sao atribuidas para o array de zombies;
    * o padrao para variaveis nos parametros de function
    * para se diferenciar de variavies de globais
    * eh que elas comecem com "_variavel"
    */
    function createZombie(string _name, uint _dna) {
        zombies.push(Zombie(_name, _dna));
    }

}
