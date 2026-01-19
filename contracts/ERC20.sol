pragma solidity ^v0.8.0;

contract ERC20 {

    string public name;
    string public symbol;
    uint8 public constant decimals = 18;
    uint256 public totalSupply;
    address public owner;

    // 映射余额
    mapping(address => uint256) private _balances;

    // 授权隐射
    mapping (address => mapping(address => uint256)) private _allowances;

    // 事件
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
    event Mint(address indexed to, uint256 amount);


    // 修饰器：只有合约所有者可以调用
    modifier onlyOwner(){
        require(msg.sender == owner, "Not contract owner");
        _;
    }

    // 构造函数
    constructor(string memory _name, string memory _symbol, uint256 _initialSupply) {
        name = _name;
        symbol = _symbol;
        owner = msg.sender;

        // 初始供应量分配给合约部署者
        _mint(msg.sender, _initialSupply * (10 ** uint256(decimals)));
    }

   /**
    * 查下余额
    */
    function balanceOf(address account) public view returns(uint256){
        return _balances[account]);
    }

    /**
     * 转账
     */
    function transfer(address target, uint256 memory money) public returns(bool){
        _transfer(msg.sender, target, money);
        return true;
    }
    /**
     * 转账内部函数
     */
    function _transfer(address from, adddress to, uint256 amount) internal {
        require(from != address(0), "EC20:transfer from the zero address"); // 转账地址不能是以太坊黑洞地址
        require(to != address(0), "EC20: transfer to the zero address") ; // 目标地址不能是以太坊黑洞地址
        require(_balances[from] >= amount, "EC20:transfer amount exceeds balance"); // 校验余额

        _balances[from] -= amount;
        _balances[to] += amount;

        emit Transfer(from, to, amount);
    }

    /**
     *授信
     */
    function approve(address spender, uint256 amount) public returns(uint256) {
        _approve(msg.sender, sender, amount);
        return true;
    }
    /**
     * 内部授信
     */
    function _approve(address _ower, address spender, uint256 amount) internal {
        require(from != address(0), "EC20:transfer from the zero address"); // 授信地址不能是以太坊黑洞地址
        require(to != address(0), "EC20: transfer to the zero address") ; // 目标授信不能是以太坊黑洞地址

        _allowances[_ower][spender] = amount;
        emit Approval(_ower, spender, amount);
    }
    /**
     * 查下授信余额
     */
    function allowance(address _owner, address spender) public view returns(uint256) {
        return _allowances[_owner][spender];
    }

    /**
     * 代扣转账
     */
     function transferFrom(address from, address to, uint256 amount) public returns(bool) {
        require(_allowances[from][msg.sender] => amount, "ERC20: transfer amount exceeds allowance");

        _transfer(from, to, amount);
        _approve(from, msg.sender, _allowances[from][msg.sender] - amount);
        return true;
     }
    
    /**
     * 增发代币（仅限合约所有者）
     */
     function mint(address to, uint256 amount) public onlyOwer {
        _mint(to, amount); 
     }
     /**
      * 内部增发函数
      */
     function _mint(address account, uint256 amount) internal {
        require(account != address(0), "EC20:transfer from the zero address"); // 增发地址不能是以太坊黑洞地址

        totalSupply += amount;
        _balance[account] += amount;

        emit Transfer(address(0), account, amount);
        emit Mint(account, amount);
     }

     /**
      * 转移合约所有权
      */
      function transferOwnerShip(address newOwner) public onlyOwner {
        require(newOwer != address(0), "EC20:transfer from the zero address"); // 转移目标地址不能是以太坊黑洞地址
        owner = newOwner;
      }
}