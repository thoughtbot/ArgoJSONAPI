import ArgoJSONAPI
import Curry
import Runes

struct Member {
  var id: String
  var name: String
}

extension Member: Equatable {
  static func == (lhs: Member, rhs: Member) -> Bool {
    return lhs.id == rhs.id
      && lhs.name == rhs.name
  }
}

extension Member: JSONAPIDecodable {
  static let resourceType = "members"

  static func decode(_ data: JSONAPI.Data) -> Decoded<Member> {
    return curry(Member.init)
      <^> pure(data.id)
      <*> data.attributes <| "name"
  }
}
