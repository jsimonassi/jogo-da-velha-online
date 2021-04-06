V1.3

Sprint1 - 17/03/2021:
(Apenas tela - sem estar funcionando)

 - Tela de Login e Criação de conta: João Victor Simonassi Farias;
 - Tela de perfil: Léo Coreixas;
 - Tela de busca: Gustavo Luppi;
 - Componente de histórico: Bernardo;
 - Componente de MenuVictor Patrício;
 - Demais componentes da home (Exceto histórico): Jonatas;

 Validação 16/03.

Sprint2 - 25/03/2021:

 - Tela de jogo (Multiplayer): João Victor Simonassi Farias;
 - Tornar tela de edição funcional (Com tratativas de erro): Léo Coreixas;
 - Tela de busca funcional: Gustavo Luppi;
 - Criar modelos (pasta models) e métodos da partida na Api.dart: Bernardo;
 - Criar componente de item buscado (Ver melhor arquitetura para quando for amigo): Victor Patrício;
 - Tornar Home Funcional: Jonatas;

    Validação: 24/04.

Sprint3 - 01/04/2021:
  - Tornar jogo funcional no Multiplayer   =>   João Victor Simonassi;
  
  - Entender como funciona o chat do professor e implementar os métodos necessários para envio, recebimento,
    e listener de mensagens no Api.dart. Analisar se será preciso alterar algum model, criar novas tabelas e etc.
     Se sim, falar com João Victor para ver se irá quebrar a estrutura (Se puder chegar já com a ideia pronta,
     vai ser melhor :)  => Léo Coreixas;
    
  - Agora que as partidas já estão sendo criadas, finalizar a home com a lista de partidas recentes do usuário, 
    ordenando por data. Victor Patrício já fez os métodos de busca de partidas no Api.dart. Checar com ele em caso de problemas  => Gustavo Luppi;
  
  - Analisar, elaborar e implementar(Apenas métodos de consulta e manipulação - Api.dart - 
    Deve retornar uma lista com todos os amigos do usuário logado). Qual é a melhor estrutura para armazenar os amigos? 
    Um grafo? Uma lista? Vai ser preciso alterar algum model? Falar com João Victor, caso precise.
    Qual a melhor estrutura para armazenar quem é meu amigo? Obs: Colocar essa informação junto com a tabela usuário é ruim. =>  Bernardo;
    
  - Tornar tela de busca funcional usando os componentes que o Gustavo criou. Usar o protótipo como base (Lista de amigos só ficará pronta
        na semana que vem, então pode ser ignorada nessa sprint). O ideal é levar os dois usuários ao Lobby, mas não sei se vai ser possível
        com a estrutura atual. Obs: É interessante notificar o usuário quando um desafio for feito a ele.   => Victor Patrício;
  
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

Sprint4 - 12/04/2021:
    
    - Criar opção de logout na tela de Editar Conta (Pode ser apenas um botão abaixo do salvar escrito "sair"... algo do tipo).
    Lembrar de resetar variáveis estáticas e deslogar do firebase auth: Léo Coreixas
    
    - Criar Shared Preferences para login automático (Lembrar de atualizar variáveis estáticas antes de iniciar o App).
    Além disso, quando o usuário possui um nome ou nick muito grande, o App quebra o layout todo. Deve ter algum atributo do text
    que diminui a fonte ou faz o texto escrollar pro lado quando ultrapassa um tamanho x. Se sobrar tempo, pesquisar sobre esse 
    atributo aí: Gustavo Luppi
    
    - Verificar e implementar (Se possível) o fluxo de levar um jogador para a tela de Lobby direto da tela de pesquisa.
        Seu rival deve ser avisado do desafio, mas não queria fazer com push notifications pq vai dar muito trabalho e acho que
        uma semana não é suficiente pra deixar 100%. Pensei em criar atributos na tabela de user pra dizer quando ele estiver online,
        aí só vai ser possível desafiar um usuário que esteja online. Podemos criar um listener na home pra receber o desafio.
        Aceito sugestões. - Jonatas;
    
    -  Jogar e testar todos os fluxos do App encontrando e corrigindo (Se possível) eventuais bugs. Fazer os fluxos mais esquisitos que
    o professor pode imaginar fazer - Bernardo e Piu;
    
    - O método getUsersByKey no Api.dart está fazendo essa busca:
    QuerySnapshot querySnapshot = await Firestore.instance.collection("users").where("name", isGreaterThanOrEqualTo: key).getDocuments();
    A ideia de usar isGreaterThanOrEqualTo é conseguir buscar uma substring da chave passada. 
    Exemplo: Se o nome do usuário é "Bernardo" e eu digito "Be" e dou o enter, o app deveria ser capaz de me retornar o 
    usuário Bernardo e todos os outros que começam com "Be", mas ele dá uma resposta bem zoada. Se não encontrarmos nada melhor,
    vai ficar assim mesmo, mas a pesquisa é válida.
    
    - Criar fluxo de adicionar novo amigo e enviar push notifications sobre solicitação de amizade. Criar tela de aceite da solicitação
    e métodos para atualizar as tabelas de amigos: João Victor Simonassi.
    

Sprint5(Final) - 14/04/2021:
    Subida pra loja (Será??)