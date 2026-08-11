import 'package:bitblik_coordinator/src/services/database_service.dart';
import 'package:bitblik_coordinator/src/services/payment_service.dart';
import 'package:mockito/annotations.dart';

@GenerateNiceMocks([
  MockSpec<DatabaseService>(),
  MockSpec<PaymentService>(),
])
void main() {}
