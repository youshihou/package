import XCTest
@testable import Backend

struct Profile: Rule {
    var id: Int

    func rules() async throws -> some Rule {
        "User Profile \(id)"
    }
}

struct Users: Rule {
    func rules() async throws -> some Rule {
        PathReader { c in
            if let id = Int(c) {
                Profile(id: id)
            } else {
                "Not found"
            }
        }
        "User Index"
    }
}

struct Root: Rule {
    func rules() async throws -> some Rule {
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
//        XCTAssertEqual(Users().run(environment: .init(request: .init(path: "/"))), Response(body: "User Index".toData))
//        XCTAssertEqual(Root().run(environment: .init(request: .init(path: "/"))), Response(body: "Index".toData))
//        XCTAssertEqual(Root().run(environment: .init(request: .init(path: "/users"))), Response(body: "User Index".toData))
//        XCTAssertEqual(Root().run(environment: .init(request: .init(path: "/users/1"))), Response(body: "User Profile 1".toData))
//        XCTAssertEqual(Root().run(environment: .init(request: .init(path: "/users/foo"))), Response(body: "Not found".toData))
    }
}
