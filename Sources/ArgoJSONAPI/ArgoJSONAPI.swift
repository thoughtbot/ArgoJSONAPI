import Argo
import Runes

public func decode<T: JSONAPIDecodable>(_ object: Any) -> Decoded<T>
  where T.DecodedType == T
{
  let json = JSON(object)

  return (json <| "data") >>- Document<T>.decodeResource
}

public func decode<T: JSONAPIDecodable>(_ object: Any) -> Decoded<[T]>
  where T.DecodedType == T
{
  let json = JSON(object)

  return (json <| "data") >>- Document<T>.decodeCollection
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
