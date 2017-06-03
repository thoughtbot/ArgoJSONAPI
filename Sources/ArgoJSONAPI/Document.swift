import Argo

enum Document<Resource: JSONAPIDecodable> {
  static func decodeCollection(_ data: JSON) -> Decoded<[Resource.DecodedType]> {
    let array: Decoded<[JSON]> = decodeArray(data)

    return array >>- { array in
      sequence(decodeResource <^> array)
    }
  }

  static func decodeResource(_ data: JSON) -> Decoded<Resource.DecodedType> {
    let type: Decoded<String> = data <| "type"

    guard type.value == Resource.resourceType else {
      return .typeMismatch(expected: Resource.resourceType, actual: data)
    }

    let id: Decoded<String> = data <| "id"
    let attributes: Decoded<JSON?> = data <|? "attributes"

    return id >>- { id in
      attributes >>- { attributes in
        Resource.decode(id: id, attributes: attributes ?? .object([:]))
      }
    }
  }
}
