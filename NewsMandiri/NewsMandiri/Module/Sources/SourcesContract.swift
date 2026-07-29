//
//  SourcesContract.swift
//  NewsMandiri
//
//  Created by vprijal on 29/07/26.
//  
//

import Foundation


// MARK: View Output (Presenter -> View)
protocol PresenterToViewSourcesProtocol: AnyObject {
    func onFetchSourceSuccess(source: [Source])
    func onFetchSourceFailure()
}


// MARK: View Input (View -> Presenter)
protocol ViewToPresenterSourcesProtocol: AnyObject {
    
    var view: PresenterToViewSourcesProtocol? { get set }
    var interactor: PresenterToInteractorSourcesProtocol? { get set }
    var router: PresenterToRouterSourcesProtocol? { get set }
    var source: [Source] { get set}
    func viewDidLoad()
    func didSelectRowAt(id: String)
}


// MARK: Interactor Input (Presenter -> Interactor)
protocol PresenterToInteractorSourcesProtocol {
    
    var presenter: InteractorToPresenterSourcesProtocol? { get set }
    var category: String? {get set}
    var network: NetworkManager { get set }
    
    func loadSource()
    func retrieveSources(id: String)
}


// MARK: Interactor Output (Interactor -> Presenter)
protocol InteractorToPresenterSourcesProtocol: AnyObject {
    func fetchSourceSuccess(source: [Source])
    func findSourcesSuccess(_ sourceId: String)
    func fetchSourceFailure()
}


// MARK: Router Input (Presenter -> Router)
protocol PresenterToRouterSourcesProtocol {
    func navigateToArticle(on view: PresenterToViewSourcesProtocol, with sourceId: String)
}
