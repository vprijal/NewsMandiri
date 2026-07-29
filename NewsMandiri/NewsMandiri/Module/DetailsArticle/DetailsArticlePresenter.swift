//
//  DetailsArticlePresenter.swift
//  NewsMandiri
//
//  Created by vprijal on 29/07/26.
//  
//

import Foundation

class DetailsArticlePresenter: ViewToPresenterDetailsArticleProtocol {

    // MARK: Properties
    weak var view: PresenterToViewDetailsArticleProtocol?
    var interactor: PresenterToInteractorDetailsArticleProtocol?
    var router: PresenterToRouterDetailsArticleProtocol?
    
    func viewDidLoad() {
        interactor?.loadDetailArticle()
    }
}

extension DetailsArticlePresenter: InteractorToPresenterDetailsArticleProtocol {
    func sendDetailArticle(article: Article) {
        view?.onSendArticleSuccess(article: article)
    }
}
