//SPDX-License-Identifier: MIT
pragma solidity >=0.4.24;

/**
 * @title Roles
 * @dev Library for managing addresses assigned to a Role.
 */
library Roles {
  struct Role {
    mapping (address => bool) bearer;
  }

  /**
   * @dev give an account access to this role
   */
  function add(Role storage role, address account) internal {
    require(account != address(0), 'This account is not valid');
    require(!has(role, account), 'This account already has a role associated');

    role.bearer[account] = true;
  }

  /**
   * @dev remove an account's access to this role
   */
  function remove(Role storage role, address account) internal {
    require(account != address(0), 'This account is not valid');
    require(has(role, account), 'This account does not have a role associated');

    role.bearer[account] = false;
  }

  /**
   * @dev check if an account has this role
   * @return bool
   */
  function has(Role storage role, address account)
    internal
    view
    returns (bool)
  {
    require(account != address(0), 'This account is not valid');
    return role.bearer[account];
  }
}