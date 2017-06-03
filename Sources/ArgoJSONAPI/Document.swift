import Argo
import Runes

enum Document<Resource: JSONAPIDecodable> {
  static func decodeCollection(_ json: JSON) -> Decoded<[Resource.DecodedType]> {
    return JSONAPI.Data.decodeCollection(json) >>- { collection in
      sequence(decodeSimpleResource <^> collection)
    }
  }

  static func decodeResource(_ json: JSON) -> Decoded<Resource.DecodedType> {
    return JSONAPI.Data.decodeResource(json) >>- decodeSimpleResource
  }

  private static func decodeSimpleResource(_ data: JSONAPI.Data) -> Decoded<Resource.DecodedType> {
    guard data.type == Resource.resourceType else {
      return .typeMismatch(expected: Resource.resourceType, actual: data)
    }

    return Resource.decode(data)
  }
}
