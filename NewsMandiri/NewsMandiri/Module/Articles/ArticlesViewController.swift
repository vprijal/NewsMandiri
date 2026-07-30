//
//  ArticlesViewController.swift
//  NewsMandiri
//
//  Created by vprijal on 29/07/26.
//  
//

import UIKit
import SnapKit

class ArticlesViewController: UIViewController {
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.viewDidLoad()
    }

    // MARK: - Properties
    var presenter: ViewToPresenterArticlesProtocol?
    typealias GeneralCDataSource = UICollectionViewDiffableDataSource<GeneralSection, Article>
    typealias GeneralCSnapshot = NSDiffableDataSourceSnapshot<GeneralSection, Article>
    
    lazy var collectionView: UICollectionView = createCollectionView()
    lazy private var dataSource = self.configureDataSource()
    lazy private var refreshControl: UIRefreshControl = {
        let rc = UIRefreshControl()
        rc.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        return rc
    }()
    
    private var searchBar: UISearchController = {
        let sb = UISearchController()
        sb.searchBar.placeholder = "Enter Article Title"
        sb.searchBar.searchBarStyle = .minimal
        return sb
    }()
    
    private var isSearching: Bool {
        if let text = searchBar.searchBar.text, !text.trimmingCharacters(in: .whitespaces).isEmpty {
            return true
        }
        return false
    }
}

extension ArticlesViewController: PresenterToViewArticlesProtocol {
    func onFetchArticleSuccess(articles: [Article], isFirstPage: Bool) {
        refreshControl.endRefreshing()
        if articles.isEmpty {
            self.collectionView.setStateView(with: .empty)
        } else {
            self.collectionView.setStateView(with: .done) {
                var snap = self.dataSource.snapshot()
                if !snap.sectionIdentifiers.contains(.main) {
                    snap.appendSections([.main])
                }
                if !snap.itemIdentifiers(inSection: .main).isEmpty {
                    snap.deleteItems(snap.itemIdentifiers(inSection: .main))
                }
                snap.appendItems(articles, toSection: .main)
                self.dataSource.apply(snap, animatingDifferences: false)
            }
        }
    }
    
    func onFetchArticleFailure(isFirstPage: Bool) {
        refreshControl.endRefreshing()
        if isFirstPage {
            self.collectionView.setStateView(with: .retry) {
                self.collectionView.setStateView(with: .loading) {
                    self.presenter?.viewDidLoad()
                }
            }
        }
    }
}

extension ArticlesViewController {
    func setupUI() {
        view.backgroundColor = .white
        searchBar.searchResultsUpdater = self
        searchBar.delegate = self
        navigationItem.searchController = searchBar
        navigationItem.hidesSearchBarWhenScrolling = false
        
        view.addSubview(collectionView)
        collectionView.refreshControl = refreshControl
        collectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        collectionView.dataSource = dataSource
        collectionView.setStateView(with: .loading)
    }
    
    @objc private func handleRefresh() {
        presenter?.refresh()
    }
    
    private func configureDataSource() -> GeneralCDataSource {
        let _dataSource = GeneralCDataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            let cell: ArticleCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArticleCell", for: indexPath) as! ArticleCell
            cell.setData(data: itemIdentifier)
            return cell
        }
        var snapshot = GeneralCSnapshot()
        snapshot.appendSections([.main])
        _dataSource.apply(snapshot)
        return _dataSource
    }
    
    private func createCollectionView() -> UICollectionView {
        let layout = createCompositionalLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ArticleCell.self, forCellWithReuseIdentifier: "ArticleCell")
        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }
    
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { [unowned self] (_, _) -> NSCollectionLayoutSection? in
            return createLayout()
       }
    }
    
    func createLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(100)))
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(100))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.contentInsets = .zero
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
    
    func updateSearch(data: [Article], search: String) {
        var snap = self.dataSource.snapshot()
        if !snap.itemIdentifiers(inSection: .main).isEmpty {
            snap.deleteItems(snap.itemIdentifiers(inSection: .main))
        }
        var searchData: [Article] = []
        for element in data {
            if element.title?.lowercased().contains(search.lowercased()) == true {
                searchData.append(element)
            }
        }
        snap.appendItems(searchData, toSection: .main)
        self.dataSource.apply(snap)
    }
}

extension ArticlesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
        let item = self.dataSource.snapshot().itemIdentifiers[indexPath.row]
        presenter?.didSelectRowAt(article: item)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard !isSearching else { return }
        let position = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.size.height
        
        if contentHeight > 0 && position > (contentHeight - frameHeight - 200) {
            presenter?.loadNextPage()
        }
    }
}

extension ArticlesViewController: UISearchResultsUpdating, UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        if let query = searchBar.text, query.trimmingCharacters(in: .whitespaces) != "" {
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                if let article = self.presenter?.articles, !article.isEmpty {
                    self.updateSearch(data: article, search: query)
                }
            }
        } else {
            self.presenter?.view?.onFetchArticleSuccess(articles: self.presenter?.articles ?? [], isFirstPage: true)
        }
    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
        print(searchController.searchBar)
        self.presenter?.view?.onFetchArticleSuccess(articles: self.presenter?.articles ?? [], isFirstPage: true)
    }
}
