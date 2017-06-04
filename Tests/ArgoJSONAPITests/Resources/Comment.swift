import ArgoJSONAPI
import Curry
import Runes

struct Comment {
  var id: String
  var body: String
  var author: Member
}

extension Comment: Equatable {
  static func == (lhs: Comment, rhs: Comment) -> Bool {
    return lhs.id == rhs.id
      && lhs.body == rhs.body
      && lhs.author == rhs.author
  }
}

extension Comment: JSONAPIDecodable {
  static let resourceType = "comments"

  static func decode(_ data: JSONAPI.Data) -> Decoded<Comment> {
    return curry(Comment.init)
      <^> pure(data.id)
      <*> data.attributes <| "body"
      <*> data.relationships <| "author"
  }
}
