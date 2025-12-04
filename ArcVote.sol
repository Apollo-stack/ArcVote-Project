// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract ArcVote {

    struct Candidato {
        string nome;
        uint256 contaVotos; 
    }

    Candidato[] public candidatos; 
    
    mapping (address => bool) public jaVotou;
    
    event votoComputado(address eleitor, string nomeCandidato);

    constructor (){

        candidatos.push(Candidato("USDC (Circle)", 0));
        candidatos.push(Candidato("EURC (Euro)", 0));
        candidatos.push(Candidato("Arc Native Token", 0));
        candidatos.push(Candidato("Wrapped BTC", 0));
        candidatos.push(Candidato("Wrapped ETH", 0));
    }

    function votar (uint256 _candidatoIndex) public {
        require(!jaVotou[msg.sender], "Apenas um voto por carteira!");
        require(_candidatoIndex < candidatos.length, "Token invalido.");

        jaVotou[msg.sender] = true;
        candidatos[_candidatoIndex].contaVotos += 1; 

        emit votoComputado(msg.sender, candidatos[_candidatoIndex].nome);
    }

    
    function contarCandidatos() public view returns (uint256) {
        return candidatos.length;
    }
}