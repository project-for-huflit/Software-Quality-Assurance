import 'package:freezed_annotation/freezed_annotation.dart';

class ApiResponse<T> {
  T? data;
  String? statusCode;
  bool? success;
  String? statusMessage;

  ApiResponse({
    this.data,
    this.statusCode,
    this.success,
    this.statusMessage,
  });

  @override
  String toString() {
    return 'ApiResponse<$T>{data: $data, statusCode: $statusCode, success: $success, statusMessage: $statusMessage}';
  }

  factory ApiResponse.fromError(String message, String statusCode) {
    return ApiResponse(
      success: false,
      statusCode: statusCode,
      statusMessage: message,
    );
  }
}

@JsonSerializable( 
    createToJson: false , 
    genericArgumentFactories: true , 
    fieldRename: FieldRename.snake
) 
class  ListResponse<T> { 
  final  int page; 
  final  List<T> results; 
  final  int totalPages; 
  final  int totalResults; 

  ListResponse({ 
    required  this .page, 
    required  this .results, 
    required  this .totalPages, 
    required  this .totalResults, 
  }); 

  @override 
  String toString() { 
    return  'ListResponse< $T >{page: $page , results: $results , totalPages: $totalPages , totalResults: $totalResults }' ; 
  } 

  // @override 
  // factory ListResponse.fromJson( 
  //     Map<String, dynamic> json, T Function( Object? json) fromJsonT) { 
  //   return _$ListResponseFromJson(json, fromJsonT); 
  // }
}