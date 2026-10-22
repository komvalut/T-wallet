import 'generate_secrets_config.dart';
import 'import_secrets_config.dart';

const configPath = 'tool/.secrets-config.json';
const outputPath = 'lib/.secrets.g.dart';

Future<void> main(List<String> args) async => generateSecrets(args);

Future<void> generateSecrets(List<String> args) async {
  await generateSecretsConfig(args);
  // --keep-main: lib/.secrets.g.dart was imported from stable secrets (e.g. CI
  // repo secret MAIN_SECRETS_FILE); do not overwrite it with generated randoms.
  await importSecretsConfig(keepMain: args.contains('--keep-main'));
}
