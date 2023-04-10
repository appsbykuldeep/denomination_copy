import 'package:denomination_app/constants/custom_libs.dart';

class StringDropdown extends StatelessWidget {
  final List<String> itemslist;
  final String? selectedvalue;
  final String labletext;
  final ValueChanged<String> onchange;
  final EdgeInsetsGeometry? margin;
  final bool expanded;
  final bool setfistvalue;
  final double? height;
  final double? width;
  final BoxBorder? outlineborder;
  final FocusNode? focusNode;

  const StringDropdown({
    Key? key,
    required this.itemslist,
    required this.onchange,
    this.selectedvalue,
    this.labletext = "",
    this.expanded = true,
    this.setfistvalue = false,
    this.height,
    this.width,
    this.outlineborder,
    this.focusNode,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isinList = false;

    if (selectedvalue != null) {
      if (itemslist.contains(selectedvalue)) {
        isinList = true;
      }
    }
    String? selectval = isinList
        ? selectedvalue
        : itemslist.isNotEmpty
            ? itemslist[0]
            : null;

    return Container(
      margin: margin,
      height: height,
      width: width,
      child: DropdownButtonFormField<String>(
        focusNode: focusNode,
        isExpanded: expanded,
        value: selectval,
        iconEnabledColor: Get.theme.primaryColor,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          labelText: labletext,
          labelStyle: TextStyle(
            color: Get.theme.colorScheme.primary.withOpacity(0.65),
            fontSize: 14,
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Get.theme.colorScheme.primary.withOpacity(.5),
                  width: 1)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Get.theme.colorScheme.primary.withOpacity(.3),
                  width: 0.8)),
          disabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
        ),
        items: itemslist
            .toSet()
            .map((e) => DropdownMenuItem<String>(
                  value: e,
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    e,
                  ),
                ))
            .toList(),
        onChanged: (value) => onchange(value!),
      ),
    );
  }
}
