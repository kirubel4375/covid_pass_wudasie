import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../Components/navbar.dart';
import '../user_list.dart';

class WebHome extends StatefulWidget {
  const WebHome({Key? key}) : super(key: key);

  @override
  State<WebHome> createState() => _WebHomeState();
}

class _WebHomeState extends State<WebHome> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (kDebugMode) print(size.width);
    return Scaffold(
      body: Container(
        height: size.height,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Navbar(
              size: size,
              controller: _controller,
              onPressed: () {},
              onPressedUpdate: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const UserListPage()));
              },

            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
