#if DEBUG
import SwiftUI

@AttributedStringBuilder
var example: some AttributedStringConvertible {
    "Hello World!"
        .bold()
    NSImage(systemSymbolName: "hand.wave", accessibilityDescription: nil)!
    Embed(proposal: .init(width: 200, height: nil)) {
        HStack {
            Image(systemName: "hand.wave")
            Text("Hello from SwiftUI")
            Color.red.frame(width: 100, height: 50)
        }
    }
    try! AttributedString(markdown: "Hello *World*")
}

struct TextView: NSViewRepresentable {
    var attributedString: NSAttributedString
    
    func makeNSView(context: Context) -> NSTextView {
        let v = NSTextView()
        v.isEditable = false
        v.textContainer!.lineFragmentPadding = 0
        v.textContainer!.widthTracksTextView = false
        v.drawsBackground = true
        v.backgroundColor = .white
        return v
    }
    
    func updateNSView(_ nsView: NSTextView, context: Context) {
        nsView.textStorage?.setAttributedString(attributedString)
    }
    
    func sizeThatFits(_ proposal: ProposedViewSize, nsView: NSTextView, context: Context) -> CGSize? {
        let size = proposal.replacingUnspecifiedDimensions(by: .zero)
        let c = nsView.textContainer!
        c.size = size
        nsView.layoutManager?.ensureLayout(for: c)
        return nsView.layoutManager?.usedRect(for: c).size
    }
}


let sampleAttributes = Attributes(family: "Tiempos Text", size: 20)

struct DebugPreview: PreviewProvider {
    static var previews: some View {
        let attStr = example
            .joined()
            .run(environment: .init(attributes: sampleAttributes))
        TextView(attributedString: attStr)
            .previewLayout(.sizeThatFits)
    }
}
#endif
