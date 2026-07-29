//
//  CategoriesContract.swift
//  NewsMandiri
//
//  Created by vprijal on 29/07/26.
//  
//

import Foundation


// MARK: View Output (Presenter -> View)
protocol PresenterToViewCategoriesProtocol: AnyObject {
   
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterCategoriesProtocol: AnyObject {
    
    var view: PresenterToViewCategoriesProtocol? { get set }
    var interactor: PresenterToInteractorCategoriesProtocol? { get set }
    var router: PresenterToRouterCategoriesProtocol? { get set }
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorCategoriesProtocol {
    
    var presenter: InteractorToPresenterCategoriesProtocol? { get set }
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterCategoriesProtocol: AnyObject {
    
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterCategoriesProtocol {
    
}
