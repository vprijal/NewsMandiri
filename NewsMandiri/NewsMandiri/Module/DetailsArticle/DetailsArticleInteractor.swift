//
//  DetailsArticleInteractor.swift
//  NewsMandiri
//
//  Created by vprijal on 29/07/26.
//  
//

import Foundation

class DetailsArticleInteractor: PresenterToInteractorDetailsArticleProtocol {

    // MARK: Properties
    weak var presenter: InteractorToPresenterDetailsArticleProtocol?
    var article: Article?
    
    func loadDetailArticle() {
        guard let article = self.article else { return }
        presenter?.sendDetailArticle(article: article)
    }
}
