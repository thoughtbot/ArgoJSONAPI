import ArgoJSONAPI
import Quick
import Nimble

final class RelationshipsSpec: QuickSpec {
  override func spec() {
    it("decodes a resource with a has-one relationship") {
      let resource: HasOneResource? = decode([
        "data": [
          "type": "has-one",
          "id": "parent",
          "attributes": [
            "name": "Some Parent",
          ],
          "relationships": [
            "child": [
              "data": [
                "type": "child",
                "id": "child",
              ],
            ],
          ],
        ],
        "included": [
          [
            "type": "child",
            "id": "child",
            "attributes": [
              "name": "Some Child",
            ],
          ],
        ]
      ])

      expect(resource?.id) == "parent"
      expect(resource?.name) == "Some Parent"
      expect(resource?.child.id) == "child"
      expect(resource?.child.name) == "Some Child"
    }

    it("decodes a resource with a has-many relationship") {
      let resource: HasManyResource? = decode([
        "data": [
          "type": "has-many",
          "id": "parent",
          "attributes": [
            "name": "Busy Parent",
          ],
          "relationships": [
            "children": [
              "data": [
                ["type": "child", "id": "first"],
                ["type": "child", "id": "second"],
              ],
            ],
          ],
        ],
        "included": [
          [
            "type": "child",
            "id": "first",
            "attributes": [
              "name": "First Child",
            ],
          ],
          [
            "type": "child",
            "id": "second",
            "attributes": [
              "name": "Second Child",
            ],
          ],
        ]
      ])

      expect(resource?.id) == "parent"
      expect(resource?.name) == "Busy Parent"
      expect(resource?.children) == [
        ChildResource(id: "first", name: "First Child"),
        ChildResource(id: "second", name: "Second Child"),
      ]
    }
  }
}
