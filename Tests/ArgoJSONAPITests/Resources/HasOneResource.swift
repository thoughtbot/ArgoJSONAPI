import ArgoJSONAPI
import Curry
import Runes

struct HasOneResource {
  var id: String
  var name: String
  var child: ChildResource
}

extension HasOneResource: JSONAPIDecodable {
  static let resourceType = "has-one"

  static func decode(_ data: JSONAPI.Data) -> Decoded<HasOneResource> {
    return curry(HasOneResource.init)
      <^> pure(data.id)
      <*> data.attributes <| "name"
      <*> data.relationships <| "child"
  }
}
