//
//  SourcesPresenter.swift
//  NewsMandiri
//
//  Created by vprijal on 29/07/26.
//  
//

import Foundation

class SourcesPresenter: ViewToPresenterSourcesProtocol {

    // MARK: Properties
    weak var view: PresenterToViewSourcesProtocol?
    var interactor: PresenterToInteractorSourcesProtocol?
    var router: PresenterToRouterSourcesProtocol?
    var source: [Source] = []
    
    func viewDidLoad() {
        interactor?.loadSource()
    }
    
    func didSelectRowAt(id: String) {
        interactor?.retrieveSources(id: id)
    }
}

extension SourcesPresenter: InteractorToPresenterSourcesProtocol {
    func fetchSourceSuccess(source: [Source]) {
        self.source = source
        view?.onFetchSourceSuccess(source: source)
    }
    
    func fetchSourceFailure() {
        view?.onFetchSourceFailure()
    }
    
    func findSourcesSuccess(_ sourceId: String) {
        router?.navigateToArticle(on: view!, with: sourceId)
    }
}
