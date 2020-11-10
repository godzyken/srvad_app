import 'package:flutter/material.dart';
import 'package:srvad_app/core/models/user_info_entity.dart';
import 'package:srvad_app/core/services/ldap_service.dart';
import 'package:srvad_app/core/services/user_service.dart';


class DatabaseTableTest extends StatefulWidget {
  DatabaseTableTest(): super();
  final String title = 'Flutter Data Table';
  @override
  _DatabaseTableTestState createState() => _DatabaseTableTestState();
}

class _DatabaseTableTestState extends State<DatabaseTableTest> {
  List<UserInfoEntity> _users;
  GlobalKey<ScaffoldState> _scaffoldKey;
  TextEditingController _giveNameController;
  TextEditingController _familyNameController;
  UserInfoEntity _selectUserInfoEntity;
  bool _isUpdating;
  String _titleProgress;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _users = [];
    _isUpdating = false;
    _titleProgress = widget.title;
    _scaffoldKey = GlobalKey();
    _giveNameController = TextEditingController();
    _familyNameController = TextEditingController();
  }

  // Method to update title in the AppBar Title
  _showProgress(String message) {
    setState(() {
      _titleProgress = message;
    });
  }

  _showSnackBar(context, message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message),),);
  }

  _createTable() {
    _showProgress('Creating Table...');
    UserServices.createTable().then((result) {
      if('success' == result) {
        // Table is create successfully
        _showSnackBar(context, result);
        _showProgress(widget.title);
      }
    });
  }

  _addUser() {
    if(_giveNameController.text.isEmpty || _familyNameController.text.isEmpty) {
      print('Empty Fields');
      return;
    }
    _showProgress('Adding User...');
    UserServices.addUser(_giveNameController.text, _familyNameController.text).then((result) {
      if('success' == result) {

      }
      _clearValues();
    });
  }

  _getUsers() {
    _showProgress('Fetching User...');
    UserServices.getUsers().then((result){
      if('success' == result) {
        print('la list doit avoir un $_giveNameController');
      }
    });
  }

  _updateUser() {}

  _deleteUser() {}

  // Method to clear TextField values
  _clearValues() {
    _giveNameController.text = '';
    _familyNameController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(_titleProgress),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _createTable();
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _getUsers();
            },
          ),
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: _giveNameController,
                decoration: InputDecoration.collapsed(
                  hintText: 'Give a Name',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: _familyNameController,
                decoration: InputDecoration.collapsed(
                  hintText: 'Give a FamilyName',
                ),
              ),
            ),
            // Add an update button and Cancel button
            // Show this button only when updating en user
            _isUpdating?
            Row(
              children: <Widget>[
                OutlineButton(
                  child: Text('UPDATE'),
                  onPressed: () {
                    _updateUser();
                  },
                ),
                OutlineButton(
                  child: Text('CANCEL'),
                  onPressed: () {
                    setState(() {
                      _isUpdating = false;
                    });
                    _clearValues();
                  },
                ),
              ],
            ) : Container(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getConnection();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
