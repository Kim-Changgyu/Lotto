//SPDX-License-Identifier: UNLICENSED

pragma solidity >= 0.8.13;

contract SecretContract {
    struct Instance {
        address A;                                    // A
        address B;                                    // B
        string content;                               // 계약 내용
        string date;                                  // 작성일자자
    }

    address public owner;                             // 스마트 컨트랙트 소유주
    mapping (uint => Instance) contracts;             // 어드레스별 계약서 관리
    uint counter;

    constructor () {
        owner = msg.sender;
        counter = 0;
    }

    // 계약서 조회
    function getContract() view public returns (address[] memory, address[] memory, string[] memory, string[] memory) {
        address[] memory _A = new address[](counter);
        address[] memory _B = new address[](counter);
        string[] memory _content = new string[](counter);
        string[] memory _date = new string[](counter);

        for(uint i = 0; i < counter; i++) {
            _A[i] = contracts[i].A;
            _B[i] = contracts[i].B;
            _content[i] = contracts[i].content;
            _date[i] = contracts[i].date;
        }

        return (_A, _B, _content, _date);
    }

    // 계약서 등록
    function addContract(address _A, address _B, string memory _content, string memory _date) public {
        contracts[counter++] = Instance(_A, _B, _content, _date);
    }

    // 계약 잔고 조회
    function getBalance() view public returns (uint) {
        return address(this).balance;
    }
}