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
  }
}
