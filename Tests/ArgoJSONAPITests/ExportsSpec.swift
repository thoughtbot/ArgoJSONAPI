import ArgoJSONAPI
import Quick

final class ExportsSpec: QuickSpec {
  override func spec() {
    it("exports Argo.Decoded") {
      _ = Decoded<Int>.self
    }
  }
}
