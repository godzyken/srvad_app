import 'package:dartdap/dartdap.dart';

Future test() async {
  var host = "ip_address";
  var ssl = false;
  var port = null;
  var bindDN = "accountname@domain.name";
  var password = "password";

  var connection = new LdapConnection(host: host);
  connection.setProtocol(ssl, port);
  connection.setAuthentication(bindDN, password);

}

/*
(&(objectClass=user)(sAMAccountName=yourUserName)
(memberof=CN=YourGroup,OU=Users,DC=YourDomain,DC=com))
(&(objectClass=user)(sAMAccountName=yourUserName)
(memberof=CN=YourGroup,OU=Users,DC=YourDomain,DC=com))

var host = "ip_address";
var ssl = false;
var port = null;
var bindDN = "accountname@domain.name";
var password = "password";

var connection = new LdapConnection(host: host);
connection.setProtocol(ssl, port);
connection.setAuthentication(bindDN, password);*/
