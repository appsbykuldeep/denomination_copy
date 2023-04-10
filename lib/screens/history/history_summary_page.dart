import 'package:auto_size_text/auto_size_text.dart';
import 'package:denomination_app/constants/custom_libs.dart';
import 'package:denomination_app/constants/find_ctrl.dart';
import 'package:denomination_app/extenstions/num_ext.dart';
import 'package:denomination_app/extenstions/string_ext.dart';
import 'package:denomination_app/models/basic/denomination_model.dart';
import 'package:denomination_app/models/basic/saved_denominations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

final _localdb = FindCtrl.localdb;
final _denomination = FindCtrl.denomination;

class HistorySummaryPage extends StatelessWidget {
  const HistorySummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("History"),
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => Column(
            children: _localdb.savedDenominatons
                .mapIndexed((e, i) => _HistorySummaryCard(
                      data: e,
                      index: i,
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}

class _HistorySummaryCard extends StatelessWidget {
  final SavedDenomination data;
  final int index;
  const _HistorySummaryCard({required this.data, required this.index});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(data.id),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) async {
              _localdb.savedDenominatons.removeAt(index);
              await _localdb.removeSingleDeno(data);
            },
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            // label: 'Delete',
          ),
          SlidableAction(
            onPressed: (context) {
              _denomination.openEditSavedDeno(data);
            },
            backgroundColor: const Color(0xFF21B7CA),
            foregroundColor: Colors.white,
            icon: Icons.edit,
          ),
          SlidableAction(
            onPressed: (context) {
              data.shareDenomination();
            },
            backgroundColor: const Color(0xFF369e19),
            foregroundColor: Colors.white,
            icon: Icons.share,
          ),
        ],
      ),
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.fromLTRB(5, 0, 8, 8),
        child: Container(
          width: double.maxFinite,
          padding: const EdgeInsets.fromLTRB(8, 5, 10, 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                data.denoCategory,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 1.04,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  AutoSizeText(
                    (data.denominations.grandTotal).gtCurrencyText,
                    style: TextStyle(
                      fontSize: 24,
                      color: data.denoCategory.denoCategoryColor,
                      fontWeight: FontWeight.w500,
                    ),
                    minFontSize: 14,
                    maxFontSize: 24,
                  ).expand(),
                  Text(
                    data.createOn.gtcustumDateFormat("MMM dd, yyyy\nhh:ss a"),
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.blueGrey.shade600,
                    ),
                  ),
                ],
              ),
              5.heightBox,
              Visibility(
                visible: data.remark.isNotEmpty,
                child: Text(
                  data.remark,
                  style: TextStyle(
                    fontSize: 12,
                    color: Get.theme.colorScheme.secondary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
