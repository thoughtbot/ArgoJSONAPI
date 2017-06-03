import Argo
import Runes

public func decode<T: JSONAPIDecodable>(_ object: Any) -> Decoded<T>
  where T.DecodedType == T
{
  let json = JSON(object)
  let data: Decoded<JSON> = json <| "data"
  let id: Decoded<String> = data >>- { $0 <| "id" }
  let attributes: Decoded<JSON?> = data >>- { $0 <|? "attributes" }
  return id >>- { id in
    attributes >>- { attributes in
      T.decode(id: id, attributes: attributes ?? .object([:]))
    }
  }
}

public func decode<T: JSONAPIDecodable>(_ object: Any) -> T?
  where T.DecodedType == T
{
  let decoded: Decoded<T> = decode(object)
  return decoded.value
}
