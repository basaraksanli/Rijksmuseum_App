part of 'language_bloc.dart';

abstract class LanguageEvent extends Equatable {
  const LanguageEvent();
}
class ChangeLanguage extends LanguageEvent{

  final String language;
  const ChangeLanguage(this.language);

  @override
  List<Object?> get props => [language];
}
