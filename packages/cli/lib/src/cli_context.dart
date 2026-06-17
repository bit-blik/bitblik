import 'package:bitblik_core/core.dart';

/// The payment system this CLI process operates in.
///
/// Set once at startup by the binary entrypoint (`bitblik` → [kBlik],
/// `bitway` → [kMbway]) before any command runs. Stores and the protocol
/// client default to it, so each market's coordinators, offers, and discovery
/// stay isolated within a single process. A CLI invocation only ever serves one
/// market, so a process-global is the single source of truth rather than
/// threading the system through every command and store helper.
PaymentSystem activePaymentSystem = kBlik;
