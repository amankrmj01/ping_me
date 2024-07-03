import 'package:flutter/material.dart';
import 'package:ping_me/pages/SigninSignout/register_details.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../components/my_logo.dart';
import '../clip_shadow.dart';
import 'login_details.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool showLogin = true;
  final color = Color.lerp(Colors.purple, Colors.white, 0.3);
  final PageController _pageController = PageController();

  bool isNull(TextEditingController controller) {
    return controller.text.isEmpty;
  }

  void toggle() {
    setState(() {
      switch (_pageController.page) {
        case 0:
          _pageController.animateToPage(1,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut);
        case 1:
          _pageController.animateToPage(0,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      body: SizedBox(
        width: context.percentWidth * 100,
        height: context.percentHeight * 100,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              top: 0,
              child: ClipShadowPath(
                clipper: Upper(),
                shadow: BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 10),
                    spreadRadius: 5),
                child: Container(
                  height: 600,
                  width: context.percentWidth * 100,
                  color: color,
                ),
              ),
            ),
            const Positioned(
              top: 100,
              child: MyLogo(
                size: 150,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 280),
              child: SizedBox(
                height: context.percentHeight * 65,
                child: PageView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  itemCount: 2,
                  itemBuilder: (
                    context,
                    index,
                  ) {
                    return index == 0
                        ? LoginDetails(
                            onTap: toggle,
                          )
                        : RegisterPage(
                            onTap: toggle,
                          );
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: IgnorePointer(
                ignoring: true,
                child: ClipShadowPath(
                  clipper: Bottom(),
                  shadow: BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, -10),
                      spreadRadius: 5),
                  child: Container(
                    width: context.percentWidth * 100,
                    color: color,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Upper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * -0.0314388, size.height * -0.0179672);
    path_0.quadraticBezierTo(size.width * -0.0353631, size.height * 0.2037198,
        size.width * -0.0366713, size.height * 0.2776155);
    path_0.cubicTo(
        size.width * 0.2124461,
        size.height * 0.3598058,
        size.width * 0.3790738,
        size.height * 0.2033761,
        size.width * 0.7045589,
        size.height * 0.2239982);
    path_0.quadraticBezierTo(size.width * 0.9342639, size.height * 0.2427871,
        size.width * 1.0281342, size.height * 0.3558418);
    path_0.lineTo(size.width * 1.0516803, size.height * 0.3566667);
    path_0.lineTo(size.width * 1.0647615, size.height * -0.0191129);
    path_0.lineTo(size.width * -0.0314388, size.height * -0.0179672);
    path_0.close();

    return path_0;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

class Bottom extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path_1 = Path();
    path_1.moveTo(size.width * 1.0223500, size.height * 1.0550111);
    path_1.quadraticBezierTo(size.width * 1.0261250, size.height * 0.9747444,
        size.width * 1.0274250, size.height * 0.9479889);
    path_1.cubicTo(
        size.width * 0.7861750,
        size.height * 0.9182333,
        size.width * 0.6248250,
        size.height * 0.9748778,
        size.width * 0.3096750,
        size.height * 0.9674000);
    path_1.quadraticBezierTo(size.width * 0.0872500, size.height * 0.9606000,
        size.width * -0.0036750, size.height * 0.9196778);
    path_1.lineTo(size.width * -0.0264750, size.height * 0.9193667);
    path_1.lineTo(size.width * -0.0391500, size.height * 1.0554333);
    path_1.lineTo(size.width * 1.0223500, size.height * 1.0550111);
    path_1.close();

    return path_1;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
