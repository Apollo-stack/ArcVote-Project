// SPDX-License-Identifier: MIT
pragma solidity 0.8.19; // Versão segura para evitar erros de Gas

contract ArcVote {

    struct Candidato {
        string nome;  
        uint256 contaVotos; 
    }

    Candidato[] public candidatos; 
    
    mapping (address => bool) public jaVotou; 

    // Evento para avisar o site
    event votoComputado(address eleitor, string nomeCandidato);

    constructor (){
        // Criando os candidatos iniciais
        candidatos.push(Candidato("ArcToken", 0));
        candidatos.push(Candidato("Matic", 0));
        candidatos.push(Candidato("PolkaDot", 0));
        candidatos.push(Candidato("USDC", 0));
    }

    function votar (uint256 _candidatoIndex) public {
        
        require(!jaVotou[msg.sender], "Apenas um voto por carteira é aceito!"); 

        require(_candidatoIndex < candidatos.length, "Token invalido.");

        // Atualizando os dados
        jaVotou[msg.sender] = true;
        candidatos[_candidatoIndex].contaVotos += 1; 

        // Passando os dados reais para o evento
        emit votoComputado(msg.sender, candidatos[_candidatoIndex].nome);
    }
}