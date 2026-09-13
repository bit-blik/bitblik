import 'package:bitblik_coordinator/src/services/database_service.dart';
import 'package:bitblik_coordinator/src/services/payment_service.dart';
import 'package:mockito/annotations.dart';

abstract class CombinedPaymentService
    implements PaymentService, Bolt12PaymentService {}

@GenerateNiceMocks([
  MockSpec<DatabaseService>(),
  MockSpec<PaymentService>(),
  MockSpec<CombinedPaymentService>(),
])
void main() {}
