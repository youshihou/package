import Foundation

@resultBuilder
public struct RuleBuilder {
    public static func buildPartialBlock<R: Rule>(first: R) -> some Rule {
        first
    }
    
    public static func buildPartialBlock<D: ToData>(first: D) -> some Rule {
        Response(body: first.toData)
    }
    
    public static func buildPartialBlock<R0: Rule, R1: Rule>(accumulated: R0, next: R1) -> some Rule {
        RulePair(r0: accumulated, r1: next)
    }
    
    public static func buildPartialBlock<R0: Rule, R1: ToData>(accumulated: R0, next: R1) -> some Rule {
        RulePair(r0: accumulated, r1: Response(body: next.toData))
    }
}


struct RulePair<R0: Rule, R1: Rule>: BuiltinRule, Rule {
    var r0: R0
    var r1: R1
    
    func execute() -> Response? {
        fatalError()
    }
}
