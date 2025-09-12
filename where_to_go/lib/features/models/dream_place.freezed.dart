// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dream_place.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DreamPlace {
  int? get id;
  String get name;
  String get description;
  String get imageUrl;
  bool get isFavourite;
  String? get ownerEmail;

  /// Create a copy of DreamPlace
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DreamPlaceCopyWith<DreamPlace> get copyWith =>
      _$DreamPlaceCopyWithImpl<DreamPlace>(this as DreamPlace, _$identity);

  /// Serializes this DreamPlace to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DreamPlace &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.isFavourite, isFavourite) ||
                other.isFavourite == isFavourite) &&
            (identical(other.ownerEmail, ownerEmail) ||
                other.ownerEmail == ownerEmail));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, description, imageUrl, isFavourite, ownerEmail);

  @override
  String toString() {
    return 'DreamPlace(id: $id, name: $name, description: $description, imageUrl: $imageUrl, isFavourite: $isFavourite, ownerEmail: $ownerEmail)';
  }
}

/// @nodoc
abstract mixin class $DreamPlaceCopyWith<$Res> {
  factory $DreamPlaceCopyWith(
          DreamPlace value, $Res Function(DreamPlace) _then) =
      _$DreamPlaceCopyWithImpl;
  @useResult
  $Res call(
      {int? id,
      String name,
      String description,
      String imageUrl,
      bool isFavourite,
      String? ownerEmail});
}

/// @nodoc
class _$DreamPlaceCopyWithImpl<$Res> implements $DreamPlaceCopyWith<$Res> {
  _$DreamPlaceCopyWithImpl(this._self, this._then);

  final DreamPlace _self;
  final $Res Function(DreamPlace) _then;

  /// Create a copy of DreamPlace
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? description = null,
    Object? imageUrl = null,
    Object? isFavourite = null,
    Object? ownerEmail = freezed,
  }) {
    return _then(_self.copyWith(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _self.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      isFavourite: null == isFavourite
          ? _self.isFavourite
          : isFavourite // ignore: cast_nullable_to_non_nullable
              as bool,
      ownerEmail: freezed == ownerEmail
          ? _self.ownerEmail
          : ownerEmail // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [DreamPlace].
extension DreamPlacePatterns on DreamPlace {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_DreamPlace value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DreamPlace() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_DreamPlace value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DreamPlace():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_DreamPlace value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DreamPlace() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(int? id, String name, String description, String imageUrl,
            bool isFavourite, String? ownerEmail)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DreamPlace() when $default != null:
        return $default(_that.id, _that.name, _that.description, _that.imageUrl,
            _that.isFavourite, _that.ownerEmail);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(int? id, String name, String description, String imageUrl,
            bool isFavourite, String? ownerEmail)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DreamPlace():
        return $default(_that.id, _that.name, _that.description, _that.imageUrl,
            _that.isFavourite, _that.ownerEmail);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(int? id, String name, String description, String imageUrl,
            bool isFavourite, String? ownerEmail)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DreamPlace() when $default != null:
        return $default(_that.id, _that.name, _that.description, _that.imageUrl,
            _that.isFavourite, _that.ownerEmail);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _DreamPlace implements DreamPlace {
  const _DreamPlace(
      {this.id,
      required this.name,
      required this.description,
      required this.imageUrl,
      this.isFavourite = false,
      this.ownerEmail});
  factory _DreamPlace.fromJson(Map<String, dynamic> json) =>
      _$DreamPlaceFromJson(json);

  @override
  final int? id;
  @override
  final String name;
  @override
  final String description;
  @override
  final String imageUrl;
  @override
  @JsonKey()
  final bool isFavourite;
  @override
  final String? ownerEmail;

  /// Create a copy of DreamPlace
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DreamPlaceCopyWith<_DreamPlace> get copyWith =>
      __$DreamPlaceCopyWithImpl<_DreamPlace>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$DreamPlaceToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DreamPlace &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.isFavourite, isFavourite) ||
                other.isFavourite == isFavourite) &&
            (identical(other.ownerEmail, ownerEmail) ||
                other.ownerEmail == ownerEmail));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, description, imageUrl, isFavourite, ownerEmail);

  @override
  String toString() {
    return 'DreamPlace(id: $id, name: $name, description: $description, imageUrl: $imageUrl, isFavourite: $isFavourite, ownerEmail: $ownerEmail)';
  }
}

/// @nodoc
abstract mixin class _$DreamPlaceCopyWith<$Res>
    implements $DreamPlaceCopyWith<$Res> {
  factory _$DreamPlaceCopyWith(
          _DreamPlace value, $Res Function(_DreamPlace) _then) =
      __$DreamPlaceCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int? id,
      String name,
      String description,
      String imageUrl,
      bool isFavourite,
      String? ownerEmail});
}

/// @nodoc
class __$DreamPlaceCopyWithImpl<$Res> implements _$DreamPlaceCopyWith<$Res> {
  __$DreamPlaceCopyWithImpl(this._self, this._then);

  final _DreamPlace _self;
  final $Res Function(_DreamPlace) _then;

  /// Create a copy of DreamPlace
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? description = null,
    Object? imageUrl = null,
    Object? isFavourite = null,
    Object? ownerEmail = freezed,
  }) {
    return _then(_DreamPlace(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _self.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      isFavourite: null == isFavourite
          ? _self.isFavourite
          : isFavourite // ignore: cast_nullable_to_non_nullable
              as bool,
      ownerEmail: freezed == ownerEmail
          ? _self.ownerEmail
          : ownerEmail // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
