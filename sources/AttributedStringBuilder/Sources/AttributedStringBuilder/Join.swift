import Cocoa

struct Joined<Content: AttributedStringConvertible>: AttributedStringConvertible {
    var separator: AttributedStringConvertible = "\n"
    @AttributedStringBuilder var content: Content
    
    @MainActor
    func attributedString(environment: Environment) -> [NSAttributedString] {
        [single(environment: environment)]
    }
    
    @MainActor
    func single(environment: Environment) -> NSAttributedString {
        let pieces = content.attributedString(environment: environment)
        guard let f = pieces.first else { return .init() }
        let result = NSMutableAttributedString(attributedString: f)
        let sep = separator.attributedString(environment: environment)
        for p in pieces.dropFirst() {
            for s in sep {
                result.append(s)
            }
            result.append(p)
        }
        return result
    }
}

extension AttributedStringConvertible {
    func joined(separator: AttributedStringConvertible = "\n") -> some AttributedStringConvertible {
        Joined(separator: separator) {
            self
        }
    }    
}
