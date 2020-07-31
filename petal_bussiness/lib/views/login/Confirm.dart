import 'package:flutter/material.dart';
import 'package:petal_bussiness/Firebase/LoginFunction.dart';
import 'package:petal_bussiness/Provider/LoginProvider.dart';
import 'package:petal_bussiness/Widgets/CustomFlatButton.dart';
import 'package:provider/provider.dart';

import 'CheckUser.dart';

class Confirm extends StatefulWidget {
  final phone;

  Confirm({this.phone});

  @override
  _ConfirmState createState() => _ConfirmState();
}

class _ConfirmState extends State<Confirm> {
  TextEditingController codeController = TextEditingController();
  final GlobalKey<FormState> key = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoginProvider>(context, listen: false);
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Form(
        key: key,
        child: Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: codeController,
                onTap: () {
                  key.currentState.reset();
                },
                obscureText: true,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'XXXXXX',
                  labelText: 'Conformational Code',
                  alignLabelWithHint: true,
                  prefixIcon: Icon(Icons.security),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value.length != 6) return "Invalid Code";
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              CustomFlatButton(
                onTap: () async {
                  if (key.currentState.validate()) {
                    signInWithPhoneNumber(
                      codeController.text,
                      provider.verifyId,
                    ).then(
                      (value) {
                        if (value) {
                          checkUser(context, widget.phone);
                        } else {
                          scaffoldKey.currentState.showSnackBar(
                            SnackBar(
                              content: Text(
                                'Some Error Occurred',
                                style: TextStyle(color: Colors.white38),
                              ),
                              backgroundColor: Colors.black38,
                            ),
                          );
                        }
                      },
                    );
                  }
                },
                text: 'Confirm',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
