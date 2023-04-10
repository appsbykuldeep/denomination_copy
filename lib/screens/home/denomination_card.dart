import 'package:auto_size_text/auto_size_text.dart';
import 'package:denomination_app/constants/custom_libs.dart';
import 'package:denomination_app/extenstions/num_ext.dart';
import 'package:denomination_app/extenstions/string_ext.dart';
import 'package:denomination_app/models/basic/denomination_model.dart';
import 'package:denomination_app/widgets/ink_well_trans.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class DenominationCard extends StatefulWidget {
  final DenominationModel data;
  final Function() onEditingComplete;
  final Function() onCountChange;
  const DenominationCard(
      {super.key,
      required this.data,
      required this.onCountChange,
      required this.onEditingComplete});

  @override
  State<DenominationCard> createState() => _DenominationCardState();
}

class _DenominationCardState extends State<DenominationCard> {
  late TextEditingController controller;

  final notecount = 0.obs;
  final totalAmount = 0.obs;

  @override
  void initState() {
    controller = TextEditingController(
      text: widget.data.currencyCount != 0
          ? widget.data.currencyCount.toString()
          : null,
    );
    notecount.value = widget.data.currencyCount.toInt();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      onAnyChange(initPage: true);
    });

    super.initState();
  }

  void onAnyChange({
    bool initPage = false,
  }) {
    notecount.value = int.tryParse(controller.text) ?? 0;
    totalAmount.value = (notecount.value * widget.data.currencyAmount).toInt();
    widget.data.currencyCount = notecount.value;
    widget.data.totalAmount = totalAmount.value;
    if (!initPage) {
      widget.onCountChange();
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 3, 8, 5),
      child: Row(
        children: [
          ExcludeFocus(
            child: InkWellTrans(
              onTap: () {
                widget.data.currencyAmount.gtCurrencyText.speak();
              },
              child: AutoSizeText(
                widget.data.currencyAmount.gtCurrencyText,
                style: Get.textTheme.titleLarge,
                maxLines: 1,
              ),
            ).expand(),
          ),
          Text(
            " x ",
            style: Get.textTheme.titleLarge,
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 2.5,
            ),
            child: Obx(
              () => TextField(
                focusNode: widget.data.node,
                controller: controller,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                onEditingComplete: widget.onEditingComplete,
                maxLines: 1,
                minLines: 1,
                cursorWidth: 1.5,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\-?[0-9]*$')),
                ],
                onChanged: (val) {
                  onAnyChange();
                },
                decoration: InputDecoration(
                  hintText: widget.data.exampleStr,
                  counterText: '',
                  hintStyle: Get.textTheme.bodySmall?.copyWith(
                    color: Colors.blueGrey.shade300,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 0.25,
                      color: Get.isDarkMode ? kdwhite : kdblack,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 0.7, color: context.primaryColor),
                  ),
                  disabledBorder: InputBorder.none,
                  border: InputBorder.none,
                  suffixIconConstraints: const BoxConstraints(
                    maxWidth: 30,
                  ),
                  suffixIcon: Visibility(
                    visible: notecount.value != 0,
                    child: ExcludeFocus(
                      child: InkWell(
                        onTap: () {
                          controller.clear();
                          onAnyChange();
                        },
                        child: const Padding(
                          padding: EdgeInsets.fromLTRB(3, 10, 4, 10),
                          child: Icon(
                            Icons.cancel,
                            size: 16,
                            // color: Colors.blueAccent,
                          ),
                        ),
                      ),
                    ),
                  ),
                  contentPadding: const EdgeInsets.fromLTRB(8, 5, 5, 3),
                  constraints: const BoxConstraints.tightFor(height: 45),
                ),
              ),
            ),
          ).expand(flex: 2),
          Text(
            " = ",
            style: Get.textTheme.titleLarge,
          ),
          ExcludeFocus(
            child: InkWellTrans(
              onTap: () {
                totalAmount.value.gtCurrencyText.speak();
              },
              child: Align(
                alignment: Alignment.centerLeft,
                child: Obx(
                  () => AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: AutoSizeText(
                      totalAmount.value.gtCurrencyText,
                      key: ValueKey("${totalAmount.value} Total"),
                      style: Get.textTheme.titleLarge,
                      textAlign: TextAlign.left,
                      maxLines: 1,
                    ),
                  ),
                ),
              ),
            ).expand(flex: 2),
          ),
        ],
      ),
    );
  }
}
