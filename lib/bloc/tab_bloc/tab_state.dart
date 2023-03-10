import 'package:petsguide/model/tab_model.dart';

abstract class TabState {
}

class TabInitialState extends TabState {
  int currentIndex = 0;
  TabInitialState();
}

class TabIndexState extends TabState {
  int currentIndex;
  
  TabIndexState(this.currentIndex);
}

class TabViewLoaded extends TabState {
  List<TabModel> tab = [];
  int currentIndex;

  TabViewLoaded(this.tab, this.currentIndex);

}