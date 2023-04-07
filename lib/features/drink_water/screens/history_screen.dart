import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_better_life/features/drink_water/providers/drink/drink_provider.dart';
import 'package:the_better_life/widgets/container/container_shadow_common.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('${'TXT_HISTORY'.tr()} ${"TXT_DRINK_WATER".tr()}'),
      ),
      body: Consumer<DrinkProvider>(
        builder: (context, provider, child) {
          return provider.listHistoryMonth.isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: provider.listHistoryMonth.length,
                  scrollDirection: Axis.vertical,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  itemBuilder: (context, index) {
                    return _buildItem(
                      result: '${provider.listHistoryMonth[index].result}',
                      time: provider.listHistoryMonth[index].date ?? '',
                    );
                  },
                )
              : const Center(child: Text('No data!'));
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
