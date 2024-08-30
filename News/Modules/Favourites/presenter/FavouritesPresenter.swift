//
//  FavouritesPresenter.swift
//  News
//
//  Created by Marco on 2024-08-11.
//

import Foundation
import CoreData

class FavouritesPresenter {
    weak var view :FavouriteProtocol?
    
    var dbService : DBSeviceProtocol?
    
    init(view: FavouriteProtocol) {
        self.view = view
        self.dbService = DBService()
    }
    
    func getFavouriteNews() {
        self.view?.setFavouriteNews(news: (dbService?.fetchFavourites())!)
    }
    
    func deleteFromFavourites(news: News) {
        dbService?.deleteFavorites(news: news)
    }
    
}
