import 'package:jogodavelha/services/Api.dart';
import '../models/RecentMatches.dart';
import 'CurrentUser.dart';

class RecentMatch{
  static List<RecentMatches> listRecentMatches =[];


  static getMacthes() async {
    var result = await Api.getMatches(CurrentUser.user);
    if (result != null) {
      for (int i = 0; i < result.length; i++) {
        var resultplayer1 = await Api.getUser(result[i].player1Id);
        var resultplayer2 = await Api.getUser(result[i].player2Id);
        if(resultplayer1 != null && resultplayer2 != null && result[i] != null) {
          var obj = new RecentMatches(result[i], resultplayer1, resultplayer2);
          if(!listRecentMatches.contains(obj)){
            listRecentMatches.add(obj);
          }
        }
      }
    }
  }
}