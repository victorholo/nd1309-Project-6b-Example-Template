//SPDX-License-Identifier: MIT
pragma solidity >=0.6.0;

// Import the library 'Roles'
import "./Roles.sol";
import "../../node_modules/@openzeppelin/contracts/GSN/Context.sol";

// Define a contract 'ConsumerRole' to manage this role - add, remove, check
contract ConsumerRole is Context {
  using Roles for Roles.Role;

  // Define 2 events, one for Adding, and other for Removing
  event ConsumerAdded(address indexed consumerAddress);
  event ConsumerRemoved(address indexed consumerAddress);

  // Define a struct 'consumers' by inheriting from 'Roles' library, struct Role
  Roles.Role private consumers;

  // In the constructor make the address that deploys this contract the 1st consumer
  constructor() public {
    _addConsumer(_msgSender());
  }

  // Define a modifier that checks to see if msg.sender has the appropriate role
  modifier onlyConsumer() {
    require(isConsumer(_msgSender()), 'Sender does not have consumer role');
    _;
  }

  // Define a function 'isConsumer' to check this role
  function isConsumer(address account) public view returns (bool) {
    return Roles.has(consumers, account);
  }

  // Define a function 'addConsumer' that adds this role
  function addConsumer(address account) public onlyConsumer {
    _addConsumer(account);
  }

  // Define a function 'renounceConsumer' to renounce this role
  function renounceConsumer() public {
    _removeConsumer(_msgSender());
  }

  // Define an internal function '_addConsumer' to add this role, called by 'addConsumer'
  function _addConsumer(address account) internal {
    Roles.add(consumers, account);
    emit ConsumerAdded(account);
  }

  // Define an internal function '_removeConsumer' to remove this role, called by 'removeConsumer'
  function _removeConsumer(address account) internal {
    Roles.remove(consumers, account);
    emit ConsumerRemoved(account);
  }
}