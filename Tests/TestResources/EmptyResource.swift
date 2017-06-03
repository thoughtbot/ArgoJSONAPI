import ArgoJSONAPI

public struct EmptyResource {
  public var id: String

  public init(id: String) {
    self.id = id
  }
}

extension EmptyResource: JSONAPIDecodable {
  public static let resourceType = "empty"

  public static func decode(id: String, attributes _: JSON) -> Decoded<EmptyResource> {
    return pure(EmptyResource(id: id))
  }
}
