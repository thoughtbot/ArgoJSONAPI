import ArgoJSONAPI

struct EmptyResource {
  var id: String
}

extension EmptyResource: JSONAPIDecodable {
  static let resourceType = "empty"

  static func decode(id: String, attributes _: JSON) -> Decoded<EmptyResource> {
    return pure(EmptyResource(id: id))
  }
}

extension EmptyResource: Equatable {
  static func == (lhs: EmptyResource, rhs: EmptyResource) -> Bool {
    return lhs.id == rhs.id
  }
}
