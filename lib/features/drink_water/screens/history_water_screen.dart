import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_better_life/features/drink_water/providers/drink/drink_provider.dart';
import 'package:the_better_life/widgets/common/base_appbar.dart';
import 'package:the_better_life/widgets/container/container_shadow_common.dart';

class HistoryWaterScreen extends StatefulWidget {
  const HistoryWaterScreen({Key? key}) : super(key: key);

  @override
  State<HistoryWaterScreen> createState() => _HistoryWaterScreenState();
}

class _HistoryWaterScreenState extends State<HistoryWaterScreen> {
  late TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    textTheme = Theme.of(context).textTheme;
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: BaseAppBar(title: 'TXT_HISTORY_WATER'.tr()),
      body: Consumer<DrinkProvider>(
        builder: (context, provider, child) {
          return provider.listHistoryMonth.isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: provider.listHistoryMonth.length,
                  scrollDirection: Axis.vertical,
                  padding: const EdgeInsets.all(24),
                  itemBuilder: (context, index) {
                    return _buildItem(
                      result: '${provider.listHistoryMonth[index].result}',
                      time: provider.listHistoryMonth[index].date ?? '',
                    );
                  },
                )
              : SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.sim_card_alert_outlined,
                        color: theme.disabledColor,
                        size: 100,
                      ),
                      Text(
                        'TXT_NULL_DATA_WATER_HISTORY'.tr(),
                        textAlign: TextAlign.center,
                        style: textTheme.bodyText1,
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }

  Widget _buildItem({required String result, required String time}) {
    return ContainerShadowCommon(
      size: const Size(double.infinity, 56),
      margin: const EdgeInsets.only(bottom: 24),
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          const Icon(Icons.water_drop_outlined),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              '${result}ml',
              style: textTheme.bodyText1,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            time,
            style: textTheme.bodyText1,
          ),
        ],
      ),
    );
  }
}
