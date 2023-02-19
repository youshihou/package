import XCTest
@testable import Backend

struct Profile: Rule {
    var id: UUID
    var rules: some Rule {
        "User Profile \(id)"
    }
}

struct Users: Rule {
    var rules: some Rule {
        "User Index"
    }
}

struct Root: Rule {
    var rules: some Rule {
        Users().path("users")
        "Index"
    }
}

final class BackendTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Backend().text, "Hello, World!")
    }
    
    func testUsers() throws {
        XCTAssertEqual(Users().run(), Response(body: "User Index".toData))
    }
}
