extension Dictionary {
  func inserting(_ value: Value, forKey key: Key) -> Dictionary {
    var dictionary = self
    dictionary[key] = value
    return dictionary
  }
}
