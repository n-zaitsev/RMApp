//
//  CharacterDetailsCollectionViewDataSource.swift
//  RM
//
//  Created by Пользователь on 26.04.2021.
//

import UIKit

class CharacterDetailsCollectionViewDataSource: NSObject {
    private weak var collectionView: UICollectionView?
    private var model = SectionDetailsModels(name: "", models: [[CellConfigurator]]()) {
        didSet {
            collectionView?.reloadData()
        }
    }

    private var goToEpisodesListFromDetails: (([String]) -> Void)?
    private var goToCharactersListFromLocation: ((String) -> Void)?

    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
    }

    func updateGoToEpisodesListFromDetails(closure: (([String]) -> Void)?) {
        goToEpisodesListFromDetails = closure
    }

    func updateGoToCharactersListFromLocationClosure(closure: ((String) -> Void)? = nil) {
        goToCharactersListFromLocation = closure
    }

    func updateModels(_ models: SectionDetailsModels) {
        model = models
    }
}

extension CharacterDetailsCollectionViewDataSource: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let section = CharacterDetailsSections(rawValue: indexPath.section) else { return }
        switch section {
        case .episodes:
            collectionView.deselectItem(at: indexPath, animated: true)
            if let model = model.models[indexPath.section][indexPath.row] as? EpisodesCellConfigurator {
                goToEpisodesListFromDetails?(model.episodesIds)
            }
        case .location:
            collectionView.deselectItem(at: indexPath, animated: true)
            if let model = model.models[indexPath.section][indexPath.row] as? LocationCellConfigurator {
                goToCharactersListFromLocation?(model.locationId)
            }
        default:
            break
        }
    }
}

extension CharacterDetailsCollectionViewDataSource: UICollectionViewDataSource {
    func collectionView(_: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        model.models[section].count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = model.models[indexPath.section][indexPath.row]
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.reuseIndentifier, for: indexPath) as? ConfigurableCollectionRow {
            return cell.configureWith(item)
        }
        return UICollectionViewCell()
    }

    func numberOfSections(in _: UICollectionView) -> Int {
        model.models.count
    }
}
