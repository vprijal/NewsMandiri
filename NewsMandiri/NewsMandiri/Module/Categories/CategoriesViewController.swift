//
//  CategoriesViewController.swift
//  NewsMandiri
//
//  Created by vprijal on 29/07/26.
//  
//

import UIKit

class CategoriesViewController: UIViewController {
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Properties
    var presenter: ViewToPresenterCategoriesProtocol?
    
}

extension CategoriesViewController: PresenterToViewCategoriesProtocol{
    // TODO: Implement View Output Methods
}
