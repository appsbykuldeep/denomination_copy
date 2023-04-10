import 'package:auto_size_text/auto_size_text.dart';
import 'package:denomination_app/constants/assets.dart';
import 'package:denomination_app/constants/custom_libs.dart'
    hide ContextExtensionss;
import 'package:denomination_app/constants/find_ctrl.dart';
import 'package:denomination_app/extenstions/num_ext.dart';
import 'package:denomination_app/extenstions/string_ext.dart';
import 'package:denomination_app/screens/home/denomination_card.dart';
import 'package:denomination_app/screens/home/float_speed_dial.dart';
import 'package:denomination_app/screens/home/home_options.dart';
import 'package:denomination_app/widgets/ink_well_trans.dart';

final _denomination = FindCtrl.denomination;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const FloatSpeedDial(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            actions: const [
              HomeOptions(),
            ],
            expandedHeight: 150,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.fromLTRB(8, 0, 5, 8),
              title: Focus(
                focusNode: _denomination.totalFocus,
                child: Obx(
                  () => Visibility(
                    visible: _denomination.homeGrandTotal.value != 0,
                    replacement: Text(
                      "Denomination",
                      style: context.textTheme.titleLarge,
                    ),
                    child: const _HeadGrandTotal(),
                  ),
                ),
              ),
              background: Image.asset(
                Assets.currencyBanner,
                fit: BoxFit.cover,
                colorBlendMode: BlendMode.dstIn,
                color: Get.isDarkMode ? Colors.white60 : null,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(top: 8, bottom: 30),
            sliver: Obx(
              () => SliverAnimatedList(
                key: UniqueKey(),
                itemBuilder: (context, index, animation) {
                  return DenominationCard(
                    onEditingComplete: () {
                      _denomination.focusonNex(index);
                    },
                    data: _denomination.homeDenomination[index],
                    onCountChange: () {
                      _denomination.setHomeGrandTotal();
                    },
                  );
                },
                initialItemCount: _denomination.homeDenomination.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeadGrandTotal extends StatelessWidget {
  const _HeadGrandTotal();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        20.heightBox,
        Text(
          "Total Amount",
          style: context.textTheme.titleSmall,
        ),
        InkWellTrans(
          onTap: () {
            _denomination.homeGrandTotal.value.gtCurrencyText.speak();
          },
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: Obx(
              () => Text(
                _denomination.homeGrandTotal.value.gtCurrencyText,
                style: context.textTheme.titleMedium,
                key: ValueKey(
                    "${_denomination.homeGrandTotal.value}HomeGrandTotal"),
              ),
            ),
          ),
        ),
        InkWellTrans(
          onTap: () {
            "${_denomination.homeGrandTotal.value.toInt().gtSpelling} only/-"
                .speak();
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Obx(
              () => AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: AutoSizeText(
                  ("${_denomination.homeGrandTotal.value.toInt().gtSpelling} only/-")
                      .gtProperCase,
                  style: Get.textTheme.bodySmall?.copyWith(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: Get.isDarkMode ? kdwhite : kdblack,
                  ),
                  key: ValueKey(
                      "${_denomination.homeGrandTotal.value}HomeGrandTotalSTR"),
                  maxLines: 2,
                  minFontSize: 8,
                  maxFontSize: 11,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

