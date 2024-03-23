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
        int balance;
        int128 availableBalance;
        int fund;
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

    //Get the wallet of the client
    function GetWalletClient(address _addr) public view returns(string memory, address, int, int128, int, uint8) {
        for(uint i = 0; i < quantityShare; i++) {
            if(keccak256(abi.encodePacked(clients[i].addr)) == keccak256(abi.encodePacked(_addr))) {
                return (clients[i].username, clients[i].addr, clients[i].balance, clients[i].availableBalance, clients[i].fund, clients[i].quantityShares);
            }
        }
        revert("Wallet not found");
    }

    //Post a new balance to increase
    function IncreaseBalance(address _addr) public payable {
        require(msg.value > 0);
        clients[clientsAddress[_addr]].balance += int(msg.value);
    }

    function DecreaseBalance(address _addr) public payable {
        require(msg.value > 0);
        clients[clientsAddress[_addr]].balance -= int(msg.value);
    }

    //payment client to client
    function PaymentClient(address _addr) public payable {
        require(msg.value > 0);
        clients[clientsAddress[msg.sender]].balance -= int(msg.value);
        clients[clientsAddress[_addr]].balance += int(msg.value);
    }

    //deposit new founds
    function DepositFunds(address _addr) public payable {
        require(msg.value > 0);
        clients[clientsAddress[_addr]].balance -= int(msg.value);
        clients[clientsAddress[_addr]].fund += int(msg.value);
    }

    function ToWithdrawFunds(address _addr) public payable {
        require(msg.value > 0);
        clients[clientsAddress[_addr]].fund -= int(msg.value);
        clients[clientsAddress[_addr]].balance += int(msg.value);
    }
}