// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "./IERC20.sol";

contract WeCoin is IERC20 {
    string public constant _name = "WeCoin";
    string public constant _symbol = "WEC";
    uint8 public constant _decimals = 18;

    uint256 private _totalSupply = 1000;
    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowed;

    constructor() {
        _balances[msg.sender] = _totalSupply;
    }

    event TransferEvent(
        address indexed from,
        address indexed _to,
        uint256 _value
    );

    event ApprovalEvent(
        address indexed _owner,
        address indexed _spender,
        uint256 _value
    );

    function name() public pure override returns (string memory) {
        return _name;
    }

    function symbol() public pure override returns (string memory) {
        return _symbol;
    }

    function decimals() public pure override returns (uint8) {
        return _decimals;
    }

    function totalSupply() public view override returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address _owner) public view override returns (uint256) {
        return _balances[_owner];
    }

    function allowance(address _owner, address _spender)
        public
        view
        override
        returns (uint256)
    {
        return _allowed[_owner][_spender];
    }

    function transfer(address _to, uint256 _value)
        public
        override
        returns (bool)
    {
        require(_value <= _balances[msg.sender], "Not enough funds!");
        require(_to != address(0), "Address is invalid!");

        _balances[msg.sender] = _balances[msg.sender] - _value;
        _balances[_to] = _balances[_to] + _value;

        emit TransferEvent(msg.sender, _to, _value);

        return true;
    }

    function approve(address _spender, uint256 _value)
        public
        override
        returns (bool)
    {
        require(_spender != address(0), "Address is invalid!");

        _allowed[msg.sender][_spender] = _value;

        emit ApprovalEvent(msg.sender, _spender, _value);

        return true;
    }

    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    ) public override returns (bool) {
        require(_value <= _balances[_from], "Not enough funds!");
        require(
            _value <= _allowed[_from][msg.sender],
            "Not enough allowed funds"
        );
        require(_to != address(0), "Address is invalid!");

        _balances[_from] = _balances[_from] - _value;
        _balances[_to] = _balances[_to] + _value;

        _allowed[_from][msg.sender] = _allowed[_from][msg.sender] - _value;

        emit TransferEvent(_from, _to, _value);

        return true;
    }
}
