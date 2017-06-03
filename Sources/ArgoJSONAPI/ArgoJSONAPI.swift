import Argo
import Runes

public enum JSONAPI {
}

public func decode<T: JSONAPIDecodable>(_ object: Any) -> Decoded<T>
  where T.DecodedType == T
{
  let json = JSON(object)

  return JSONAPI.Document<T>.decode(json) >>- { document in
    switch document {
    case let .resource(resource):
      return pure(resource)
    case let .collection(collection):
      let typeDescription = String(describing: T.self)
      return .typeMismatch(expected: typeDescription, actual: collection)
    }
  }
}

public func decode<T: JSONAPIDecodable>(_ object: Any) -> Decoded<[T]>
  where T.DecodedType == T
{
  let json = JSON(object)

  return JSONAPI.Document<T>.decode(json) >>- { document in
    switch document {
    case let .collection(collection):
      return pure(collection)
    case let .resource(resource):
      let typeDescription = String(describing: [T].self)
      return .typeMismatch(expected: typeDescription, actual: resource)
    }
  }
}

public func decode<T: JSONAPIDecodable>(_ object: Any) -> T?
  where T.DecodedType == T
{
  let decoded: Decoded<T> = decode(object)
  return decoded.value
}

public func decode<T: JSONAPIDecodable>(_ object: Any) -> [T]?
  where T.DecodedType == T
{
  let decoded: Decoded<[T]> = decode(object)
  return decoded.value
}
