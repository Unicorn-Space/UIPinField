import UIKit

@IBDesignable public class UIPinFeild: UIControl, UIKeyInput {
    
    @IBInspectable public var digitCellsSelectionColor: UIColor = UIColor.black {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable public var digitCellsSelectionStroke: UIColor = UIColor.clear {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable public var digitCellsFillColor: UIColor = UIColor.black {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable public var digitsCellStrokeColor: UIColor = UIColor.clear {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable public var textColor: UIColor = UIColor.white {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable public var font: UIFont = UIFont.systemFont(ofSize: 32.0) {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable public var hideDigits: Bool = false {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable public var digitsCount: Int = 5 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable public var digitsCellsInset: Float = 10 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable public var digitsCellsStrokeWidth: CGFloat = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    
    private var index = 0
    private var digits: [String?] = []
    
    override public var canBecomeFirstResponder: Bool {
        true
    }
    
    override init(frame: CGRect) {
      super.init(frame: frame)
        self.digits = [String?](repeating: nil, count: digitsCount)
        addTarget(self, action: #selector(onTap), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
        self.digits = [String?](repeating: nil, count: digitsCount)
        addTarget(self, action: #selector(onTap), for: .touchUpInside)
    }
    
    @objc private func onTap(_: AnyObject) {
      becomeFirstResponder()
    }
    
    public var hasText: Bool {
        var empty = true
        for digit in digits {
            if digit != nil {
                empty = false
                break
            }
        }
        
        return empty
    }

    public func insertText(_ text: String) {
        if index < digitsCount {
            digits[index] = text
            index = min(index + 1, digitsCount)
        }
        setNeedsDisplay()
    }

    public func deleteBackward() {
        index = max(index - 1, 0)
        digits[index] = nil
        setNeedsDisplay()
    }
    
    override public func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        let digitCellWidth = (bounds.width - CGFloat(digitsCellsInset) * CGFloat(digitsCount - 1)) / CGFloat(digitsCount)
        let digitCellHeight = bounds.height
        
        var currentX = CGFloat(0)
        
        for i in 0..<digitsCount {
            if i == index {
                drawCell(withWidth: digitCellWidth, height: digitCellHeight, atX: currentX, y: 0, withRadius: 12, fillColor: digitCellsSelectionColor, strokeColor: digitCellsSelectionStroke, and: context)
            } else {
                drawCell(withWidth: digitCellWidth, height: digitCellHeight, atX: currentX, y: 0, withRadius: 12, fillColor: digitCellsFillColor, strokeColor: digitsCellStrokeColor, and: context)
            }
            
            if let digit = digits[i] {
                if hideDigits {
                    drawHiddenCharacter(withWidth: digitCellWidth, height: digitCellHeight, atX: currentX, y: 0, and: context)
                } else {
                    draw(text: digit, withWidth: digitCellWidth, height: digitCellHeight, atX: currentX, y: 0, and: context)
                }
            }
            
            currentX += digitCellWidth + CGFloat(digitsCellsInset)
        }
    }
    
    private func drawCell(withWidth width: CGFloat, height: CGFloat, atX x: CGFloat, y: CGFloat, withRadius radius: CGFloat, fillColor: UIColor, strokeColor: UIColor, and context: CGContext) {
        context.saveGState()

        let rect = CGRect(x: x, y: y, width: width, height: height)
        let clipPath: CGPath = UIBezierPath(roundedRect: rect, cornerRadius: radius).cgPath

        context.addPath(clipPath)
        
        context.setFillColor(fillColor.cgColor)
        
        context.setStrokeColor(strokeColor.cgColor)
        context.setLineWidth(digitsCellsStrokeWidth)

        context.drawPath(using: .fillStroke)
        
        context.restoreGState()
    }
    
    private func draw(text: String, withWidth width: CGFloat, height: CGFloat, atX x: CGFloat, y: CGFloat, and context: CGContext) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        let attributes: [NSAttributedString.Key : Any] = [
            .paragraphStyle: paragraphStyle,
            .font: font,
            .foregroundColor: textColor

        ]

        let attributedString = NSAttributedString(string: text, attributes: attributes)

        let stringRect = CGRect(x: x, y: y + height / 2 - attributedString.height(containerWidth: width) / 2, width: width, height: height)
        attributedString.draw(in: stringRect)
    }
    
    private func drawHiddenCharacter(withWidth width: CGFloat, height: CGFloat, atX x: CGFloat, y: CGFloat, and context: CGContext) {
        context.saveGState()
        
        context.setFillColor(textColor.cgColor)
        context.setStrokeColor(UIColor.clear.cgColor)
        
        let radius = CGFloat(6)
        
        context.addEllipse(in: CGRect(x: x  + width / 2 - radius, y: y + height / 2 - radius, width: radius * 2, height:  radius * 2))
        context.drawPath(using: .fillStroke)
        
        context.restoreGState()
    }
    
}
