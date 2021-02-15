import 'package:crytpo_project/models/app_tab.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'tab_event.dart';

class TabBloc extends Bloc<TabEvent, AppTab> {
  TabBloc() : super(AppTab.home);

  @override
  Stream<AppTab> mapEventToState(TabEvent event) async* {
    if (event is TabUpdatedEvent) {
      yield event.tab;
    }
  }
}
