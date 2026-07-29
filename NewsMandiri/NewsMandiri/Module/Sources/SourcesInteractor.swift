//
//  SourcesInteractor.swift
//  NewsMandiri
//
//  Created by vprijal on 29/07/26.
//  
//

import Foundation

class SourcesInteractor: PresenterToInteractorSourcesProtocol {

    // MARK: Properties
    weak var presenter: InteractorToPresenterSourcesProtocol?
    var category: String?
    var network: NetworkManager = NetworkManager.shared
    var source: [Source]?
    
    func loadSource() {
        Task {
            do {
                let response: SourceResponse = try await network.request(route: .getSources(category: self.category ?? ""))
                print(response)
                self.source = response.sources
                self.presenter?.fetchSourceSuccess(source: self.source ?? [])
            } catch {
                print(error.localizedDescription)
                self.presenter?.fetchSourceFailure()
            }
        }
    }
    
    func retrieveSources(id: String) {
        guard let source = self.source?.first(where: {$0.id == id}) else {
            return
        }
        self.presenter?.findSourcesSuccess(source.id)
    }
}
