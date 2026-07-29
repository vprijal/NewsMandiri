//
//  RetryView.swift
//  NewsMandiri
//
//  Created by vprijal on 29/07/26.
//

import Foundation
import UIKit
import SnapKit

class RetryView: UIView {

    var buttonRetry = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func setupView() {
        backgroundColor = .white
        addSubview(buttonRetry)
        buttonRetry.setTitle("Retry", for: .normal)
        buttonRetry.setTitleColor(.black, for: .normal)
        buttonRetry.backgroundColor = .red
        buttonRetry.setTitleColor(.white, for: .normal)
        buttonRetry.setCorner(radius: 8)
        buttonRetry.snp.makeConstraints { make in
            make.width.equalTo(120)
            make.height.equalTo(45)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}


extension UIView {
    func setCorner(radius: CGFloat) {
        layer.cornerRadius = radius
        clipsToBounds = true
    }
    
    func setBorder(width: CGFloat, color: UIColor) {
        layer.borderColor = color.cgColor
        layer.borderWidth = width
    }
}

extension UIControl {

    private static var _actionHandlers = [String:[UInt:((UIControl) -> Void)]]()

    private func getAddressAsString() -> String {
        let addr = Unmanaged.passUnretained(self).toOpaque()
        return "\(addr)"
    }

    private func getHandler(_ event: UIControl.Event) -> ((UIControl) -> Void)? {
        return UIControl._actionHandlers[
            self.getAddressAsString()
        ]?[event.rawValue]
    }
    
    
    func action(_ event: UIControl.Event, _ action:@escaping (UIControl) -> Void) {
        let id = self.getAddressAsString()
        if UIControl._actionHandlers[id] == nil {
            UIControl._actionHandlers[id] = [UInt:((UIControl) -> Void)]()
        }

        UIControl._actionHandlers[id]?[event.rawValue] = action

        switch event {
            case .touchUpInside:
                self.addTarget(self, action: #selector(triggerTouchUpInside), for: event)
                break
            default:
                return;
        }
    }
    
    @objc private func triggerTouchUpInside() {
        getHandler(.touchUpInside)?(self)
    }
}
