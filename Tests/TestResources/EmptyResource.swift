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

extension EmptyResource: Equatable {
  public static func == (lhs: EmptyResource, rhs: EmptyResource) -> Bool {
    return lhs.id == rhs.id
  }
}
