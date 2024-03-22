// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract NewClient {

    uint128 private incrementIdClient;

    //The users in Flit are Clients
    struct Client {
        uint id;
        address addr;
        string username;
    }

    //Each Client in Flit is recognized with uint
    mapping(uint => Client) private clients;

    function CreateClient(string memory _username) public {
        clients[incrementIdClient] = Client(incrementIdClient, msg.sender, _username);
        incrementIdClient ++;
    }

    //Get info Client of Flit
    function GetClient(string memory _username) public view returns(uint, address, string memory) {
        for(uint i = 0; i < incrementIdClient; i++) {
            if(keccak256(abi.encodePacked(clients[i].username)) == keccak256(abi.encodePacked(_username))) {
                return (clients[i].id, clients[i].addr, clients[i].username);
            }
        }
        revert();
    }
}