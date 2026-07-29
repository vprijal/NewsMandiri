//
//  DetailsArticleContract.swift
//  NewsMandiri
//
//  Created by vprijal on 29/07/26.
//  
//

import Foundation


// MARK: View Output (Presenter -> View)
protocol PresenterToViewDetailsArticleProtocol: AnyObject {
    func onSendArticleSuccess(article: Article)
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterDetailsArticleProtocol: AnyObject {
    
    var view: PresenterToViewDetailsArticleProtocol? { get set }
    var interactor: PresenterToInteractorDetailsArticleProtocol? { get set }
    var router: PresenterToRouterDetailsArticleProtocol? { get set }
    func viewDidLoad()
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorDetailsArticleProtocol {
    
    var presenter: InteractorToPresenterDetailsArticleProtocol? { get set }
    var article: Article? {get set}
    func loadDetailArticle()
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterDetailsArticleProtocol: AnyObject {
    func sendDetailArticle(article: Article)
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterDetailsArticleProtocol {
    
}
