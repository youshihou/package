import Foundation

public struct EnvironmentValues {
    public var request: Request
    public var remainingPath: [String]
    
    public init(request: Request) {
        self.request = request
        assert(request.path.first == "/")
        remainingPath = (request.path as NSString).pathComponents
        assert(remainingPath.first == "/")
        remainingPath.removeFirst()
    }
}
