//
//  CategoriesViewController.swift
//  NewsMandiri
//
//  Created by vprijal on 29/07/26.
//  
//

import UIKit
import SnapKit

nonisolated enum GeneralSection: Hashable, Sendable {
    case main
}

class CategoriesViewController: UIViewController {
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.viewDidLoad()
    }

    // MARK: - Properties
    var presenter: ViewToPresenterCategoriesProtocol?
    typealias GeneralCDataSource = UICollectionViewDiffableDataSource<GeneralSection, String>
    typealias GeneralCSnapshot = NSDiffableDataSourceSnapshot<GeneralSection, String>
    
    lazy var collectionView: UICollectionView = createCollectionView()
    lazy private var dataSource = self.configureDataSource()
    
}

extension CategoriesViewController: PresenterToViewCategoriesProtocol{
    // TODO: Implement View Output Methods
    func onGetCategorySuccess(category: [String]) {
        var snap = self.dataSource.snapshot()
        snap.appendItems(category, toSection: .main)
        self.dataSource.apply(snap, animatingDifferences: true)
    }
}

extension CategoriesViewController {
    func setupUI() {
        self.navigationItem.title = "NEWS"
        self.navigationItem.backButtonTitle = ""
        self.view.backgroundColor = .white
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        collectionView.dataSource = dataSource
    }
    
    private func configureDataSource() -> GeneralCDataSource {
        let _dataSource = GeneralCDataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            let cell: CategoriesCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCell", for: indexPath) as! CategoriesCell
            cell.nameLabel.text = itemIdentifier
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
        collectionView.register(CategoriesCell.self, forCellWithReuseIdentifier: "CategoriesCell")
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
}

extension CategoriesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
        presenter?.didSelectRowAt(index: indexPath.row)
    }
}
