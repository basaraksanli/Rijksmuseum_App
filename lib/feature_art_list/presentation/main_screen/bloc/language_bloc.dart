import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:rijksmuseum_app/core/config/pref_manager.dart';

part 'language_event.dart';

part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc(BasePref prefManager) : super(LanguageState.initial()) {
    on<LanguageEvent>((event, emit) {
      if (event is ChangeLanguage) {
        prefManager.setLocale(event.language.toString());
        emit(LanguageState(event.language));
      }
    });
  }
}
