pragma solidity ^0.8.0;
import "./OrbitToken.sol";
contract OrbitMarket is OrbitToken{
    
      struct Offer {
        bool isForSale;
        uint planetIndex;
        address seller;
        uint minValue;          // in ether
        address onlySellTo;     // specify to sell only to a specific person
    }

    struct Bid {
        bool hasBid;
        uint planetIndex;
        address bidder;
        uint value;
    }
    
    
    mapping (uint => Offer) public planetOfferedForSale;

    // A record of the highest punk bid
    mapping (uint => Bid) public planetBids;
    
    mapping (address => uint) public pendingWithdrawals;

    
    event PlanetOffered(uint indexed planetIndex, uint minValue, address indexed toAddress);
    event PlanetNoLongerForSale(uint indexed planetIndex);
    event PlanetBought(uint indexed planetIndex, uint value, address indexed fromAddress, address indexed toAddress);
    event PlanetBidEntered(uint indexed planetIndex, uint value, address indexed fromAddress);
    event PlanetBidWithdrawn(uint indexed planetIndex, uint value, address indexed fromAddress);
        
    constructor(){

    }
    
    function offerPlanetForSale(uint _planetIndex, uint _minSalePriceInWei) public {
        address owner = ownerOf(_planetIndex);
        require(owner!= msg.sender, "Planet is not owned by you");
        planetOfferedForSale[_planetIndex] = Offer(true, _planetIndex, msg.sender, _minSalePriceInWei, address(0));
        emit PlanetOffered(_planetIndex, _minSalePriceInWei, address(0));
    }
    
    function offerPlanetForSaleToAddress(uint _planetIndex, uint _minSalePriceInWei, address _toAddress) public {
        address owner = ownerOf(_planetIndex);
        require(owner!= msg.sender, "Planet is not owned by you");
        planetOfferedForSale[_planetIndex] = Offer(true, _planetIndex, msg.sender, _minSalePriceInWei, _toAddress);
        emit PlanetOffered(_planetIndex, _minSalePriceInWei, _toAddress);
    }
    
    
    function buyPlanet(uint _planetIndex) payable public{
        Offer memory offer = planetOfferedForSale[_planetIndex];
        require (offer.isForSale, "Punk not for sale");                // punk not actually for sale
        require (offer.onlySellTo == address(0) && offer.onlySellTo == msg.sender, "Planet not supposed to be sold to this address");  // punk not supposed to be sold to this user
        require (msg.value > offer.minValue, "Did not send enough ETH ");      // Didn't send enough ETH
        require (offer.seller == ownerOf(_planetIndex)) ; // Seller no longer owner of punk

        address seller = offer.seller;
        _transfer(seller, msg.sender, _planetIndex);

        emit PlanetNoLongerForSale(_planetIndex);
        pendingWithdrawals[seller] += msg.value;
        emit PlanetBought(_planetIndex, msg.value, seller, msg.sender);

        // Check for the case where there is a bid from the new owner and refund it.
        // Any other bid can stay in place.
        Bid memory bid = planetBids[_planetIndex];
        if (bid.bidder == msg.sender) {
            // Kill bid and refund value
            pendingWithdrawals[msg.sender] += bid.value;
            planetBids[_planetIndex] = Bid(false, _planetIndex, address(0), 0);
        }
    }
    
    function withdraw() public{
        uint amount = pendingWithdrawals[msg.sender];
        // Remember to zero the pending refund before
        // sending to prevent re-entrancy attacks
        pendingWithdrawals[msg.sender] = 0;
        payable(msg.sender).transfer(amount);
    }

    function enterBidForPunk(uint _planetIndex) public payable {
        require(ownerOf(_planetIndex) != address(0), "owner of the address is 0 address");
        require(ownerOf(_planetIndex) != msg.sender, "Bid cant be placed by the owner of the NFT");
        require(msg.value != 0, "you cant send 0 price");
        Bid memory existing = planetBids[_planetIndex];
        require(msg.value >= existing.value, "provided amount should be greater or equal to minimun bid");
        if (existing.value > 0) {
            // Refund the failing bid
            pendingWithdrawals[existing.bidder] += existing.value;
        }
        planetBids[_planetIndex] = Bid(true, _planetIndex, msg.sender, msg.value);
        emit PlanetBidEntered(_planetIndex, msg.value, msg.sender);
    }
    
    function acceptBidForPlanet(uint _planetIndex, uint _minPrice) public {
        require(ownerOf(_planetIndex) == msg.sender, "Owner of the nft can call this function");
        address seller = msg.sender;
        Bid memory bid = planetBids[_planetIndex];
        require (bid.value != 0, "bid value cant be zero") ;
        require (bid.value > _minPrice, "bid value should be greater then min price");
        transferFrom(seller, bid.bidder, 1);

        planetOfferedForSale[_planetIndex] = Offer(false, _planetIndex, bid.bidder, 0, address(0));
        uint amount = bid.value;
        planetBids[_planetIndex] = Bid(false, _planetIndex, address(0), 0);
        pendingWithdrawals[seller] += amount;
        emit PlanetBought(_planetIndex, bid.value, seller, bid.bidder);
    }
    
    function withdrawBidForPlanet(uint _planetIndex) public {
        require(ownerOf(_planetIndex) != address(0), "Owner of the  planet vant be zero");
        require(ownerOf(_planetIndex) != msg.sender, "nft owner cant retrieve bid");
        Bid memory bid = planetBids[_planetIndex];
        require(bid.bidder == msg.sender);
        emit PlanetBidWithdrawn(_planetIndex, bid.value, msg.sender);
        uint amount = bid.value;
        planetBids[_planetIndex] = Bid(false, _planetIndex, address(0), 0);
        // Refund the bid money
        payable(msg.sender).transfer(amount);
    }
    
}