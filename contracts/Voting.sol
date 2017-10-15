pragma solidity ^0.4.11;
// We have to specify what version of compiler this code will compile with

contract Voting {
  /* mapping field below is equivalent to an associative array or hash.
  The key of the mapping is candidate name stored as type bytes32 and value is
  an unsigned integer to store the vote count
  */
  
  struct voter {
    address voterAddress;  // The address of the voter
    uint tokensBought;  // The total no. of tokens this voter owns
    uint[] tokenUsedPerCandidate;  // Array to keep track of votes per candidate.

    /* We have an array called candidateList initialized below.
     Every time this voter votes with her tokens, the value at that
     index is incremented. Example, if candidateList array declared
     below has ["Rama", "Nick", "Jose"] and this
     voter votes 10 tokens to Nick, the tokensUsedPerCandidate[1] 
     will be incremented by 10.
     */
  } 
  
  /* mapping is equivalent to an associate array or hash.
  The key of the mapping is candidate name stored as type bytes32 
  and value is an unsigned integer which used to store the vote 
  count
  */
  mapping (bytes32 => uint8) public votesReceived;
  mapping (address => voter) public voterInfo;
  
  /* Solidity doesn't let you pass in an array of strings in the constructor (yet).
  We will use an array of bytes32 instead to store the list of candidates
  */
  
  bytes32[] public candidateList;
  uint public totalTokens;  // Total no. of tokens available for this election
  uint public balanceTokens;   // Total no. of tokens still available for purchase
  uint public tokenPrice;   // Price per token

  /* This is the constructor which will be called once when you
  deploy the contract to the blockchain. When we deploy the contract,
  we will pass an array of candidates who will be contesting in the election
  */

  /* When the contract is deployed on the blockchain, we will 
  initialize the total number of tokens for sale, cost per token and
  all the candidates
  */
  function Voting(uint tokens, uint pricePerToken, bytes32[] candidateNames) {
    candidateList = candidateNames;
    totalTokens = tokens;
    tokenPrice = pricePerToken;
  }

  /* This function is used to purchase the tokens. Note the keyword 
  'payable' below. By just adding that one keyword to a function, 
  your contract can now accept Ether from anyone who calls this 
  function. Accepting money can not get any easier than this!
  */
  
  function buy() payable returns (uint) {
    uint tokensToBuy = msg.value / tokenPrice;
    if (tokensToBuy > balanceTokens) throw;
    voterInfo[msg.sender].voterAddress = msg.sender;
    voterInfo[msg.sender].tokensBought += tokensToBuy;
    balanceTokens -= tokensToBuy;
    return tokensToBuy;
  }

  // This function returns the total votes a candidate has received so far
  function totalVotesFor(bytes32 candidate) returns (uint8) {
    if (validCandidate(candidate) == false) throw;
    return votesReceived[candidate];
  }

  // This function increments the vote count for the specified candidate. This
  // is equivalent to casting a vote
  function voteForCandidate(bytes32 candidate) {
    if (validCandidate(candidate) == false) throw;
    votesReceived[candidate] += 1;
  }

  function validCandidate(bytes32 candidate) returns (bool) {
    for(uint i = 0; i < candidateList.length; i++) {
      if (candidateList[i] == candidate) {
        return true;
      }
    }
    return false;
  }
}