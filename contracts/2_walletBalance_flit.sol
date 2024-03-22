// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "./1_registerUser_flit.sol";

//contract NewClient {
//    function GetClient(string memory) public view returns(uint, address, string memory) {}
//}

contract WalletBalance {
    NewClient private client;

    //constructor(NewClient _client) { // Pass the NewUser contract as a parameter to the constructor
    //    client = _client;
    //}

    function getClientInfo(string calldata _username) public view returns(uint, address, string memory) {
        return client.GetClient(_username); // Call GetClient function of NewUser contract to get client info
    }
}