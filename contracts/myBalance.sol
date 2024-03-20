// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract MyBalance {
    int128 Balance; //entero de 128 bits
    int128 availableBalance;
    int128[] Pocket; //Array de enteros de 128 bits
    string Password;
    int8 quantityShares; //número de acciones
    bool err = false; //test variable, si puedo la reemplazo con "require"

    //calldata: llamada de dato por referencia, consumo de gas y memoria solo durante la ejecución
    //external: permite acceder a la función desde fuera del contrato
    //payable: permite recibir ether como parte de la llamada de la función, incluyendo zero eth. 'non-payable' no permite recibir ether.
    function SetPassword(string calldata _Password) external payable {
        require(keccak256(abi.encodePacked(_Password)) == keccak256(abi.encodePacked('')), "Password incorrect"); //require: permite validar requisitos, si no cumplen, se revierte la transacción y no se realiza ninguna operación más
        Password = _Password;
    }

    function IncreaseBalance(string calldata _Password, int128 value) external payable {
        require(keccak256(abi.encodePacked(Password)) == keccak256(abi.encodePacked(_Password)), "Password incorrect");
        
        Balance += value;
        availableBalance += value;
        quantityShares ++;
    }

    function DecreaseBalance(string calldata _Password, int128 value) external payable {
        require(keccak256(abi.encodePacked(Password)) == keccak256(abi.encodePacked(_Password)), "Password incorrect");
        
        Balance -= value;
        availableBalance -= value;
        quantityShares ++;
    }

    function NewPocket(string calldata _Password, int128 value) external payable {
        require(keccak256(abi.encodePacked(Password)) == keccak256(abi.encodePacked(_Password)), "Password incorrect");
        require(value <= availableBalance, "Insuficcient founds");
        Pocket.push(value);
        availableBalance -= value;
        quantityShares ++;
    }
}