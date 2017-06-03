import ArgoJSONAPI
import Argo
import Curry
import Runes

struct BasicResource {
  var id: String
  var string: String
  var int: Int
}

extension BasicResource: JSONAPIDecodable {
  static let resourceType = "basic"

  static func decode(_ data: JSONAPI.Data) -> Decoded<BasicResource> {
    return curry(BasicResource.init)
      <^> pure(data.id)
      <*> data.attributes <| "string"
      <*> data.attributes <| "int"
  }
}
