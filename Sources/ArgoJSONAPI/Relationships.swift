import Argo
import Runes

extension JSONAPI {
  public struct Relationships {
    var rawValue: RawRelationships?

    static let none = Relationships(rawValue: nil)
  }

  struct RawRelationships {
    var resources: JSON
    var included: [ResourceIdentifier: JSON]
  }
}

extension JSONAPI.Relationships {
  init(resources: JSON, included: [ResourceIdentifier: JSON]) {
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
        let included = flatReduce(included, initial: [:], combine: extractIdentifier)
        return included.map { JSONAPI.Relationships(resources: resources, included: $0) }
      }
    }
  }
}

private func extractIdentifier(insertingInto result: [ResourceIdentifier: JSON], from data: JSON) -> Decoded<[ResourceIdentifier: JSON]> {
  return ResourceIdentifier.decode(data) >>- { id in
    guard result[id] == nil else { return .customError("multiple included resources for key '\(id)'") }
    return pure(result.inserting(data, forKey: id))
  }
}

extension JSONAPI.Relationships {
  public static func <| <T: JSONAPIDecodable> (lhs: JSONAPI.Relationships, rhs: String) -> Decoded<T>
    where T.DecodedType == T
  {
    guard let relationships = lhs.rawValue else {
      return .customError("expected relationships, but got none")
    }

    let id: Decoded<ResourceIdentifier> = relationships.resources <| [rhs, "data"]

    return id >>- { decodeResource(with: $0, from: relationships) }
  }

  public static func <|| <T: JSONAPIDecodable> (lhs: JSONAPI.Relationships, rhs: String) -> Decoded<[T]>
    where T.DecodedType == T
  {
    guard let relationships = lhs.rawValue else {
      return .customError("expected relationships, but got none")
    }

    let ids: Decoded<[ResourceIdentifier]> = relationships.resources <|| [rhs, "data"]

    return ids >>- { ids in
      sequence(ids.map { decodeResource(with: $0, from: relationships) })
    }
  }

  private static func decodeResource<T: JSONAPIDecodable>(with id: ResourceIdentifier, from relationships: JSONAPI.RawRelationships) -> Decoded<T>
    where T.DecodedType == T
  {
    let data = relationships.included[id].map(pure) ?? .customError("relationship not found with id '\(id)'")

    let document = data.map { data in
      JSON.object([
        "data": data,
        "included": .array(Array(relationships.included.values)),
      ])
    }

    return document >>- Document<T>.decodeResource
  }
}
