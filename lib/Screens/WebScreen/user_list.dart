import 'package:covid_pass_wudasie/Components/navbar.dart';
import 'package:covid_pass_wudasie/Functions/auth_methods.dart';
import 'package:covid_pass_wudasie/Models/info_model.dart';
import 'package:covid_pass_wudasie/Screens/WebScreen/user_detail_page.dart';
import 'package:flutter/material.dart';
import '../../Models/user_model.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({Key? key}) : super(key: key);

  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  TextEditingController controller = TextEditingController();
  final AuthMethods _authMethods = AuthMethods();
  Future<List<UserModel?>>? future;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Navbar(
            size: size,
            controller: controller,
            onPressed: () {
              if (controller.text.isNotEmpty) {
                future = _authMethods.getUsers(query: controller.text);
              }
              setState(() {});
            },
          ),
          Expanded(
            child: FutureBuilder<List<UserModel?>>(
              future: future ?? _authMethods.getUsers(),
              builder: ((context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                  case ConnectionState.active:
                    return const Center(child: CircularProgressIndicator());
                  case ConnectionState.done:
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    }
                    List<UserModel?>? list = snapshot.data;
                    return Container(
                      padding: const EdgeInsets.symmetric(vertical: 26.0),
                      width: size.width * .4,
                      child: ListView.builder(
                        itemCount: list!.length,
                        itemBuilder: ((context, index) {
                          return ListTile(
                            isThreeLine: true,
                            title: Text(list[index]!.name),
                            subtitle: Text(
                              list[index]!.email + " " + list[index]!.id,
                            ),
                            trailing: TextButton(
                              onPressed: () {},
                              child: const Text("Edit"),
                            ),
                            onTap: () async{
                              UserInfo? userInfo = await AuthMethods().getUserInfo(list[index]!.email, list[index]!.uid);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: ((context) =>
                                      DetailUser(userModel: list[index], userInfo: userInfo,)),
                                ),
                              );
                            },
                          );
                        }),
                      ),
                    );
                }
              }),
            ),
          )
        ],
      ),
    );
  }
}
