//
//  NewsDescriptionPresenter.swift
//  News
//
//  Created by Marco on 2024-08-11.
//

import Foundation
import CoreData

class NewsDescriptionPresenter {
    weak var view : NewsDescriptionProtocol?
    
    var dbService : DBSeviceProtocol?
    
    var isFavourit: Bool = false
    
    init(view: NewsDescriptionProtocol, news: News) {
        self.view = view
        self.dbService = DBService()
        self.isFavourite(news: news)
    }
    
    func addToFavourites(news: News) {
        dbService?.addToFavourites(news: news)
    }
    
    func removeFromFavourites(news: News) {
        dbService?.deleteFavorites(news: news)
    }
    
    func isFavourite(news: News) -> Void {
        self.isFavourit = (dbService?.fetchFavourites().contains{ $0.title == news.title }) ?? false
    }
}
