//
//  main.swift
//  
//
//  Created by Ankui on 3/11/23.
//

import Foundation
import Backend
import FlyingFox

struct User {
    
}

func loadUser(id: Int) async throws -> User? {
    User()
}

struct Users: Rule {
    var id: Int
    
    func rules() async throws -> some Rule {
        if let _ = try await loadUser(id: id) {
            "User \(id)"
        }
    }
}

struct Home: Rule {
    func rules() async throws -> some Rule {
        Users(id: 1).path("users")
        "Home"
    }
}


let server = HTTPServer(port: 8002) { request in
    guard let resp = try await Home().run(environment: .init(request: .init(path: request.path))) else {
        return HTTPResponse(statusCode: .notFound)
    }
    return HTTPResponse(statusCode: .ok, body: resp.body)
}

try await server.start()
