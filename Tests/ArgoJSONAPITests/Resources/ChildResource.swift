import ArgoJSONAPI
import Curry
import Runes

struct ChildResource {
  var id: String
  var name: String
}

extension ChildResource: Equatable {
  static func == (lhs: ChildResource, rhs: ChildResource) -> Bool {
    return lhs.id == rhs.id
      && lhs.name == rhs.name
  }
}

extension ChildResource: JSONAPIDecodable {
  static let resourceType = "child"

  static func decode(_ data: JSONAPI.Data) -> Decoded<ChildResource> {
    return curry(ChildResource.init)
      <^> pure(data.id)
      <*> data.attributes <| "name"
  }
}
