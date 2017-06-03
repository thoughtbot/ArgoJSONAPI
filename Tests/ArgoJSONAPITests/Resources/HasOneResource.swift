import ArgoJSONAPI
import Curry
import Runes

struct HasOneResource {
  var id: String
  var name: String
  var child: HasOneChildResource
}

struct HasOneChildResource {
  var id: String
  var name: String
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

extension HasOneChildResource: JSONAPIDecodable {
  static let resourceType = "has-one-child"

  static func decode(_ data: JSONAPI.Data) -> Decoded<HasOneChildResource> {
    return curry(HasOneChildResource.init)
      <^> pure(data.id)
      <*> data.attributes <| "name"
  }
}
