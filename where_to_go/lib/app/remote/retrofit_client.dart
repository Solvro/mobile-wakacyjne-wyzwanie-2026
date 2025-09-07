import "dart:io";

import "package:dio/dio.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:retrofit/retrofit.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../data/models/create_place_dto.dart";
import "../../data/models/dream_place.dart";
import "../../data/models/image_dto.dart";
import "../../data/models/paginated_dream_places.dart";
import "../../data/models/refresh_request.dart";
import "../../data/models/refresh_response.dart";
import "../../data/models/tokens.dart";
import "../../data/models/user_data.dart";
import "../../data/models/user_info.dart";
import "paths.dart";

part "retrofit_client.g.dart";

@RestApi(baseUrl: apiPath)
abstract class RestClient {
  factory RestClient(Dio dio, {String? baseUrl}) = _RestClient;

  @POST("/auth/login")
  Future<Tokens> login(@Body() UserData user);

  @POST("/auth/register")
  Future<Tokens> register(@Body() UserData user);

  @POST("/auth/refresh")
  Future<RefreshResponse> refresh(@Body() RefreshRequest token);

  @GET("/auth/me")
  Future<UserInfo> me();

  @GET("/places")
  Future<PaginatedDreamPlaces> getPlaces(@Query("sort") String sort, @Query("sortBy") String sortBy);

  @GET("/places/{id}")
  Future<DreamPlace> getPlace(@Path() int id);

  @DELETE("/places/{id}")
  Future<void> deletePlace(@Path() int id);

  @PUT("/places/{id}")
  Future<DreamPlace> updatePlace(@Path() int id, @Body() CreatePlaceDTO place);

  @POST("/places")
  Future<DreamPlace> postPlace(@Body() CreatePlaceDTO place);

  @POST("/photos/upload")
  @MultiPart()
  Future<ImageDTO> postImage(@Part(name: "file") File file);

  @GET("/photos/{filename}")
  @DioResponseType(ResponseType.bytes)
  Future<List<int>> downloadPhoto(@Path() String filename);
}

@riverpod
RestClient client(
  Ref ref, {
  String? token,
  Future<void> Function(DioException error, ErrorInterceptorHandler handler)? onError,
}) {
  final dio = Dio();
  if (token != null) dio.options.headers["Authorization"] = "Bearer $token";
  if (onError != null) dio.interceptors.add(InterceptorsWrapper(onError: onError));
  // dio.interceptors.add(LogInterceptor(
  //   requestBody: true,
  //   responseBody: true,
  //   responseHeader: false,
  //   logPrint: print,
  // ));

  return RestClient(dio);
}
