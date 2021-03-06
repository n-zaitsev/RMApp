//
//  CharacterListCoordinator.swift
//  RMApp
//
//  Created by Nikita on 19/04/2021.
//  Copyright © 2021 Improve. All rights reserved.
//

import UIKit

class CharacterListCoordinator: BaseCoordinator {
    var characterListModuleFactory: ModuleFactory<CharacterListViewController>!
    var characterDetailsModuleFactory: ModuleFactory<CharacterDetailsViewController>!
    var episodesListModuleFactory: ModuleFactory<EpisodeListViewController>!
    override func start() {
        // Decoration part
        characterListModuleFactory.produceRoot { vc in
            vc.getCharactersFromPage = { page in
                vc.viewModel.getCharactersWithPage(page)
            }
            vc.goToDetails = { [self] model in
                self.openDetailsPage(from: vc, model: model)
            }
            vc.viewModel.getCharactersWithPage("1")
        }
    }

    private func openDetailsPage(from: UIViewController, model: CharacterCellConfigurator) {
        characterDetailsModuleFactory.defaultProduce(from: from, disableBackText: false) { _, cdvc in
            cdvc.viewModel.getCharacterDetails(model: model)
            cdvc.goToEpisodesListFromDetails = { [self] _ in
                episodesListModuleFactory.defaultProduce(from: cdvc, disableBackText: false) { _, elvc in
                    elvc.viewModel.getEpisodesWithIds(model.episodesId)
                    elvc.goToCharactersListFromEpisodes = { [self] episodeId in
                        characterListModuleFactory.defaultProduce(from: elvc, disableBackText: false) { _, cvc in
                            cvc.viewModel.getCharactersFromEpisode(episodeId)
                            cvc.goToDetails = { [self] model in
                                self.openDetailsPage(from: cvc, model: model)
                            }
                        }
                    }
                }
            }
            cdvc.goToCharactersListFromDetails = { [self] locationId in
                characterListModuleFactory.defaultProduce(from: cdvc, disableBackText: false) { _, cvc in
                    cvc.viewModel.getCharactersFromLocation(locationId)
                    cvc.goToDetails = { [self] model in
                        self.openDetailsPage(from: cvc, model: model)
                    }
                }
            }
        }
    }
}
