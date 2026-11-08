import 'package:fa4_reverse_engineering/models/users.dart';

class UserData {
 UserData._();

 static final List<FireflyUser> users = [
    FireflyUser(
      firstName: 'Cielo',
      lastName: 'Mercado',
      username: 'cc',
      password: 'cc',
    ),
    FireflyUser(
      firstName: 'Jeo',
      lastName: 'Ong',
      username: 'jeoOnGangster',
      password: 'JeoLeePbb',
    ),
    FireflyUser(
      firstName: 'Gehlee', 
      lastName: 'Dangca', 
      username: 'gehleeDangca', 
      password: 'gehleeDangca123')
 ];
 static FireflyUser? activeUser;


 static FireflyUser? login(String username, String password) {
    for (var user in users) {
      if (user.username == username && user.password == password) {
        activeUser = user;
        return user;
      }
    }
    return null;
  }

  static bool userExists(String username) {
    for (var user in users) {
      if (user.username == username) {
        return true;
      }
    }
    return false;
  }

  static bool register(FireflyUser newUser) {
    for (var user in users) {
      if (user.username == newUser.username) {
        return false; 
      }
    }
    users.add(newUser);
    return true;
  }

  static void logout() {
    activeUser = null;
    }
}