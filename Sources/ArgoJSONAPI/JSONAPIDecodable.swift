import Argo

public protocol JSONAPIDecodable {
  associatedtype DecodedType
  static var resourceType: String { get }
  static func decode(_ data: JSONAPI.Data) -> Decoded<DecodedType>
}
