import Foundation

public struct Response: Hashable, Codable {
    public var statusCode: Int = 200
    public var body: Data
    
    public init(statusCode: Int = 200, body: Data) {
        self.statusCode = statusCode
        self.body = body
    }
}
