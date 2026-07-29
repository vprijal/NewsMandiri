//
//  CollectionViewState.swift
//  NewsMandiri
//
//  Created by vprijal on 29/07/26.
//

import Foundation
import UIKit
import SnapKit

enum ICGCollectionViewState {
    case loading
    case done
    case retry
}

extension UICollectionView {

    func setStateView(with state: ICGCollectionViewState, completion:(() -> Void)? = nil) {
        lazy var view = UIView(frame: self.frame)
        switch state {
        case .loading:
            let subview = NewsLoadingState(frame: view.frame)
            view.addSubview(subview)
            subview.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.bottom.equalToSuperview()
                make.left.equalToSuperview()
                make.right.equalToSuperview()
            }
            self.backgroundView = view
            completion?()
            return
        case .done:
            self.backgroundView = view
            completion?()
            return
        
        case .retry:
            let subView = RetryView(frame: view.frame)
            view.addSubview(subView)
            subView.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.bottom.equalToSuperview()
                make.left.equalToSuperview()
                make.right.equalToSuperview()
            }
            self.backgroundView = view
            subView.buttonRetry.action(.touchUpInside) { _ in
                completion?()
            }
        }
    }
}
