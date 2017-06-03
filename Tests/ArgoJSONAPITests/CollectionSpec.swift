import ArgoJSONAPI
import Quick
import Nimble

final class CollectionSpec: QuickSpec {
  override func spec() {
    describe("decoding") {
      it("decodes a collection of resources") {
        let resources: [EmptyResource]? = decode([
          "data": [
            ["type": "empty", "id": "1"],
            ["type": "empty", "id": "2"],
          ],
        ])

        expect(resources) == [
          EmptyResource(id: "1"),
          EmptyResource(id: "2"),
        ]
      }
    }
  }
}
