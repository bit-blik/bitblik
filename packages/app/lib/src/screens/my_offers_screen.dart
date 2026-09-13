import 'package:bitblik_core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../i18n/gen/strings.g.dart';
import '../providers/providers.dart';
import '../services/offer_db_service.dart';
import '../widgets/offer_list_tile.dart';

enum _OfferFilter { all, active, completed, failed }

const _activeStatuses = {
  OfferStatus.created,
  OfferStatus.funded,
  OfferStatus.reserved,
  OfferStatus.blikReceived,
  OfferStatus.blikSentToMaker,
  OfferStatus.expiredBlik,
  OfferStatus.expiredSentBlik,
  OfferStatus.invalidBlik,
  OfferStatus.takerCharged,
  OfferStatus.makerConfirmed,
  OfferStatus.settled,
  OfferStatus.payingTaker,
  OfferStatus.takerPaymentFailed,
  OfferStatus.conflict,
  OfferStatus.dispute,
  OfferStatus.refundingMaker,
  OfferStatus.unknown,
};

const _completedStatuses = {
  OfferStatus.takerPaid,
  OfferStatus.refundedMaker,
};

const _failedStatuses = {OfferStatus.expired, OfferStatus.cancelled};

class MyOffersScreen extends ConsumerStatefulWidget {
  const MyOffersScreen({super.key});

  static const routeName = '/my-offers';

  @override
  ConsumerState<MyOffersScreen> createState() => _MyOffersScreenState();
}

class _MyOffersScreenState extends ConsumerState<MyOffersScreen> {
  _OfferFilter _filter = _OfferFilter.active;
  bool _defaultFilterResolved = false;

  Future<void> _refreshAllOffers() async {
    final offers = await ref.read(myOffersProvider.future);
    final apiService = await ref.read(initializedApiServiceProvider.future);
    final db = OfferDbService();
    await Future.wait(
      offers.map((offer) async {
        final remote = await apiService.getOfferDetails(
          offer,
          offer.coordinatorPubkey,
        );
        if (remote != null) {
          await db.upsertOffer(Offer.fromJson(remote));
        } else {
          await db.deleteOfferById(offer.id);
        }
      }),
    );
    ref.invalidate(myOffersProvider);
  }

  List<Offer> _applyFilter(List<Offer> offers) {
    switch (_filter) {
      case _OfferFilter.all:
        return offers;
      case _OfferFilter.active:
        return offers.where((o) => _activeStatuses.contains(o.status)).toList();
      case _OfferFilter.completed:
        return offers
            .where((o) => _completedStatuses.contains(o.status))
            .toList();
      case _OfferFilter.failed:
        return offers.where((o) => _failedStatuses.contains(o.status)).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final offersAsync = ref.watch(myOffersProvider);

    return Scaffold(
      appBar: AppBar(title: Text(t.myOffers.title)),
      body: offersAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error:
            (err, _) =>
                Center(child: Text('${t.coordinator.management.error}: $err')),
        data: (allOffers) {
          // Only show offers for the payment system selected in settings.
          final selectedSystem = ref.watch(selectedPaymentSystemProvider);
          final offers =
              allOffers
                  .where((o) => o.fiatCurrency == selectedSystem.currency)
                  .toList();
          if (!_defaultFilterResolved) {
            final hasActive = offers.any(
              (o) => _activeStatuses.contains(o.status),
            );
            _filter = hasActive ? _OfferFilter.active : _OfferFilter.completed;
            _defaultFilterResolved = true;
          }
          final filtered = _applyFilter(offers);
          return Column(
            children: [
              _FilterBar(
                current: _filter,
                onChanged: (f) => setState(() => _filter = f),
              ),
              Expanded(
                child:
                    filtered.isEmpty
                        ? RefreshIndicator(
                          onRefresh: _refreshAllOffers,
                          child: ListView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height - 260,
                                child: Center(child: Text(t.myOffers.empty)),
                              ),
                            ],
                          ),
                        )
                        : RefreshIndicator(
                          onRefresh: _refreshAllOffers,
                          child: ListView.separated(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            itemCount: filtered.length,
                            separatorBuilder:
                                (_, _) => const Divider(height: 1),
                            itemBuilder: (context, index) {
                              final offer = filtered[index];
                              final multipleNekos =
                                  filtered
                                      .map((o) => o.makerPubkey)
                                      .toSet()
                                      .length >
                                  1;
                              return OfferListTile(
                                offer: offer,
                                showNeko: multipleNekos,
                                showPremium: true,
                                onTap:
                                    () =>
                                        context.push('/my-offers/${offer.id}'),
                              );
                            },
                          ),
                        ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _FilterBar extends StatelessWidget {
  const _FilterBar({required this.current, required this.onChanged});

  final _OfferFilter current;
  final ValueChanged<_OfferFilter> onChanged;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final filters = [
      (_OfferFilter.all, t.myOffers.filter.all),
      (_OfferFilter.active, t.myOffers.filter.active),
      (_OfferFilter.completed, t.myOffers.filter.completed),
      (_OfferFilter.failed, t.myOffers.filter.failed),
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children:
            filters.map((entry) {
              final (filter, label) = entry;
              final selected = current == filter;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: FilterChip(
                  label: Text(label),
                  selected: selected,
                  onSelected: (_) => onChanged(filter),
                ),
              );
            }).toList(),
      ),
    );
  }
}
