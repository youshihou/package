import Cocoa

struct Attributes {
    var family: String = "Helvetica"
    var size: CGFloat = 14
    var traits: NSFontTraitMask = []
    var weight: Int = 5
    var foregroundColor: NSColor = .black
    
    var bold: Bool {
        get {
            traits.contains(.boldFontMask)
        }
        set {
            if newValue {
                traits.insert(.boldFontMask)
            } else {
                traits.remove(.boldFontMask)
            }
        }
    }
    
    var dict: [NSAttributedString.Key: Any] {
        let fm = NSFontManager.shared
        let font = fm.font(withFamily: family, traits: traits, weight: weight, size: size)
        return [
            .font: font,
            .foregroundColor: foregroundColor
        ]
    }
}


struct Modify: AttributedStringConvertible {
    var modify: (inout Attributes) -> ()
    var contents: AttributedStringConvertible
    
    func attributedString(environment: Environment) -> [NSAttributedString] {
        var copy = environment
        modify(&copy.attributes)
        return contents.attributedString(environment: copy)
    }
}

extension AttributedStringConvertible {
    func bold() -> some AttributedStringConvertible {
        Modify(modify: { $0.bold = true }, contents: self)
    }
    
    func foregroundColor(_ color: NSColor) -> some AttributedStringConvertible {
        Modify(modify: { $0.foregroundColor = color }, contents: self)
    }
}
