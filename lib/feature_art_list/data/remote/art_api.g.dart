// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'art_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps

class _ArtApi implements ArtApi {
  _ArtApi(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://www.rijksmuseum.nl/api/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<HttpResponse<CollectionDto>> getCollection(
      {page = 1, language = "en", imgOnly = true}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'p': page, r'imgonly': imgOnly};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<HttpResponse<CollectionDto>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '${language}/collection?key=0fiuZFh4',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = CollectionDto.fromJson(_result.data!);
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<String>> getImage(
      {required language, required id}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<String>(
        _setStreamType<HttpResponse<String>>(Options(
                method: 'GET', headers: _headers, extra: _extra)
            .compose(
                _dio.options, '${language}/collection/${id}/tiles?key=0fiuZFh4',
                queryParameters: queryParameters, data: _data)
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!;
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<ArtObjectDetailResultDto>> getArtObjectDetail(
      {required language, required id}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<HttpResponse<ArtObjectDetailResultDto>>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(
                    _dio.options, '${language}/collection/${id}/?key=0fiuZFh4',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ArtObjectDetailResultDto.fromJson(_result.data!);
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
