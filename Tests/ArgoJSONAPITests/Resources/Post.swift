import ArgoJSONAPI
import Curry
import Runes

struct Post {
  var slug: String
  var title: String
  var comments: [Comment]
}

extension Post: JSONAPIDecodable {
  static let resourceType = "posts"

  static func decode(_ data: JSONAPI.Data) -> Decoded<Post> {
    return curry(Post.init)
      <^> pure(data.id)
      <*> data.attributes <| "title"
      <*> data.relationships <|| "comments"
  }
}
