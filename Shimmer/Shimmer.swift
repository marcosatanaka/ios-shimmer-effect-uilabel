import Foundation
import UIKit

class ShimmerableUILabel: UILabel {

    let gradient = CAGradientLayer()
    let animation = CABasicAnimation(keyPath: "locations")
    let shimmerKey = "io.monroy.shimmer.key"
    let lightColor = UIColor(cgColor: UIColor.white.withAlphaComponent(0.1).cgColor)
    let darkColor = UIColor(cgColor: UIColor.black.withAlphaComponent(1).cgColor)
    var isShimmering: Bool = false

    // MARK: - Public interface

    func showLoading() {
        backgroundColor = .quaternaryLabel
        text = " "
        start(count: 0, height: estimatedHeightOfLabel(text: " "))
    }

    func hideLoading() {
        backgroundColor = .clear
        stop()
    }

    // MARK: - Internal methods

    /// If can't get the label height from bounds.size.height, calculate an estimate
    private func estimatedHeightOfLabel(text: String) -> CGFloat {
        let size = CGSize(width: frame.width - 16, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: font as Any]
        return String(text).boundingRect(with: size, options: options, attributes: attributes, context: nil).height
    }

    private func stop() {
        guard isShimmering else {return}
        self.layer.mask?.removeAnimation(forKey: shimmerKey)
        self.layer.mask = nil
        isShimmering = false
        self.layer.setNeedsDisplay()
    }

    private func start(count: Int = 3, height: CGFloat = 0) {
        guard !isShimmering else {return}

        CATransaction.begin()
        CATransaction.setCompletionBlock({
            self.stop()
        })

        isShimmering = true

        gradient.colors = [UIColor.black.withAlphaComponent(1).cgColor,
                            UIColor.white.withAlphaComponent(0.1).cgColor,
                            UIColor.black.withAlphaComponent(1).cgColor];
        gradient.frame = CGRect(x: CGFloat(-2 * self.bounds.size.width),
                                y: CGFloat(0.0),
                                width: CGFloat(4 * self.bounds.size.width),
                                height: CGFloat(self.bounds.size.height) == 0 ? height : CGFloat(self.bounds.size.height))
        gradient.startPoint = CGPoint(x: Double(0.0), y: Double(0.5));
        gradient.endPoint = CGPoint(x: Double(1.0), y: Double(0.5));
        gradient.locations = [0.4, 0.5, 0.6];

        animation.duration = 1.0
        animation.repeatCount = (count > 0) ? Float(count) : .infinity
        animation.fromValue = [0.0, 0.12, 0.3]
        animation.toValue = [0.6, 0.86, 1.0]

        gradient.add(animation, forKey: shimmerKey)
        self.layer.mask = gradient;

        CATransaction.commit()
    }

}
