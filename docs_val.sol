// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ContratoAlvo {
    address public owner;
    uint public valor;
    bool public validacao;

    constructor() {
        owner = msg.sender;
        valor = 0;
        validacao = false;
    }

    modifier apenasDono() {
        require(msg.sender == owner, "Only o dono");
        _;
    }

    modifier apenasModificador() {
        require(msg.sender == address(contratoModificador), "Only o contrato modificador can change validation");
        _;
    }

    address public contratoModificador;

    function alterarValor(uint novoValor) public apenasDono {
        valor = novoValor;
    }

    function definirContratoModificador(address enderecoContratoModificador) public apenasDono {
        contratoModificador = enderecoContratoModificador;
    }

    function modificarValidacao(bool novaValidacao) public apenasModificador {
        validacao = novaValidacao;
    }
}
