import ArgoJSONAPI
import Argo
import Curry
import Runes

public struct BasicResource {
  public var id: String
  public var string: String
  public var int: Int

  public init(id: String, string: String, int: Int) {
    self.id = id
    self.string = string
    self.int = int
  }
}

extension BasicResource: JSONAPIDecodable {
  public static func decode(id: String, attributes: JSON) -> Decoded<BasicResource> {
    return curry(BasicResource.init)
      <^> pure(id)
      <*> attributes <| "string"
      <*> attributes <| "int"
  }
}
