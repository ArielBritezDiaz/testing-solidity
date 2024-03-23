// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract NewClient {

    uint128 private incrementValue;
    uint8 private quantityShare;
    
    //The users in Flit are Clients
    struct Client {
        uint id;
        address addr;
        string username;
        int128 balance;
        int128 availableBalance;
        int128 found;
        uint8 quantityShares;
    }

    //Each Client in Flit is recognized with uint
    mapping(uint => Client) private clients;
    mapping(address => uint) private clientsAddress;

    function CreateClient(string calldata _username) public returns(address) {
        clients[incrementValue] = Client(incrementValue, msg.sender, _username, 0, 0, 0, quantityShare);
        clientsAddress[msg.sender] = incrementValue;
        incrementValue ++;
        quantityShare ++;
        return msg.sender;
    }

    //Get info Client of Flit
    function GetClient(string calldata _username) public view returns(uint, address, string memory) {
        for(uint i = 0; i < incrementValue; i++) {
            if(keccak256(abi.encodePacked(clients[i].username)) == keccak256(abi.encodePacked(_username))) {
                return (clients[i].id, clients[i].addr, clients[i].username);
            }
        }
        revert("User not found");
    }

    function GetWalletClient(address _addr) public view returns(string memory, address, int128, int128, int128, uint8) {
        for(uint i = 0; i < quantityShare; i++) {
            if(keccak256(abi.encodePacked(clients[i].addr)) == keccak256(abi.encodePacked(_addr))) {
                return (clients[i].username, clients[i].addr, clients[i].balance, clients[i].availableBalance, clients[i].found, clients[i].quantityShares);
            }
        }
        revert("Wallet not found");
    }

    function IncreaseBalance(address _addr, int128 _value) public payable {
        uint idClient = clientsAddress[_addr];
        clients[idClient].balance += msg.value;
    }


}