abstract class TabEvent {}

class TabInitial extends TabEvent {}

class TabChangeIndexEvent extends TabEvent {
  final int index;
  TabChangeIndexEvent(this.index);
}

class GetTabView extends TabEvent {}



