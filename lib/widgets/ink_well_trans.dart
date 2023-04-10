import 'package:denomination_app/constants/custom_libs.dart';

class InkWellTrans extends StatelessWidget {
  final Function()? onTap;
  final Widget? child;
  const InkWellTrans({super.key, this.onTap, this.child});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      overlayColor:
          MaterialStateProperty.resolveWith((states) => Colors.transparent),
      onTap: onTap,
      child: child,
    );
  }
}
