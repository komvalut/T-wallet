import 'package:cake_wallet/generated/i18n.dart';
import 'package:cake_wallet/new-ui/widgets/apps_widget.dart';
import 'package:cake_wallet/routes.dart';
import 'package:cake_wallet/view_model/dashboard/dashboard_view_model.dart';
import 'package:cw_core/utils/print_verbose.dart';
import 'package:cw_core/wallet_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cake_wallet/src/widgets/gradient_background.dart';

class CakeFeaturesPage extends StatelessWidget {
  CakeFeaturesPage({required this.dashboardViewModel});

  final DashboardViewModel dashboardViewModel;

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      scaffold: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minHeight: constraints.maxHeight),
                      child: IntrinsicHeight(
                        child: _buildNewUi(context),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.only(top: 24, bottom: 24),
        child: Text(
          S.of(context).apps,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.onSurface,
              ),
        ),
      ),
    );
  }

  Widget _buildNewUi(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppsWidget(
          isWide: true,
          isLink: true,
          isCake: true,
          onTap: () => _launchUrl("radar.chat"),
          title: "Radar",
          subTitle: "Your messages. Your Bitcoin. Together, at last",
          image: 'assets/images/radar.png',
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.only(left: 24, top: 16, bottom: 8),
          child: Text(
            "Featured Apps",
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
        ),
        AppsWidget(
          isWide: true,
          isLink: true,
          onTap: () => _launchUrl("cake.nano-gpt.com"),
          title: "NanoGPT",
          subTitle: S.of(context).nanogpt_subtitle,
          image: 'assets/images/nanogpt.png',
        ),
        AppsWidget(
          isWide: true,
          isLink: true,
          onTap: () => _launchUrl("btcmap.org/apps"),
          title: "BTC Map",
          subTitle: S.of(context).btcmap_subtitle,
          image: 'assets/images/btcmap.png',
        ),
        Observer(builder: (_) {
          if (dashboardViewModel.type == WalletType.ethereum) {
            return AppsWidget(
              isWide: true,
              onTap: () => Navigator.of(context).pushNamed(Routes.dEuroSavings),
              title: S.of(context).deuro_savings,
              subTitle: S.of(context).deuro_savings_subtitle,
              image: 'assets/images/deuro_icon.png',
            );
          }
          return const SizedBox();
        }),
        const Spacer(),
        const SizedBox(height: 125),
      ],
    );
  }

  void _launchUrl(String url) {
    try {
      launchUrl(Uri.parse("https://$url"), mode: LaunchMode.externalApplication);
    } catch (e) {
      printV(e);
    }
  }
}
