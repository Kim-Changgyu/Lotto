//SPDX-License-Identifier: UNLICENSED

pragma solidity >= 0.8.13;

contract SecretContract {
    struct Instance {
        address author;                             // 갑
        address target;                             // 을
        string content;                             // 계약 내용
    }

    address public owner;                           // 스마트 컨트랙트 소유주

    mapping (address => Instance[]) contracts;      // 어드레스별 계약서 관리

    constructor () {
        owner = msg.sender;
    }

    // 계약서 조회
    function getContract() view public returns (Instance[] memory) {
        return contracts[msg.sender];
    }

    // 계약서 등록
    function addContract(address _target, string memory _content) public {
        contracts[msg.sender].push(Instance(msg.sender, _target, _content));
    }

    // 계약 잔고 조회
    function getBalance() view public returns (uint) {
        return address(this).balance;
    }
}