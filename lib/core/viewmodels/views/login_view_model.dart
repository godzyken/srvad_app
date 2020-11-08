import 'package:dartdap/dartdap.dart';
import 'package:srvad_app/core/viewmodels/views/base_model.dart';

class LoginViewModel extends BaseModel {

  String errorMessage;
  String username;
  String password;


  login() async {
    setState(true);

    var host = "192.168.2.100";
    var ssl = false;
    var port = 389;
    var bindDN = "cn=Manager,dc=urbalyon\doreem,dc=dom";
    password = "Magico13";

    var connection = new LdapConnection(host: host);
    connection.setProtocol(ssl, port);
    connection.setAuthentication(bindDN, password);

    if (connection != null) {
      await connection.open();
      try {
        var base = "dc=UrbaLyon,dc=dom";
        var filter = Filter.present(username);
        var attrs = ["dc", username];

        var count = 0;

        var searchResult = await connection.search(base, filter, attrs);
        await for (var entry in searchResult.stream) {
          // Processing stream of SearchEntry
          count++;
          print("dn: ${entry.dn}");
          // Getting all attributes returned
          for (var attr in entry.attributes.values) {
            for (var value in attr.values) { // attr.values is a Set
              print("  ${attr.name}: $value");
            }
          }

          // Getting a particular attribute

          assert(entry.attributes["dc"].values.length == 1);
          var dc = entry.attributes["dc"].values.first;
          print("# dc=$dc");
        }
        print("# Number of entries: $count");
      } catch (e) {
        print('Exception : $e');
        return e.toString();
      } finally {
        // Close the connection when finish with it
        await connection.close();
      }
    } else {
      errorMessage = connection.state.toString();
      print('Erreur message: $errorMessage');
      return connection.close();
    }
  }
}
