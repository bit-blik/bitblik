import 'group_links_constants.dart';

/// Stub implementation for non-web platforms
/// Uses default constants as group links are only configurable on web
class GroupLinks {
  /// Links for the given payment system id, honoring debug/release mode.
  static GroupLinkSet of(String paymentSystemId) =>
      GroupLinksConstants.forPaymentSystem(paymentSystemId);
}
