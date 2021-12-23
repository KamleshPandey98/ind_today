import 'package:flutter/material.dart';
import '../../custom_styles.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: CustomStyles.mainParentWhiteColor,
      leading: IconButton(onPressed: (){}, icon: Image.asset("assets/images/hamburger.png")),
      title: Center(child: Image.asset("assets/images/logo.png", height: 50.0,)),
      actions: [
        IconButton(
          icon: Image.asset("assets/images/profile.png"),
          onPressed: () {  },
        )
      ],
      elevation: 0.0,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
