import Foundation

public protocol Rule {
    associatedtype R: Rule
    @RuleBuilder var rules: R { get }
}

extension Rule {
    public func run(environment: EnvironmentValues) -> Response? {
        if let b = self as? BuiltinRule {
            return b.execute(environment: environment)
        } else {
            return rules.run(environment: environment)
        }
    }
}


protocol BuiltinRule {
    func execute(environment: EnvironmentValues) -> Response?
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
    func execute(environment: EnvironmentValues) -> Response? {
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
