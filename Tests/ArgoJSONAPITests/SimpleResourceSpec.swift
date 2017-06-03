import ArgoJSONAPI
import Quick
import Nimble
import Foundation
import TestResources

final class SimpleResourceSpec: QuickSpec {
  override func spec() {
    describe("decoding") {
      it("decodes a resource with no attributes") {
        let resource: EmptyResource? = decode([
          "data": [
            "type": "empty",
            "id": "void",
          ],
        ])

        expect(resource?.id) == "void"
      }

      it("decodes a resource with primitive attributes") {
        let resource: BasicResource? = decode([
          "data": [
            "type": "basic",
            "id": "1",
            "attributes": [
              "string": "foobar",
              "int": 123,
            ],
          ],
        ])

        expect(resource?.id) == "1"
        expect(resource?.string) == "foobar"
        expect(resource?.int) == 123
      }
    }
  }
}
