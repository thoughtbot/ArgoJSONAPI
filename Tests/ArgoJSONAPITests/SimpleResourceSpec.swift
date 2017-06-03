import ArgoJSONAPI
import Quick
import Nimble

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

    describe("failed decoding") {
      it("fails to decode if the resource type doesn't match") {
        let resource: Decoded<EmptyResource> = decode([
          "data": [
            "type": "not-empty",
            "id": "whatever",
          ],
        ])

        expect(resource.value).to(beNil())
        expect(resource.error).toNot(beNil())
      }
    }
  }
}
