import 'package:crytpo_project/models/app_tab.dart';
import 'package:equatable/equatable.dart';

abstract class TabEvent extends Equatable {
  const TabEvent();
}

class TabUpdatedEvent extends TabEvent {
  final AppTab tab;

  const TabUpdatedEvent(this.tab);

  @override
  List<Object> get props => [tab];

  @override
  String toString() => 'TabUpdated { tab: $tab }';
}
