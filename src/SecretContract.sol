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
    uint counter;                                     // 전체 계약서 수수
    uint commision;                                   // 수수료

    constructor () {
        owner = msg.sender;
        counter = 0;
        commision = 10000000000000000;                // 기본 설정 : 0.01 Ether
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
    function addContract(address _A, address _B, string memory _content, string memory _date) public payable {
        if (msg.value != commision) {
            revert();
        }
        
        contracts[counter++] = Instance(_A, _B, _content, _date);
    }


    // 등록 수수료 조회
    function getCommision() view public returns (uint) {
        return commision;
    }

    // 소유주 조회
    function getOwner() view public returns (address) {
        return owner;
    }

    // 계약 잔고 조회
    function getBalance() view public returns (uint) {
        return address(this).balance;
    }

    // 전액 잔고 회수
    function withdraw() public payable {
        require(msg.sender == owner);

        if (!payable(owner).send(address(this).balance)) {
            revert();
        }
    }
}