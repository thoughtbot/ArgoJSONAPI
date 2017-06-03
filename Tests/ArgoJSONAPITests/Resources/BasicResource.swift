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

  static func decode(id: String, attributes: JSON) -> Decoded<BasicResource> {
    return curry(BasicResource.init)
      <^> pure(id)
      <*> attributes <| "string"
      <*> attributes <| "int"
  }
}
