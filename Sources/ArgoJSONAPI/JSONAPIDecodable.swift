import Argo

public protocol JSONAPIDecodable {
  associatedtype DecodedType
  static var resourceType: String { get }
  static func decode(id: String, attributes: JSON) -> Decoded<DecodedType>
}
