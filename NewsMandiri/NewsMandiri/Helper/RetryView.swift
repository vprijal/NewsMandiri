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

    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        if #available(iOS 13.0, *) {
            imageView.image = UIImage(systemName: "exclamationmark.triangle")
        }
        imageView.tintColor = .systemRed
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Failed to Load Data"
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Something went wrong. Please try again."
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    var buttonRetry: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Retry", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        button.backgroundColor = UIColor(named: "#002E4E") ?? UIColor(red: 0/255, green: 46/255, blue: 78/255, alpha: 1)
        button.setCorner(radius: 8)
        return button
    }()

    lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [imageView, titleLabel, descriptionLabel, buttonRetry])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 12
        stack.setCustomSpacing(16, after: descriptionLabel)
        return stack
    }()

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
        addSubview(stackView)
        
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(60)
        }
        
        buttonRetry.snp.makeConstraints { make in
            make.width.equalTo(140)
            make.height.equalTo(44)
        }
        
        stackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.leading.greaterThanOrEqualToSuperview().offset(24)
            make.trailing.lessThanOrEqualToSuperview().offset(-24)
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
