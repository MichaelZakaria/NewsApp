//
//  HomePresenter.swift
//  News
//
//  Created by Marco on 2024-08-11.
//

import Foundation
import CoreData

class HomePresenter {
    weak var view :HomeProtocol?
    
    var nwService : NWSeviceProtocol?
    var dbService : DBSeviceProtocol?
    
    var news: [News] = []
    var favouriteNews: [News] = []
    
    init(view: HomeProtocol) {
        self.view = view
        self.nwService = NWSevice()
        self.dbService = DBService()
        getFavouriteNews()
    }
    
    func getNews() {
        nwService!.getData { [weak self] news in
            DispatchQueue.main.async {
                if news.isEmpty {
                    self?.news = (self?.dbService!.getNews())!
                } else {
                    self?.news = news
                    self?.deleteNews()
                    self?.addNews(news: news)
                }
                self?.view?.setNews(news: news)
                self?.view!.reloadData()
            }
        }
    }
    
    func deleteNews(){
        dbService?.deleteNews()
    }
    
    func addNews(news: [News]){
        dbService?.addNews(news: news)
    }
    
    func getFavouriteNews() {
        guard let favourites = dbService?.fetchFavourites() else {return}
        self.favouriteNews = favourites
    }
    
}
