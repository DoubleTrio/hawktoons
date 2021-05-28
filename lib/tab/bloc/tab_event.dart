import 'package:equatable/equatable.dart';
import 'package:hawktoons/tab/tab.dart';

abstract class TabEvent extends Equatable {
  const TabEvent();
}

class UpdateTab extends TabEvent {
  UpdateTab(this.tab);

  final AppTab tab;

  @override
  List<Object> get props => [tab];

  @override
  String toString() => 'UpdateTab { tab: $tab }';
}
