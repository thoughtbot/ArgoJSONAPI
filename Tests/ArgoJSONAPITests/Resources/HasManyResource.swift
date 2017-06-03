import ArgoJSONAPI
import Curry
import Runes

struct HasManyResource {
  var id: String
  var name: String
  var children: [ChildResource]
}

extension HasManyResource: JSONAPIDecodable {
  static let resourceType = "has-many"

  static func decode(_ data: JSONAPI.Data) -> Decoded<HasManyResource> {
    return curry(HasManyResource.init)
      <^> pure(data.id)
      <*> data.attributes <| "name"
      <*> data.relationships <|| "children"
  }
}
