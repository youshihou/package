import Foundation

public protocol Rule {
    associatedtype R: Rule
    @RuleBuilder var rules: R { get }
}

extension Rule {
    public func run() -> Response? {
        if let b = self as? BuiltinRule {
            return b.execute()
        } else {
            return rules.run()
        }
    }
}


protocol BuiltinRule {
    func execute() -> Response?
}

extension BuiltinRule {
    public var rules: Never {
        fatalError()
    }
}

extension Never: Rule {
    public var rules: some Rule {
        fatalError()
    }
}


extension Response: Rule, BuiltinRule {
    func execute() -> Response? {
        self
    }
}


public protocol ToData {
    var toData: Data { get }
}

extension String: ToData {
    public var toData: Data {
        data(using: .utf8)!
    }
}
