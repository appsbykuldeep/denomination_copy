import 'package:denomination_app/constants/custom_libs.dart';
import 'package:denomination_app/extenstions/localdb_ext.dart';
import 'package:denomination_app/extenstions/string_ext.dart';
import 'package:denomination_app/screens/history/history_summary_page.dart';

class HomeOptions extends StatelessWidget {
  const HomeOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: "history",
          child: OptionsRow(
            icondata: Icons.history,
            lable: "History",
          ),
        ),
        PopupMenuItem(
          value: "theme",
          child: OptionsRow(
            icondata: Get.isDarkMode ? Icons.light_mode : Icons.dark_mode,
            lable: Get.isDarkMode ? "Light Mode" : "Dark Mode",
          ),
        ),
        PopupMenuItem(
          value: "Speak",
          child: OptionsRow(
            icondata:
                isSpeakMuted ? Icons.record_voice_over : Icons.voice_over_off,
            lable: isSpeakMuted ? "Speak" : "Mute",
          ),
        ),
        const PopupMenuItem(
          value: "Support",
          child: OptionsRow(
            icondata: Icons.message,
            lable: "Need Help",
          ),
        ),
      ],
      onSelected: (val) {
        if (val == "theme") {
          Get.changeThemeMode(isLisghtTheme ? ThemeMode.dark : ThemeMode.light);
          (isLisghtTheme ? "0" : "1").boxIsLightTheme;
        }
        if (val == "history") {
          Get.to(() => const HistorySummaryPage());
        }
        if (val == "Speak") {
          (isSpeakMuted ? "0" : "1").boxMuteSpell;
        }
        if (val == "Support") {
          whatsappMsj();
        }
      },
    );
  }
}

class OptionsRow extends StatelessWidget {
  final IconData icondata;
  final String lable;
  const OptionsRow({Key? key, required this.icondata, required this.lable})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          icondata,
          color: context.primaryColor,
          size: 20,
        ),
        2.widthBox,
        Text(
          lable,
          style: Get.textTheme.labelMedium,
        )
      ],
    );
  }
}

void whatsappMsj() {
  "https://wa.me/+919616205455?text=Hey ! \nI need help/technical support for Cash Denomination App."
      .replaceAll(" ", "%20")
      .gtOpenUrl;
}
