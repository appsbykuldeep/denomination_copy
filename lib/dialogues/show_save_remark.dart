import 'package:denomination_app/constants/const_data.dart';
import 'package:denomination_app/constants/custom_libs.dart';
import 'package:denomination_app/constants/find_ctrl.dart';
import 'package:denomination_app/dialogues/make_confirmation.dart';
import 'package:denomination_app/widgets/drop_down_wid.dart';

final _denomination = FindCtrl.denomination;

void showSaveRemarkDialogue() {
  Get.dialog(
    Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          padding: const EdgeInsets.fromLTRB(10, 20, 16, 32),
          decoration: BoxDecoration(
            color: Get.theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(
                    Icons.close,
                    size: 30,
                    weight: 5,
                    color: Colors.red,
                  ),
                ),
              ),
              10.heightBox,
              StringDropdown(
                labletext: "Category",
                itemslist: denoSavedCategories,
                selectedvalue: _denomination.selectedDenoCategory,
                onchange: (val) {
                  _denomination.selectedDenoCategory = val;
                },
              ),
              10.heightBox,
              TextField(
                minLines: 2,
                maxLines: 4,
                textCapitalization: TextCapitalization.sentences,
                maxLength: 50,
                controller: _denomination.remarkCtrl,
                decoration: const InputDecoration(
                    hintText: "Fill your remark(If any)",
                    counterText: '',
                    hintStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    )),
              ),
              16.heightBox,
              SizedBox(
                width: 150,
                child: ElevatedButton(
                  onPressed: () async {
                    if (!await makeconfirmation()) return;
                    Get.back();
                    _denomination.saveToLocalDb();
                  },
                  child: Text(
                    "Save",
                    style: Get.theme.textTheme.titleLarge,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
