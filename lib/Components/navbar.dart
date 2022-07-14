import 'package:covid_pass_wudasie/Screens/WebScreen/Home/homepage.dart';
import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  const Navbar({
    Key? key,
    required this.size,
    required TextEditingController controller,
    this.onPressed,
    this.onPressedUpdate,
    this.onPressedAdd,
    this.onPressedLink1,
  })  : _controller = controller,
        super(key: key);

  final Size size;
  final TextEditingController _controller;
  final Function()? onPressed;
  final Function()? onPressedUpdate;
  final Function()? onPressedAdd;
  final Function()? onPressedLink1;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30.0),
      padding: const EdgeInsets.symmetric(horizontal: 45),
      height: 38.7,
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const WebHome(),
                ),
                ((route) => false),
              );
            },
            child: const Text(
              "Title",
              style: TextStyle(
                fontSize: 30,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          const Spacer(),
          SizedBox(
            width: size.width * .289,
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: "search by name or email...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                ),
              ),
              autofocus: true,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(fixedSize: const Size(100, 40.8)),
            onPressed: onPressed,
            child: const Text(
              "search",
              style: TextStyle(fontSize: 17.0),
            ),
          ),
          const Spacer(flex: 2),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextButton(
              onPressed: onPressedLink1,
              child: const Text("Link1"),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextButton(
              onPressed: onPressedUpdate,
              child: const Text("Update"),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextButton(
              onPressed: onPressedAdd,
              child: const Text("Add new"),
            ),
          ),
        ],
      ),
    );
  }
}
