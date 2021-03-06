

import 'package:dartdap/dartdap.dart';
import 'package:logging/logging.dart';

main() async {
  Logger.root.onRecord.listen((LogRecord rec) {
    print('${rec.time}: ${rec.loggerName}: ${rec.level.name}: ${rec.message}');
  });

  Logger.root.level = Level.INFO;

  var ldap = LdapConnection(
      host: 'localhost', port: 1389, bindDN: 'uid=admin', password: 'password');

  var baseDN = 'ou=people,ou=identities';
  var attrs = ['dn', 'uid', 'sn'];
  var pageSize = 100;

  // Create a control that pages through entries 'pageSize' at a time
  var simplePaged = SimplePagedResultsControl(size: pageSize);
  // sort the results based on the "sn" attribute
  var sss = ServerSideSortRequestControl([SortKey("sn")]);

  var done = false;
  int count = 0;

  while (!done)  {
    print("**** Query for $pageSize entries **** total count=$count");

    var results = await ldap.query(baseDN, '(objectclass=*)', attrs,
        controls: [simplePaged,sss]);

    await for (var entry in results.stream) {
      // uncomment if you want to see the entries. Slow...
      print("Got entry ${entry.dn} attrs = ${entry.attributes}");
      ++count;
    }

    print("LDAP result: ${results.ldapResult}");

    List<int> cookie;
    if (results.controls != null ) {
      results.controls.forEach((control) {
        print("Control $control");
        if( control is SimplePagedResultsControl) {
          if (control.isEmptyCookie  ) {
            done = true;
          } else {
            cookie = control.cookie;
          }
        }
      });

      // Update the control for the next page of results.
      // Note the DS server sets the returned page size to 0
      simplePaged = SimplePagedResultsControl(size: pageSize, cookie: cookie);
    }
  }

  await ldap.close();
}