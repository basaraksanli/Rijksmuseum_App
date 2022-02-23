part of 'language_bloc.dart';

class LanguageState extends Equatable {
  final String language;
  const LanguageState(this.language);

  static LanguageState initial(){
    return LanguageState(PrefManager().getLocale());
  }

  @override
  List<Object?> get props => [language];
}