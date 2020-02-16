import 'package:eshop/models/user.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  User user;

  ProfileScreen(this.user);

  @override
  _ProfileScreenState createState() => new _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext build) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).accentColor,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        title: Text(
          "Profile",
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width,
            color: Theme.of(context).accentColor,
            child: Column(
              children: <Widget>[
                Hero(
                  tag: widget.user.userImageURL,
                  child: CircleAvatar(
                    radius: 100.0,
                    backgroundImage: ExactAssetImage(widget.user.userImageURL),
                  ),
                ),
                SizedBox(height: 20.0),
                Text("${widget.user.fName} ${widget.user.lName}",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20.0,
                        color: Theme.of(context).primaryColor)),
                Text("${widget.user.city}, ${widget.user.state}",
                    style: TextStyle(color: Theme.of(context).primaryColor)),
              ],
            ),
          ),
          Text("- WIP -"),
          Container(
            margin: EdgeInsets.only(bottom: 20.0),
            child: RaisedButton(
              onPressed: () => null,
              color: Theme.of(context).accentColor,
              child: Text(
                "Edit",
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
