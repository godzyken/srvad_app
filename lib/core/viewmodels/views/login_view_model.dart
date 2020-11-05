import 'package:dartdap/dartdap.dart';
import 'package:srvad_app/core/viewmodels/views/base_model.dart';

class LoginViewModel extends BaseModel {

  LdapConnection _ldapConnection;

  String errorMessage;


  login() async {
    setState(true);

    var host = "192.168.2.100";
    var ssl = false;
    var port = 389;
    var bindDN = "cn=Manager,dc=urbalyon,dc=dom";
    var password = "Magico13";

    var connection = new LdapConnection(host: host, ssl: ssl, port: port);
    if (connection != null) {
      print('ok totobéné: $connection');
    } else {
      errorMessage = connection.state.toString();
      print('Erreur message: $errorMessage');
      return connection.close();
    }

    var auth = connection.setAuthentication(bindDN, password);
    if (auth != null) {
      print('authentication ok: $auth');
      print('Etat de la connection : $connection');
      return auth;
    } else {
      errorMessage = auth.toString();
      print('Erreur message: $errorMessage');
    }

    try {
      // Perform search operation

      var base = "dc=urbalyon,dc=dom";
      var filter = Filter.present("groupe");
      var attrs = ["dc", "groupe"];

      var count = 0;

      var searchResult = await connection.search(base, filter, attrs);
      await for (var entry in searchResult.stream) {
        // Processing stream of SearchEntry
        count++;
        print("dn: ${entry.dn}");

        // Getting all attributes returned

        for (var attr in entry.attributes.values) {
          for (var value in attr.values) {
            // attr.values is a Set
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
      print("Exception: $e");
    } finally {
      print('ici arrive la fin: $connection');

      // Close the connection when finished with it
      await connection.close();
    }

  }
}
