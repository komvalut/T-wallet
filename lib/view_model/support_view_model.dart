import 'package:cake_wallet/generated/i18n.dart';
import 'package:cake_wallet/store/app_store.dart';
import 'package:cake_wallet/view_model/settings/link_list_item.dart';
import 'package:cake_wallet/view_model/settings/settings_list_item.dart';
import 'package:cake_wallet/wallet_type_utils.dart';
import 'package:mobx/mobx.dart';

part 'support_view_model.g.dart';

class SupportViewModel = SupportViewModelBase with _$SupportViewModel;

abstract class SupportViewModelBase with Store {
  final AppStore _appStore;

  SupportViewModelBase(this._appStore)
      : items = [
          LinkListItem(
              title: 'Email',
              icon: 'assets/images/support_icon.png',
              linkTitle: 'support@twallet.app',
              link: 'mailto:support@twallet.app'),
          LinkListItem(
              title: 'Website',
              icon: 'assets/images/global.png',
              linkTitle: 'twallet.app',
              link: 'https://twallet.app'),
          LinkListItem(
              title: 'GitHub',
              icon: 'assets/images/github.png',
              hasIconColor: true,
              linkTitle: S.current.apk_update,
              link: 'https://github.com/komvalut/cake_wallet/releases'),
          LinkListItem(
              title: 'Discord',
              icon: 'assets/images/discord.png',
              linkTitle: 'discord.gg/2vqYJdXG2H',
              link: 'https://discord.gg/2vqYJdXG2H'),
          LinkListItem(
              title: 'Telegram',
              icon: 'assets/images/Telegram.png',
              linkTitle: 't.me/twallet_announcements',
              link: 'https://t.me/twallet_announcements'),
          LinkListItem(
              title: 'ChangeNow',
              icon: 'assets/images/change_now.png',
              linkTitle: 'support@changenow.io',
              link: 'mailto:support@changenow.io'),
          // LinkListItem(
          //     title: 'SideShift',
          //     icon: 'assets/images/sideshift.png',
          //     linkTitle: 'help.sideshift.ai',
          //     link: 'https://help.sideshift.ai/en/'),
          LinkListItem(
              title: 'SimpleSwap',
              icon: 'assets/images/simpleSwap.png',
              linkTitle: 'support@simpleswap.io',
              link: 'mailto:support@simpleswap.io'),
          LinkListItem(
              title: 'Exolix',
              icon: 'assets/images/exolix.png',
              linkTitle: 'support@exolix.com',
              link: 'mailto:support@exolix.com'),
          LinkListItem(
              title: 'SwapTrade',
              icon: 'assets/images/swap_trade.png',
              linkTitle: 'help.swaptrade.io',
              link: 'https://help.swaptrade.io/contact/'),
          LinkListItem(
              title: 'Trocador',
              icon: 'assets/images/trocador.png',
              linkTitle: 'mail@trocador.app',
              link: 'mailto:mail@trocador.app'),
          LinkListItem(
              title: 'Onramper',
              icon: 'assets/images/onramper_dark.png',
              lightIcon: 'assets/images/onramper_light.png',
              linkTitle: 'View exchanges',
              link: 'https://docs.cakewallet.com/support/buy/#onramper'),
          LinkListItem(
              title: 'DFX',
              icon: 'assets/images/dfx_dark.png',
              lightIcon: 'assets/images/dfx_light.png',
              linkTitle: 'support@dfx.swiss',
              link: 'mailto:support@dfx.swiss'),
          if (!isMoneroOnly) ...[
            LinkListItem(
                title: 'MoonPay',
                icon: 'assets/images/moonpay.png',
                linkTitle: S.current.submit_request,
                link: 'https://support.moonpay.com/hc/en-gb/requests/new'),
            LinkListItem(
                title: 'Robinhood Connect',
                icon: 'assets/images/robinhood_dark.png',
                lightIcon: 'assets/images/robinhood_light.png',
                linkTitle: S.current.submit_request,
                link: 'https://robinhood.com/contact')
          ],
          LinkListItem(
              title: 'Kryptonim',
              icon: 'assets/images/kryptonim_dark.png',
              lightIcon: 'assets/images/kryptonim_light.png',
              linkTitle: 'contact@support.kryptonim.com',
              link: 'mailto:contact@support.kryptonim.com'),
        ];

  final docsUrl = 'https://twallet.app';

  String fetchUrl({String locale = "en", String authToken = ""}) {
    // T-Wallet: in-app live chat (Cake's Chatwoot instance) is disabled for
    // infrastructure independence. The support links list is used instead.
    return "";
  }

  String get appVersion =>
      "T-Wallet - ${_appStore.settingsStore.appVersion}";

  String get fiatApiMode => _appStore.settingsStore.fiatApiMode.title;

  String get walletType => _appStore.wallet?.type.name ?? 'Unknown';

  String get walletSyncState => _appStore.wallet?.syncStatus.toString() ?? 'Unknown';

  String get builtInTorState => _appStore.settingsStore.currentBuiltinTor ? 'Enabled' : 'Disabled';

  List<SettingsListItem> items;
}
