// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract HashingWithKeccak {
    //keccak256: cryptographic hash function
    //abi.encodePacked: toma los argumentos, los concatena sin agregar info adicional, empaqueta los datos en una sola cadena y los convierte a una secuencia de bytes
    function Hash(string memory _text, uint256 _num, address _addr) public pure returns(bytes32) {
        //retornamos un hash que combine "_text", "_num" y "_addr"
        return keccak256(abi.encodePacked(_text, _num, _addr));
    }
}