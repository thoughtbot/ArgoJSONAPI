import Argo
import Runes

struct ResourceIdentifier {
  var type: String
  var id: String

  var pathFragment: String {
    return "\(type)/\(id)"
  }
}

extension ResourceIdentifier: CustomStringConvertible {
  var description: String {
    return pathFragment
  }
}

extension ResourceIdentifier: Equatable {
  static func == (lhs: ResourceIdentifier, rhs: ResourceIdentifier) -> Bool {
    return lhs.type == rhs.type
        && lhs.id == rhs.id
  }
}

extension ResourceIdentifier: Argo.Decodable {
  static func decode(_ json: JSON) -> Decoded<ResourceIdentifier> {
    return create
      <^> json <| "type"
      <*> json <| "id"
  }

  private static var create: (String) -> (String) -> ResourceIdentifier {
    return { type in { id in
      ResourceIdentifier(type: type, id: id)
    }}
  }
}
