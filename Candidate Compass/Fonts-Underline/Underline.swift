import UIKit

extension UILabel {
    func addUnderline() {
        let border = CALayer()
        let borderWidth = CGFloat(1.0)
        let fontAttributes = [NSAttributedString.Key.font: self.font ?? UIFont.systemFont(ofSize: 17.0)]
        let oneCharacterWidth = ":".size(withAttributes: fontAttributes).width
        let underlineWidth = self.intrinsicContentSize.width - oneCharacterWidth
        border.borderColor = UIColor.black.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - borderWidth, width: underlineWidth, height: borderWidth)
        border.borderWidth = borderWidth
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}
