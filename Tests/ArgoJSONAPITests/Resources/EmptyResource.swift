import ArgoJSONAPI

struct EmptyResource {
  var id: String
}

extension EmptyResource: JSONAPIDecodable {
  static let resourceType = "empty"

  static func decode(_ data: JSONAPI.Data) -> Decoded<EmptyResource> {
    return pure(EmptyResource(id: data.id))
  }
}

extension EmptyResource: Equatable {
  static func == (lhs: EmptyResource, rhs: EmptyResource) -> Bool {
    return lhs.id == rhs.id
  }
}
