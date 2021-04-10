import 'package:jogodavelha/models/User.dart';

///Usuário logado na sessão atual.
///Poderia ser feito com o FirebaseAuth, mas precisávamos de uma instância
///de classe User, semelhante ao que está no firestore. Essa foi a forma mais rápida
///e eficiente de obter essas informações.
class CurrentUser extends User{
  /* Esse carinha é estático, logo, está visível em toda a aplicação.
     Ele é nossa refrência em memória para o usuário da sessão atual.
     Cuidado pq ele vai ser usado em vários locais! Use-o com responsabilidade.
   */
  static User user;
}