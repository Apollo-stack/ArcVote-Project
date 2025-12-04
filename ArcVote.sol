// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract ArcVote {

    struct Candidate {
        string name;
        uint256 voteCount; 
    }

    Candidate[] public candidates; 
    
    mapping (address => bool) public hasVoted;
    
    //necessario para atualizar o site
    event VoteConfirmed (address voter, string candidateName);

    constructor (){

        candidates.push(Candidate("USDC (Circle)", 0));
        candidates.push(Candidate("EURC (Euro)", 0));
        candidates.push(Candidate("Arc Native Token", 0));
        candidates.push(Candidate("Wrapped BTC", 0));
        candidates.push(Candidate("Wrapped ETH", 0));
    }

    function vote (uint256 _candidateIndex) public {

        require(!hasVoted[msg.sender], "You have already voted!");

        //verifica se o ID existe
        require(_candidateIndex < candidates.length, "Invalid Candidate.");

        //gravar o voto
        hasVoted[msg.sender] = true;
        candidates[_candidateIndex].voteCount += 1; 

        emit VoteConfirmed(msg.sender, candidates[_candidateIndex].name);
    }

    
    function getCandidatesCount() public view returns (uint256) {
        return candidates.length;
    }
}