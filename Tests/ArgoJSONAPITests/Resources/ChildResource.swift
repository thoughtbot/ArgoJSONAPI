import ArgoJSONAPI
import Curry
import Runes

struct ChildResource {
  var id: String
  var name: String
}

extension ChildResource: JSONAPIDecodable {
  static let resourceType = "child"

  static func decode(_ data: JSONAPI.Data) -> Decoded<ChildResource> {
    return curry(ChildResource.init)
      <^> pure(data.id)
      <*> data.attributes <| "name"
  }
}
