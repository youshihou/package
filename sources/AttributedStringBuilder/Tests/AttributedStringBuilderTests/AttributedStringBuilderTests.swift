import XCTest
@testable import AttributedStringBuilder
import SwiftUI



@AttributedStringBuilder
var example: some AttributedStringConvertible {
    "Hello World!"
        .bold()
    Array(repeating:
    """
    This is some markdown with **strong** text. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas tempus, tortor eu maximus gravida, ante diam fermentum magna, in gravida ex tellus ac purus.
    
    Another *paragraph*.
    """.markdown(stylesheet: CustomStylesheet()) as AttributedStringConvertible, count: 20)
    NSImage(systemSymbolName: "hand.wave", accessibilityDescription: nil)!
    Embed(proposal: .init(width: 200, height: nil)) {
        HStack {
            Image(systemName: "hand.wave")
            Text("Hello from SwiftUI")
            Color.red.frame(width: 100, height: 50)
        }
    }
}

let sampleAttributes = Attributes(family: "Menlo", size: 16)




final class AttributedStringBuilderTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
//        XCTAssertEqual(AttributedStringBuilder().text, "Hello, World!")
    }
    
    @MainActor
    func testPDF() {
        let data = example
            .joined(separator: "\n")
            .run(environment: .init(attributes: sampleAttributes))
            .pdf()
        try? data.write(to: .desktopDirectory.appending(component: "out.pdf"))
    }
}
