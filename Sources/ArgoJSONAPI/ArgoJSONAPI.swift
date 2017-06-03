import Argo
import Runes

public func decode<T: JSONAPIDecodable>(_ object: Any) -> Decoded<T>
  where T.DecodedType == T
{
  let json = JSON(object)
  let data: Decoded<JSON> = json <| "data"

  return data >>- { (data: JSON) in
    let type: Decoded<String> = data <| "type"

    guard type.value == T.resourceType else {
      return .typeMismatch(expected: T.resourceType, actual: data)
    }

    let id: Decoded<String> = data <| "id"
    let attributes: Decoded<JSON?> = data <|? "attributes"

    return id >>- { id in
      attributes >>- { attributes in
        T.decode(id: id, attributes: attributes ?? .object([:]))
      }
    }
  }
}

public func decode<T: JSONAPIDecodable>(_ object: Any) -> T?
  where T.DecodedType == T
{
  let decoded: Decoded<T> = decode(object)
  return decoded.value
}
