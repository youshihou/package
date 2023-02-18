import Cocoa
import SwiftUI

struct Embed<V: View>: AttributedStringConvertible {
    var proposal: ProposedViewSize = .unspecified
    @ViewBuilder var view: V
    
    @MainActor
    func attributedString(environment: Environment) -> [NSAttributedString] {
        let renderer = ImageRenderer(content: view)
        renderer.proposedSize = proposal
        let resultSize = renderer.nsImage!.size
        let data = NSMutableData()
        renderer.render { size, renderer in
            var mediaBox = CGRect(origin: .zero, size: resultSize)
            guard let consumer = CGDataConsumer(data: data),
                    let pdfCtx = CGContext(consumer: consumer, mediaBox: &mediaBox, nil)
            else { return }
            pdfCtx.beginPDFPage(nil)
            pdfCtx.translateBy(x: mediaBox.size.width / 2 - size.width / 2,
                               y: mediaBox.size.height / 2 - size.height / 2)
            renderer(pdfCtx)
            pdfCtx.endPDFPage()
            pdfCtx.closePDF()
        }
        return NSImage(data: data as Data)!.attributedString(environment: environment)
    }
}
