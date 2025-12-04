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
        // Pode adicionar ou remover quantos quiser aqui agora!
        candidatos.push(Candidato("ArcToken", 0));
        candidatos.push(Candidato("Matic", 0));
        candidatos.push(Candidato("PolkaDot", 0));
        candidatos.push(Candidato("USDC", 0));
        candidatos.push(Candidato("Bitcoin", 0)); // Exemplo novo
    }

    function votar (uint256 _candidatoIndex) public {
        require(!jaVotou[msg.sender], "Apenas um voto por carteira!");
        require(_candidatoIndex < candidatos.length, "Token invalido.");

        jaVotou[msg.sender] = true;
        candidatos[_candidatoIndex].contaVotos += 1; 

        emit votoComputado(msg.sender, candidatos[_candidatoIndex].nome);
    }

    // --- NOVA FUNÇÃO ---
    // Essa função permite o site descobrir o tamanho da lista (length)
    function contarCandidatos() public view returns (uint256) {
        return candidatos.length;
    }
}