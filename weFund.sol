// SPDX-License-Identifier: MIT

pragma solidity ^0.8.12;

contract WeFund2 {
    struct Contributor {
        string name;
        //uint value;
        bytes data;
    }
//the array that saves the contributors

    address payable public benefactors;
    //mapping(address => Contributor) public isBenefactor;

    struct Request {
        uint value;
        address payable to;
        bytes data;
        bool granted;
        uint approvals;
    }
    
    mapping(uint => mapping(address => bool)) public approved;
    uint private required;
// all requests
    Request[] public requests;
    
// granted requests
    Request[] public granted;

    function cBenefactor() external {
   //     benefactors = request[_requestId].to;
    }

    
    function contribute() external payable  {
        require(msg.value >= 0.5 ether, "not enough to contribute");

    }

    function submitLoanRequest(address payable _to, uint _value, bytes calldata _data)
    external {
        requests.push(Request({
            to: _to,
            value: _value,
            data: _data,
            granted: false,
            approvals: 0
        }));
    }

   function getBalance() public view returns(uint){
       return address(this).balance;
   }

    function executeLoanRequest(uint _requestId) external payable
    {
        Request storage request = requests[_requestId];
        require(request.approvals >= required , "requires more approvals");
        request.granted = true;
        require(request.granted, "not granted");
        address payable benefactor = payable(benefactors);
        benefactor.transfer(getBalance());

    } 

//    function getBalance() public view returns (uint) {
   //     return address(this).balance);
    
}


