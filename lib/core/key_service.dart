import 'package:cake_wallet/core/secure_storage.dart';
import 'package:cake_wallet/entities/secret_store_key.dart';
import 'package:cake_wallet/entities/encrypt.dart';
import 'package:cw_core/utils/print_verbose.dart';

/// Thrown when the stored wallet password cannot be decrypted because it was
/// written by an app build with different secrets. The safe-storage entry is
/// deleted (clean storage) and callers must treat the wallet as unrecoverable.
class WalletPasswordUnrecoverableException implements Exception {
  WalletPasswordUnrecoverableException(this.walletName);

  final String walletName;

  @override
  String toString() =>
      'WalletPasswordUnrecoverableException: password of "$walletName" cannot be decrypted (secrets changed)';
}

class KeyService {
  KeyService(this._secureStorage);

  final SecureStorage _secureStorage;

  Future<String> getWalletPassword({required String walletName}) async {
    final key =
        generateStoreKeyFor(key: SecretStoreKey.moneroWalletPassword, walletName: walletName);
    final encodedPassword = await _secureStorage.read(key: key);

    if (encodedPassword == null) {
      return '';
    }

    try {
      return decodeWalletPassword(password: encodedPassword);
    } on SecretsChangedException catch (e, s) {
      // The entry was encrypted by another build of the app (regenerated
      // secrets). It is unrecoverable — remove it so the app behaves like it
      // has clean storage instead of crashing on the next launch.
      printV('[T-Wallet] $e; removing the poisoned storage entry');
      try {
        await _secureStorage.delete(key: key);
      } catch (cleanupError) {
        printV('Failed to remove poisoned storage entry: $cleanupError');
      }
      throw WalletPasswordUnrecoverableException(walletName);
    }
  }

  Future<void> saveWalletPassword({required String walletName, required String password}) async {
    final key =
        generateStoreKeyFor(key: SecretStoreKey.moneroWalletPassword, walletName: walletName);
    final encodedPassword = encodeWalletPassword(password: password);

    await _secureStorage.write(key: key, value: encodedPassword);
  }

  Future<void> deleteWalletPassword({required String walletName}) async {
    final key =
        generateStoreKeyFor(key: SecretStoreKey.moneroWalletPassword, walletName: walletName);

    await _secureStorage.delete(key: key);
  }
}
