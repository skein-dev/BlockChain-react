pragma solidity ^0.5.0;

contract Marketplace {
    string public name;
    address payable public richest;
    uint public productCount = 0;
    uint public requestCount = 0;
    uint public mostSent;

    mapping(uint => Product) public products;
    mapping(uint => Request) public requests;
    mapping(address => uint) pendingWithdrawals;

    struct Product {
        uint id;
        string name;
        uint price;
        address payable owner;
        bool purchased;
    }
    struct Request {
        uint id;
        string name;
        uint price;
        address payable owner;
        bool purchased;
    }
    event Transfer(
        address indexed _from,
        address indexed _to,
        uint256 _value
    );
    event ProductCreated(
        uint id,
        string name,
        uint price,
        address payable owner,
        bool purchased
    );
    event ProductDeleted(
        uint id,
        string name,
        uint price,
        address payable owner,
        bool purchased
    );
    event ProductPurchased(
        uint id,
        string name,
        uint price,
        address payable owner,
        bool purchased
    );

    event RequestCreated(
        uint id,
        string name,
        uint price,
        address payable owner,
        bool purchased
    );
    event RequestDeleted(
        uint id,
        string name,
        uint price,
        address payable owner,
        bool purchased
    );
    event RequestPurchased(
        uint id,
        string name,
        uint price,
        address payable owner,
        bool purchased
    );
    constructor() public payable {
        name = "Dapp University Marketplace";
        richest = msg.sender;
        mostSent = msg.value;
    }
    function createProduct(string memory _name, uint _price) public {
        // Require a valid name
        require(bytes(_name).length > 0);
        // Require a valid price
        require(_price > 0);
        // Increment product count
        productCount ++;
        // Create the product
        products[productCount] = Product(productCount, _name, _price, msg.sender, false);
        // Trigger an event
        emit ProductCreated(productCount, _name, _price, msg.sender, false);
    }
    function deleteProduct(uint _id) public {
        Product memory _product;
        // Delte product item which has _id
        for( uint i = 0; i < productCount; i++) {
            if (products[i].id == _id) {
                _product = products[i];
                delete products[i];
            }
        }
        productCount --;
        // Trigger an event
        emit ProductDeleted(productCount, _product.name, _product.price, msg.sender, false);
    }
    function becomeRichest() public payable returns (bool) {
        if (msg.value > mostSent) {
            pendingWithdrawals[richest] == msg.value;
            richest = msg.sender;
            mostSent = msg.value;
            return true;
        } else {
            return false;
        }
    }
    function withdraw() public {
        uint amount = pendingWithdrawals[msg.sender];
        pendingWithdrawals[msg.sender] = 0;
        msg.sender.transfer(amount);
    }
    function purchaseProduct(uint _id) public payable {
        // Fetch the product
        Product memory _product = products[_id];
        // Fetch the owner
        address payable _seller = _product.owner;
        address payable _producter = msg.sender;
        //richest = msg.sender;
        //pendingWithdrawals[richest] += msg.value;

        // Make sure the product has a valid id
        require(_product.id > 0 && _product.id <= productCount);
        // Require that there is enough Ether in the transaction
        require(msg.value >= _product.price);
        // Require that the product has not been purchased already
        require(!_product.purchased);
        // Require that the buyer is not the seller
        require(_seller != msg.sender);
        // Transfer ownership to the buyer
        _product.owner = msg.sender;
        // Mark as purchased
        _product.purchased = true;
        // Update the product
        products[_id] = _product;

        //uint amount = pendingWithdrawals[msg.sender];
        //pendingWithdrawals[msg.sender] = 0;
        // Pay the seller by sending them Ether
        (bool success, ) = _producter.call.value(20 ether).gas(5300)("");
        require(success, "Transfer failed.");
        
        // Trigger an event
        emit ProductPurchased(productCount, _product.name, _product.price, msg.sender, true);
    }
    function createRequest(string memory _name, uint _price) public {
        // Require a valid name
        require(bytes(_name).length > 0);
        // Require a valid price
        require(_price > 0);
        // Increment product count
        requestCount ++;
        // Create the product
        requests[requestCount] = Request(requestCount, _name, _price, msg.sender, false);
        // Trigger an event
        emit ProductCreated(requestCount, _name, _price, msg.sender, false);
    }
    function deleteRequest(uint _id) public {
        Request memory _request;
        // Delte product item which has _id
        for( uint i = 0; i < requestCount; i++) {
            if (requests[i].id == _id) {
                _request = requests[i];
                delete requests[i];
            }
        }
        requestCount --;
        // Trigger an event
        emit RequestDeleted(requestCount, _request.name, _request.price, msg.sender, false);
    }
    function purchaseRequest(uint _id) public payable {
        // Fetch the product
        Request memory _request = requests[_id];
        // Fetch the owner
        address payable _buyer = _request.owner;
        // Make sure the product has a valid id
        require(_request.id > 0 && _request.id <= requestCount);
        // Require that there is enough Ether in the transaction
        require(msg.value <= _request.price);
        // Require that the product has not been purchased already
        require(!_request.purchased);
        // Require that the buyer is not the seller
        require(_buyer != msg.sender);
        // Transfer ownership to the buyer
        _request.owner = msg.sender;
        // Mark as purchased
        _request.purchased = true;
        // Update the product
        requests[_id] = _request;
        // Pay the seller by sending them Ether
        address(msg.sender).transfer(msg.value);
        // Trigger an event
        emit RequestPurchased(requestCount, _request.name, _request.price, msg.sender, true);
    }
}
