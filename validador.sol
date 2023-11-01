// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./docs_val.sol";

contract ContratoModificador {
    address public owner;
    address public contratoAlvoAddress;

    constructor(address _contratoAlvoAddress) {
        owner = msg.sender;
        contratoAlvoAddress = _contratoAlvoAddress;
    }

    modifier apenasDono() {
        require(msg.sender == owner, "Only o dono");
        _;
    }

    function definirContratoAlvo(address _contratoAlvoAddress) public apenasDono {
        contratoAlvoAddress = _contratoAlvoAddress;
    }

    function modificarValidacaoNoContratoAlvo(bool novaValidacao) public apenasDono {
        ContratoAlvo contratoAlvo = ContratoAlvo(contratoAlvoAddress);
        contratoAlvo.modificarValidacao(novaValidacao);
    }
}
