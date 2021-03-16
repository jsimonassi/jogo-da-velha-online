import 'package:jogodavelha/models/User.dart';

class CurrentUser extends User{
  /* Esse carinha é estático, logo, está visível em toda a aplicação.
     Ele é nossa refrência em memória para o usuário da sessão atual.
     Cuidado pq ele vai ser usado em vários locais! Use-o com responsabilidade.
   */
  static User user;
}