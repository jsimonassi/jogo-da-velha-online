V1.2

Sprint1 - 17/03/2021:
(Apenas tela - sem estar funcionando)

 - Tela de Login e Criação de conta: João Victor Simonassi Farias; - OK
 - Tela de perfil: Léo Coreixas; - OK
 - Tela de busca: Gustavo Luppi; - OK
 - Componente de histórico: Bernardo; - OK
 - Componente de Menu: Piu; - OK
 - Demais componentes da home (Exceto histórico): Jonatas; - OK

 Validação 16/03.

Sprint2 - 25/03/2021:

 - Tela de jogo (Multiplayer): João Victor Simonassi Farias; - OK
 - Tornar tela de edição funcional (Com tratativas de erro): Léo Coreixas;
 - Tela de busca funcional: Gustavo Luppi;
 - Criar modelos (pasta models) e métodos da partida na Api.dart: Bernardo; - OK
 - Criar componente de item buscado (Ver melhor arquitetura para quando for amigo): Piu;
 - Tornar Home Funcional: Jonatas;

    Validação: 24/04.

Sprint3 - 01/04/2021:
  - Tornar jogo funcional no Multiplayer   =>   João Victor Simonassi;
  
  - Entender como funciona o tchat do professor e implementar os métodos necessários para envio, recebimento,
    e listener de mensagens no Api.dart. Analisar se será preciso alterar algum model, criar novas tabelas e etc.
     Se sim, falar com João Victor para ver se irá quebrar a estrutura (Se puder chegar já com a ideia pronta,
     vai ser melhor :)  => Léo Coreixas;
    
  - Agora que as partidas já estão sendo criadas, finalizar a home com a lista de partidas recentes do usuário, 
    ordenando por data. O Piu já fez os métodos de busca de partidas no Api.dart. Checar com ele em caso de problemas  => Gustavo Luppi;
  
  - Analisar, elaborar e implementar(Apenas métodos de consulta e manipulação - Api.dart - 
    Deve retornar uma lista com todos os amigos do usuário logado). Qual é a melhor estrutura para armazenar os amigos? 
    Um grafo? Uma lista? Vai ser preciso alterar algum model? Falar com João Victor, caso precise.
    Qual a melhor estrutura para armazenar quem é meu amigo? Obs: Colocar essa informação junto com a tabela usuário é ruim. =>  Bernardo;
    
  - Tornar tela de busca funcional usando os componentes que o Gustavo criou. Usar o protótipo como base (Lista de amigos só ficará pronta
        na semana que vem, então pode ser ignorada nessa sprint). O ideal é levar os dois usuários ao Lobby, mas não sei se vai ser possível
        com a estrutura atual. Obs: É interessante notificar o usuário quando um desafio for feito a ele.   =>   Piu;
  
  - Corrigir Bug ao Apagar um Lobby
        Fluxo esperado:
           1º Entar em nova partida;
           2º Um Lobby é criado (Pode validar cmg se for preciso, só marcar o horário);
           3º Outro usuário clica em nova partida;
           4º Lobby é atualizado e os dois usuários são enviados para a tela PreMatch;
           5º Lobby é apagado e partida é criada.
       
       Fluxo atual:
          1º Entar em nova partida;
          2º Um Lobby é criado;
          3º Outro usuário clica em nova partida;
          4º Lobby é atualizado e os dois usuários são enviados para a tela PreMatch;
          5º Ao tentar apagar o Lobby atual, dois novos lobbys são criados o que gera um erro em futuras partidas.
       =>  Jonatas;
  
  Validação: 01/04 (Não é mentira!!)

Sprint4 - 07/04/2021:
    Todo: Finalizar chat, FixBugs e Possíveis melhorias

Sprint5(Final) - 14/04/2021:
    Subida pra loja (Será??)