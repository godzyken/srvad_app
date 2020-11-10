import 'package:dartdap/dartdap.dart';
import 'dart:async';



Future getConnection() async {

  final host = "ldap://SRVAD01.urbalyon.dom";
  final port = 389;
  final ssl = false;
  final bindDN = "dc=urbalyon,dc=dom";
  final password = "Magico13";
  // Create an LDAP connection object


  var connection = LdapConnection(host: host, ssl: ssl, port: port);
  // todo: Revamp this - get rid of nulls
  // connection.setProtocol(ssl, port);
  await connection.setAuthentication(bindDN, password);

  try {
    // Perform search operation

    var base = "dc=urbalyon,dc=dom";
    var filter = Filter.present("objectClass");
    var attrs = ["dc", "objectClass"];

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
    // Close the connection when finished with it
    await connection.close();
  }
}

/*

² 1²A9879879J7
  try
  =^pè-o{
    // Perform search operationr
ut
    var base = "dc=urbalyon,dc=dom";
    var filter = Filter.present("objectClass");
    var attrs = ["dc", "objectClass"];

    var count = 0;

    var searchResult = await _ldapConnection.search(base, filter, attrs);
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
    print("Exception: $e");
  } finally {
    // Close the connection when finished with it
    await connection.close();
  }



(&(objectClass=user)(sAMAccountName=yourUserName)
(memberof=CN=YourGroup,OU=Users,DC=YourDomain,DC=com))
(&(objectClass=user)(sAMAccountName=yourUserName)
(memberof=CN=YourGroup,OU=Users,DC=YourDomain,DC=com))

// line breaks for legibility only

https://login.microsoftonline.comp/{tenant}/oauth2/authorize?
client_id=0000xx00-00x0-00xx-0xxx0000000x
&response_type=code
&redirect_uri=http%3A%2F%2Flocalhost%3A12345
&response_mode=query
&resource=https%3A%2F%2Fservice.contoso.com%2F
&state=12345

https://login.microsoftonline.comp/{tenant}/oauth2/v2.0/authorize?
client_id=0000xx00-00x0-00xx-0xxx0000000x
&response_type=token
&redirect_uri=http%3A%2F%2Flocalhost%2Fmyapp%2F
&scope=https%3A%2F%2Fgraph.microsoft.com%2Fuser.read
&response_mode=fragment
&state=12345&nonce=678910
&prompt=none
&domain_hint=oraganizations
&login_hint=myuser@mycompany.com

https%3A%2F%2Fgraph.microsoft.com%2Fuser.read%20offline_access

var host = "ip_address";
var ssl = false;
var port = null;
var bindDN = "accountname@domain.name";
var password = "password";

var connection = new LdapConnection(host: host);
connection.setProtocol(ssl, port);
connection.setAuthentication(bindDN, password);

GET https://graph.microsoft.com/v1.0/groups/{id}/members?$select=id,displayName,description,createdDateTime,deletedDateTime,homepage,loginUrl HTTP/1.1

{
"@odata.context":"https://graph.microsoft.com/v1.0/$metadata#directoryObjects(id,displayName,description,createdDateTime,deletedDateTime,homepage,loginUrl)",
    "value":[
        {
            "@odata.type":"#microsoft.graph.user",
            "id":"69d035a3-29c9-469f-809d-d21a4ae69e65",
            "displayName":"Jane Dane",
            "createdDateTime":"2019-09-18T09:06:51Z",
            "deletedDateTime":null
        },
        {
            "@odata.type":"#microsoft.graph.group",
            "id":"c43a7cc9-2d95-44b6-bf6a-6392e41949b4",
            "displayName":"Group 1",
            "description":null,
            "createdDateTime":"2019-10-24T01:34:35Z",
            "deletedDateTime":null
        },
        {
            "@odata.type":"#microsoft.graph.device",
            "id": "d282309e-f91d-43b6-badb-9e68aa4b4fc8",
            "accountEnabled":null,
            "deviceId":null,
            "displayName":null,
            "operatingSystem":null,
            "operatingSystemVersion":null
        }
    ]
}
*/
