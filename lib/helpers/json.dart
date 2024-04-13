typedef FromJsonConverter<T> = T Function(Map<String, dynamic>);
typedef ToJsonConverter<T> = Map<String, dynamic> Function(T);

List<T> listFromJson<T>(List itemsJson, FromJsonConverter<T> fromJson) =>
  itemsJson.map((itemJson) => fromJson(itemJson)).toList();

List listToJson<T>(List<T> items, ToJsonConverter<T> toJson) =>
  items.map(toJson).toList();
