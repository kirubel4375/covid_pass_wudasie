import 'package:covid_pass_wudasie/Components/navbar.dart';
import 'package:covid_pass_wudasie/Constants/text_styles.dart';
import 'package:covid_pass_wudasie/Functions/auth_methods.dart';
import 'package:covid_pass_wudasie/Models/user_model.dart';
import 'package:covid_pass_wudasie/Screens/WebScreen/user_list.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import '../../Models/info_model.dart';

class DetailUser extends StatefulWidget {
  const DetailUser({Key? key, this.userModel, this.userInfo}) : super(key: key);
  final UserModel? userModel;
  final UserInfo? userInfo;

  @override
  State<DetailUser> createState() => _DetailUserState();
}

class _DetailUserState extends State<DetailUser> {
  String newTestResult = "Negative";
  bool isLoading = false;
  String dateFormater(int value) {
    if (value < 10) {
      return "0$value";
    }
    return value.toString();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    TextEditingController controller = TextEditingController();
    return Scaffold(
      body: LoadingOverlay(
        isLoading: isLoading,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Navbar(
              size: size,
              controller: controller,
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 30.0),
              width: size.width * .4,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            "name",
                            style: kGreyText,
                          ),
                          Text(
                            widget.userModel!.name,
                            style: kNormalStyle,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 23.0,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text(
                              "email",
                              style: kGreyText,
                            ),
                            Text(
                              widget.userModel!.email,
                              style: kNormalStyle,
                            ),
                          ]),
                      const SizedBox(
                        height: 23.0,
                      ),
                      widget.userInfo?.last_tested != null
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Text(
                                  "last tested ",
                                  style: kGreyText,
                                ),
                                Text(
                                  dateFormater(widget.userInfo!.last_tested!
                                          .toDate()
                                          .day) +
                                      "/" +
                                      dateFormater(widget.userInfo!.last_tested!
                                          .toDate()
                                          .month) +
                                      "/" +
                                      widget.userInfo!.last_tested!
                                          .toDate()
                                          .year
                                          .toString(),
                                  style: kNormalStyle,
                                ),
                              ],
                            )
                          : Center(
                              child: Text(
                                widget.userModel!.name +
                                    " didn't took a test yet",
                                style: kNormalStyle,
                              ),
                            ),
                      const SizedBox(
                        height: 23.0,
                      ),
                      widget.userInfo?.last_tested != null
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Text(
                                  "last test result ",
                                  style: kGreyText,
                                ),
                                Text(
                                  widget.userInfo!.testresult ?? false
                                      ? "Negative"
                                      : "Positive",
                                  style: TextStyle(
                                    color: widget.userInfo!.testresult ?? false
                                        ? Colors.green
                                        : Colors.red,
                                    fontSize: 19.0,
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ],
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: size.width * .6,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text("New Result"),
                  DropdownButton<String>(
                    items: const [
                      DropdownMenuItem(
                        child: Text("Negative"),
                        value: "Negative",
                      ),
                      DropdownMenuItem(
                        child: Text("Positive"),
                        value: "Positive",
                      ),
                    ],
                    value: newTestResult,
                    onChanged: (value) {
                      setState(() {
                        newTestResult = value!;
                      });
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isLoading = true;
                      });
                      AuthMethods().setUserInfo(widget.userModel!.email,
                          widget.userModel!.uid, newTestResult);
                      setState(() {
                        isLoading = false;
                      });
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => const UserListPage()),
                        ),
                      );
                    },
                    child: const Text("submit"),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
