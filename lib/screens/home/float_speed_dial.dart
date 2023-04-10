import 'package:denomination_app/constants/custom_libs.dart';
import 'package:denomination_app/constants/find_ctrl.dart';
import 'package:denomination_app/dialogues/show_save_remark.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

final _denomination = FindCtrl.denomination;

class FloatSpeedDial extends StatelessWidget {
  const FloatSpeedDial({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SpeedDial(
        openCloseDial: _denomination.isDialOpen,
        visible: _denomination.homeGrandTotal.value > 0,
        icon: Icons.bolt,
        children: [
          SpeedDialChild(
            label: "Clear",
            child: const Icon(Icons.restart_alt),
            onTap: _denomination.resetHomeDenomination,
          ),
          SpeedDialChild(
            label: "Share",
            child: const Icon(Icons.share),
            onTap: _denomination.shareDenomination,
          ),
          SpeedDialChild(
            label: "Save",
            child: const Icon(Icons.save_alt),
            onTap: () {
              _denomination.remarkCtrl.text = _denomination.deno.remark;
              showSaveRemarkDialogue();
            },
          ),
        ],
      ),
    );
  }
}
