import Argo
import Runes

extension JSONAPI {
  public struct Data {
    public let type: String
    public let id: String
    public let attributes: JSON
  }
}

extension JSONAPI.Data {
  public static func decodeCollection(_ document: JSON) -> Decoded<[JSONAPI.Data]> {
    let array: Decoded<[JSON]> = document <|| "data"
    return array >>- { array in
      sequence(array.map { decodeSimpleResource($0, from: document) })
    }
  }

  public static func decodeResource(_ document: JSON) -> Decoded<JSONAPI.Data> {
    return (document <| "data") >>- { decodeSimpleResource($0, from: document) }
  }

  private static func decodeSimpleResource(_ data: JSON, from document: JSON) -> Decoded<JSONAPI.Data> {
    return JSONAPI.Data.create
      <^> data <| "type"
      <*> data <| "id"
      <*> (data <|? "attributes").map { $0 ?? .object([:]) }
  }

  private static var create: (String) -> (String) -> (JSON) -> JSONAPI.Data {
    return { string in { id in { attributes in
      JSONAPI.Data(type: string, id: id, attributes: attributes)
    }}}
  }
}