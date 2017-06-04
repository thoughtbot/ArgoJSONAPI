import Argo
import Runes

extension JSONAPI {
  public struct Data {
    public let type: String
    public let id: String
    public let attributes: JSON
    public let relationships: Relationships
  }
}

extension JSONAPI.Data {
  static func decodeCollection(_ document: JSON) -> Decoded<[JSONAPI.Data]> {
    let array: Decoded<[JSON]> = document <|| "data"
    return array >>- { array in
      sequence(array.map { decodeResource($0, from: document) })
    }
  }

  static func decodeResource(_ document: JSON) -> Decoded<JSONAPI.Data> {
    return (document <| "data") >>- { decodeResource($0, from: document) }
  }

  static func decodeResource(_ data: JSON, from document: JSON) -> Decoded<JSONAPI.Data> {
    return JSONAPI.Data.create
      <^> data <| "type"
      <*> data <| "id"
      <*> (data <|? "attributes").map { $0 ?? .object([:]) }
      <*> JSONAPI.Relationships.decode(data, from: document)
  }

  private static var create: (String) -> (String) -> (JSON) -> (JSONAPI.Relationships) -> JSONAPI.Data {
    return { string in { id in { attributes in { relationships in
      JSONAPI.Data(type: string, id: id, attributes: attributes, relationships: relationships)
    }}}}
  }
}
