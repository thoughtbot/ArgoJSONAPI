import Argo
import Runes

extension JSONAPI {
  public struct Relationships {
    var rawValue: RawRelationships?

    static let none = Relationships(rawValue: nil)
  }

  struct RawRelationships {
    var resources: JSON
    var included: [JSON]

    mutating func remove(with identifier: ResourceIdentifier) -> JSON? {
      let index = included.index { data in
        switch ResourceIdentifier.decode(data) {
        case .success(identifier):
          return true
        default:
          return false
        }
      }

      if let index = index {
        return included.remove(at: index)
      } else {
        return nil
      }
    }
  }
}

extension JSONAPI.Relationships {
  init(resources: JSON, included: [JSON]) {
    rawValue = JSONAPI.RawRelationships(
      resources: resources,
      included: included
    )
  }
}

extension JSONAPI.Relationships {
  static func decode(_ data: JSON, from document: JSON) -> Decoded<JSONAPI.Relationships> {
    let resources: Decoded<JSON?> = data <|? "relationships"

    return resources >>- { resources in
      guard let resources = resources else { return pure(.none) }
      let included: Decoded<[JSON]> = document <|| "included"

      return included >>- { included in
        pure(JSONAPI.Relationships(
          resources: resources,
          included: included
        ))
      }
    }
  }
}

extension JSONAPI.Relationships {
  public static func <| <T: JSONAPIDecodable> (lhs: JSONAPI.Relationships, rhs: String) -> Decoded<T>
    where T.DecodedType == T
  {
    guard var relationships = lhs.rawValue else {
      return .customError("expected relationships, but got none")
    }

    let id: Decoded<ResourceIdentifier> = relationships.resources <| [rhs, "data"]

    let data: Decoded<JSON> = id >>- { id in
      let data = relationships.remove(with: id)
      return data.map(pure) ?? .customError("")
    }

    let document = data.map { data in
      JSON.object([
        "data": data,
        "included": .array(relationships.included),
      ])
    }

    return document >>- Document<T>.decodeResource
  }
}
