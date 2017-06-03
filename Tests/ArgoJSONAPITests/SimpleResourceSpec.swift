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
    }
  }
}
