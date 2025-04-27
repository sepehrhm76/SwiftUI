//
//  TopAlert.swift
//  SwiftUILearning
//
//  Created by Sepehr on 4/15/25.
//

import UIKit

class TopAlert: UIView {
    
    enum AlertType: String {
        case error = "Error", success = "Success", warning = "Warning"
    }
    
    public static let shared = TopAlert()
    
    private let haptic = UINotificationFeedbackGenerator()
    
    private let firstFrameAlertWidthAndHeight = 70.0
    
    private let sideMargin: CGFloat = 15.0
    private let animationDuration = 0.2
    
    private var timer: Timer?
    public private(set) var timerCounter = 2.5
    
    private var isHighlightedInternal = false
    
    private var undoButtonAction: (() -> Void)?
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var undoButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.setTitle("Undo", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.isHidden = true
        button.addTarget(self, action: #selector(undoButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.isHidden = true
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.isHidden = true
        label.font = UIFont.systemFont(ofSize: 14)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private func highlight() {
        if !isHighlightedInternal {
            isHighlightedInternal = true
            UIView.animate(withDuration: 0.1) {
                self.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
            }
        }
    }
    
    private func unhighlight() {
        if isHighlightedInternal {
            isHighlightedInternal = false
            UIView.animate(withDuration: 0.1) {
                self.transform = CGAffineTransform.identity
            }
        }
    }
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        self.addGestureRecognizer(panGesture)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @available(iOS 13.0, *)
    public func show(type: AlertType, message: String, haveToShowUndo: Bool = false, undoAction: (() -> Void)? = nil) {
        haptic.notificationOccurred(.error)
        guard timer?.isValid != true else { return }
        unhighlight()
        let iconImageName: String
        let iconColor: UIColor
        
        var keyWindowScene: UIWindowScene?
        
        keyWindowScene = UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .first as? UIWindowScene
        guard keyWindowScene != nil else {
            return
        }
        
        guard let keyWindow = keyWindowScene?.windows.first(where: { $0.isKeyWindow }) else {
            return
        }
        
        keyWindow.addSubview(self)
        layer.cornerRadius = firstFrameAlertWidthAndHeight / 2.0
        frame = CGRect(x: (keyWindow.frame.width / 2.0) - (firstFrameAlertWidthAndHeight / 2),
                       y: -firstFrameAlertWidthAndHeight,
                       width: firstFrameAlertWidthAndHeight,
                       height: firstFrameAlertWidthAndHeight)
        
        switch type {
        case .error:
            titleLabel.text = AlertType.error.rawValue
            iconImageName = "xmark.circle.fill"
            iconColor = #colorLiteral(red: 0.9450266957, green: 0.1770647168, blue: 0.1695831418, alpha: 1)
            backgroundColor = #colorLiteral(red: 0.9924299121, green: 0.9287281632, blue: 0.9348064065, alpha: 1)
        case .success:
            titleLabel.text = AlertType.success.rawValue
            iconImageName = "checkmark.circle.fill"
            iconColor = #colorLiteral(red: 0.192897588, green: 0.7594278455, blue: 0.516956985, alpha: 1)
            backgroundColor = #colorLiteral(red: 0.9170510173, green: 0.9557631612, blue: 0.9270833135, alpha: 1)
        case .warning:
            titleLabel.text = AlertType.warning.rawValue
            iconImageName = "exclamationmark.circle.fill"
            iconColor = #colorLiteral(red: 0.9832932353, green: 0.7587742209, blue: 0.1803134978, alpha: 1)
            backgroundColor = #colorLiteral(red: 0.9976586699, green: 0.9765452743, blue: 0.9135218859, alpha: 1)
        }
        
        iconImageView.image = UIImage(systemName: iconImageName)
        
        iconImageView.tintColor = iconColor
        setIconSize()
        addSubview(iconImageView)
        
        messageLabel.text = message
        
        UIView.animateKeyframes(withDuration: animationDuration, delay: 0, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1.0) {
                self.frame.origin.y = 50.0
            }
        }, completion: { _ in
            self.addSubview(self.titleLabel)
            self.addSubview(self.messageLabel)
            if haveToShowUndo {
                self.addSubview(self.undoButton)
                self.undoButtonAction = undoAction
            }
            UIView.animate(withDuration: self.animationDuration, animations: {
                self.frame.size.width = keyWindow.frame.width - (self.sideMargin * 2)
                self.frame.origin.x = self.sideMargin
                self.layer.cornerRadius = (self.firstFrameAlertWidthAndHeight / 2) / 2
                self.iconImageView.frame = CGRect(x: 10, y: 10, width: 30, height: 30)
                self.titleLabel.frame = CGRect(x: 50, y: 12, width: (self.frame.width / 100) * 30, height: (self.frame.height / 100) * 35)
                self.undoButton.frame = CGRect(x: self.frame.width - 50 - 25, y: (self.frame.height / 2) - 25, width: 50, height: 50)
                self.messageLabel.frame = CGRect(x: 50, y: 40, width: (self.frame.width / 100) * 85, height: (self.frame.height / 100) * 35)
            }, completion: { _ in
                self.titleLabel.isHidden = false
                self.messageLabel.isHidden = false
                self.undoButton.isHidden = false
            })
        })
        startTimer(duration: self.timerCounter)
    }
    
    public func hide(withAnimation: Bool) {
        UIView.animate(withDuration: animationDuration) {
            if withAnimation {
                var newBounds = self.bounds
                newBounds.size.width = self.firstFrameAlertWidthAndHeight
                self.bounds = newBounds
                self.layer.cornerRadius = self.firstFrameAlertWidthAndHeight / 2
                self.setIconSize()
            }
            self.titleLabel.isHidden = true
            self.messageLabel.isHidden = true
            self.undoButton.isHidden = true
        } completion: { _ in
            UIView.animate(withDuration: self.animationDuration) {
                self.frame.origin.y = -self.firstFrameAlertWidthAndHeight
            } completion: { _ in
                self.titleLabel.removeFromSuperview()
                self.messageLabel.removeFromSuperview()
                self.undoButton.removeFromSuperview()
                self.removeFromSuperview()
                self.stopTimer()
            }
        }
    }
    
    private func setIconSize() {
        let adjustedWidth = bounds.width + 11
        let adjustedHeight = bounds.height + 11
        let iconOriginX = (bounds.width - adjustedWidth) / 2
        let iconOriginY = (bounds.height - adjustedHeight) / 2
        iconImageView.frame = CGRect(x: iconOriginX, y: iconOriginY, width: adjustedWidth, height: adjustedHeight)
    }
    
    private func startTimer(duration: TimeInterval) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: duration, repeats: false) { [weak self] _ in
            self?.hide(withAnimation: true)
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        stopTimer()
        highlight()
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        startTimer(duration: timerCounter)
        unhighlight()
    }
    
    @objc private func undoButtonTapped() {
        undoButtonAction?()
        hide(withAnimation: true)
    }
    
    @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self)
        
        switch gesture.state {
        case .changed:
            stopTimer()
            if translation.y < 0 {
                self.frame.origin.y += translation.y
                gesture.setTranslation(.zero, in: self)
            } else if translation.y > 0 && self.frame.origin.y <= 60.0 {
                self.frame.origin.y += translation.y
                gesture.setTranslation(.zero, in: self)
            }
        case .ended:
            unhighlight()
            startTimer(duration: timerCounter)
            if self.frame.origin.y < 25 {
                hide(withAnimation: false)
            } else {
                UIView.animate(withDuration: animationDuration) {
                    self.frame.origin.y = 50
                }
            }
        default:
            break
        }
    }
}
