import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'confirm_dialogue.dart';
import 'db/notes_database.dart';
import 'login/login.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  //
  UserName username = UserName();
  @override
  void initState() {
    super.initState();
    _loadDarkMode();
  }

  void _loadDarkMode() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'isDarkModeEnabled';
    final value = prefs.getBool(key) ?? false;
    setState(() {});
  }

  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Settings",
        ),
        backgroundColor: Colors.black,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(70),
            bottomRight: Radius.circular(70),
          ),
        ),
        toolbarHeight: 80.0, // adjust the height here
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(
                24.0,
              ),
              children: [
                ListTile(
                  onTap: () async {
                    bool answer = await showConfirmDialog(context, "Warning",
                        "This is irreversible. Your entire data will be Lost");
                    if (answer) {
                      await NotesDatabase.instance.deleteAllNotes();
                      Navigator.of(context).pop();
                    }
                  },
                  tileColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 20.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      8.0,
                    ),
                  ),
                  title: Text(
                    "Clean Data",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  subtitle: Text(
                    "This is irreversible",
                  ),
                  trailing: Icon(
                    Icons.delete,
                    size: 32.0,
                    color: Colors.black87,
                  ),
                ),
                //
                SizedBox(
                  height: 20.0,
                ),
                //
                ListTile(
                  onTap: () async {
                    String nameEditing = "";
                    String? name = await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor: Colors.grey[300],
                        title: Text(
                          "Enter new name",
                        ),
                        content: Container(
                          decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius: BorderRadius.circular(
                              12.0,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 16.0,
                          ),
                          child: TextFormField(
                            decoration: InputDecoration(
                              hintText: "Your Name(max 12 letters .)",
                              border: InputBorder.none,
                            ),
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                            maxLength: 12,
                            onChanged: (val) {
                              nameEditing = val;
                            },
                          ),
                        ),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop(nameEditing);
                            },
                            child: Text(
                              "OK",
                            ),
                          ),
                        ],
                      ),
                    );
                    if (name != null) {
                      Provider.of<UserName>(context, listen: false).name =
                          nameEditing;
                    }
                    //
                  },
                  tileColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 20.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      8.0,
                    ),
                  ),
                  title: Text(
                    "Change Name",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  subtitle: Text(
                    "Welcome {newname}",
                  ),
                  trailing: Icon(
                    Icons.change_circle,
                    size: 32.0,
                    color: Colors.black87,
                  ),
                ),
                //
                SizedBox(
                  height: 20.0,
                ),
                //
                ListTile(
                  onTap: () async {
                    bool answer = await showConfirmDialog(context, "Warning",
                        "This is irreversible. Your account and all associated data will be lost.");
                    if (answer) {
                      User? user = FirebaseAuth.instance.currentUser;
                      if (user != null) {
                        try {
                          await user.delete();
                          await NotesDatabase.instance.deleteAllNotes();
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()),
                              (Route<dynamic> route) => false);
                        } on FirebaseAuthException catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content:
                                Text(e.message ?? "Failed to delete account."),
                          ));
                        }
                      }
                    }
                  },
                  tileColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 20.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      8.0,
                    ),
                  ),
                  title: Text(
                    "Delete Account",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  subtitle: Text(
                    "This is irreversible",
                  ),
                  trailing: Icon(
                    Icons.delete_forever,
                    size: 32.0,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }
}

class UserName extends ChangeNotifier {
  String _name = "User";

  String get name => _name;

  set name(String value) {
    _name = value;
    notifyListeners();
  }
}
