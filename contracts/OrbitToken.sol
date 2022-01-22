pragma solidity ^0.8.0;
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol";

contract OrbitToken is ERC721{
    
    string public constant NAME = "Orbit721";
    string public constant SYMBOL = "ORB";
    
    struct Planet{
        string name;
        string description;
    }
    mapping(string => uint256[]) public galaxies;
    Planet [] public planets; 
    
    constructor() ERC721(NAME, SYMBOL) {
        
    }
    
    function mint(string memory _galaxy,string memory  _name,string memory  _description ) public{
        Planet memory planet = Planet({name: _name, description: _description});
        planets.push(planet);
        uint planetId = planets.length- 1;
        galaxies[_galaxy].push(planetId);
        _mint(msg.sender, planetId);
    }
    
    function getPlanetsFromGalaxy(string memory _galaxy) public view returns (uint256[] memory){
        return galaxies[_galaxy];
    }
    
    function getPlanet(uint _planetId) public view returns(Planet memory){
        return planets[_planetId];
    }

}