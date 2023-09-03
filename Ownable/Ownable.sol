// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

contract Ownable {
    address owner;
    int public counter;
    bool isPossibleToChangeOwner = true;

    constructor() {}

    modifier checkForOwner() {
        assert(owner != address(0));
        _;
    }

    error MyError(int, string);
    modifier conditionForChangingOwner() {
        if (counter < 10) {
            revert MyError(counter, "not sufficient");
        }
        _;
        counter = 0;
    }

    modifier possibleOnlyOnce() {
        assert(isPossibleToChangeOwner);
        _;
        isPossibleToChangeOwner = false;
    }

    function inc() external checkForOwner {
        counter += 1;
    }

    function dec() external checkForOwner {
        counter -= 1;
    }

    function changeOwner(address newOwner) external conditionForChangingOwner {
        owner = newOwner;
    }

    function setOwner(address newOwner) external possibleOnlyOnce {
        owner = newOwner;
    }

    function getOwner() external view returns (address) {
        return owner;
    }
}
