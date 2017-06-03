import Argo

/// Defines a namespace for public types.
public enum JSONAPI {
}

public func decode<T: JSONAPIDecodable>(_ object: Any) -> Decoded<T>
  where T.DecodedType == T
{
  let json = JSON(object)
  return Document<T>.decodeResource(json)
}

public func decode<T: JSONAPIDecodable>(_ object: Any) -> Decoded<[T]>
  where T.DecodedType == T
{
  let json = JSON(object)
  return Document<T>.decodeCollection(json)
}

public func decode<T: JSONAPIDecodable>(_ object: Any) -> T?
  where T.DecodedType == T
{
  let decoded: Decoded<T> = decode(object)
  return decoded.value
}

public func decode<T: JSONAPIDecodable>(_ object: Any) -> [T]?
  where T.DecodedType == T
{
  let decoded: Decoded<[T]> = decode(object)
  return decoded.value
}
