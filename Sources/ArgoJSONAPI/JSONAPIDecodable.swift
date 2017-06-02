import Argo

public protocol JSONAPIDecodable {
  associatedtype DecodedType
  static func decode(id: String, attributes: JSON) -> Decoded<DecodedType>
}
