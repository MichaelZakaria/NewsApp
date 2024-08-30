//
//  DBService.swift
//  News
//
//  Created by Marco on 2024-08-11.
//

import Foundation
import CoreData
import UIKit

protocol DBSeviceProtocol {
    func getNews() -> [News]
    func deleteNews()
    func addNews(news: [News])
    func fetchFavourites() -> [News]
    func deleteFavorites(news: News)
    func addToFavourites(news: News)
}

class DBService : DBSeviceProtocol {
/// Add to Favourites
    func addToFavourites(news: News) {
        //1
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        //2
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //3
        guard let entity = NSEntityDescription.entity(forEntityName: "New", in: managedContext) else {
            return
        }
        
        //4
        let newsObject = NSManagedObject(entity: entity, insertInto: managedContext)
        
        newsObject.setValue(news.title, forKey: "title")
        newsObject.setValue(news.url, forKey: "url")
        newsObject.setValue(news.desription, forKey: "details")
        newsObject.setValue(news.author, forKey: "auther")
        newsObject.setValue(news.publishedAt, forKey: "publishedAt")
        newsObject.setValue(news.imageUrl, forKey: "imageUrl")
        
        do {
            try managedContext.save()
            print("Added to favorites :)")
        } catch {
            print(error.localizedDescription)
        }
    }
    
/// Delete from Favourites
    func deleteFavorites(news: News) {
        //1
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        //2
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //3
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "New")
        
        //4
        let myPredicate = NSPredicate(format: "title == %@", news.title)
        fetchRequest.predicate = myPredicate
        
        //5
        do{
            let deletedNews = try managedContext.fetch(fetchRequest)
            for news in deletedNews {
                managedContext.delete(news)
            }
            try managedContext.save()
            print("removed from favorites :(")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
/// Fetch Favourites
    func fetchFavourites() -> [News] {
        //1
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        //2
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //3
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "New")
        
        //4
        var news : [News] = []
        do{
            news = try managedContext.fetch(fetchRequest).map({ CDNews in
                return News(author: CDNews.value(forKey: "auther") as! String, 
                               title: CDNews.value(forKey: "title") as! String,
                               desription: CDNews.value(forKey: "details") as! String,
                               imageUrl: CDNews.value(forKey: "imageUrl") as! String,
                               url: CDNews.value(forKey: "url") as! String,
                               publishedAt: CDNews.value(forKey: "publishedAt") as! String)
            })
        } catch {
            print(error.localizedDescription)
        }
        
        return news
    }
    
/// Fetch all
    func getNews() -> [News] {
        //1
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        //2
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //3
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "AllNews")
        
        //4
        var allNews: [News] = []
        do{
            let myNews = try managedContext.fetch(fetchRequest)
            print(myNews.count)
            for new in myNews{
                allNews.append(News(author: new.value(forKey: "auther") as! String, title: new.value(forKey: "title") as! String, desription: new.value(forKey: "details") as! String, imageUrl: new.value(forKey: "imageUrl") as! String, url: new.value(forKey: "url") as! String, publishedAt: new.value(forKey: "publishedAt") as! String))
            }
        } catch {
            print(error.localizedDescription)
        }
        return allNews
    }

/// Delete all
    func deleteNews(){
        //1
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        //2
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //3
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "AllNews")
        
        //4
        do{
            let deletedNews = try managedContext.fetch(fetchRequest)
            for news in deletedNews {
                managedContext.delete(news)
            }
            try managedContext.save()
            print("News Removed :(")
        } catch {
            print(error.localizedDescription)
        }
    }
 
/// Add all
    func addNews(news: [News]){
        for new in news {
            //1
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            //2
            let managedContext = appDelegate.persistentContainer.viewContext
            
            //3
            guard let entity = NSEntityDescription.entity(forEntityName: "AllNews", in: managedContext) else {
                return
            }
            
            //4
            let newsObject = NSManagedObject(entity: entity, insertInto: managedContext)
            
            newsObject.setValue(new.title, forKey: "title")
            newsObject.setValue(new.url, forKey: "url")
            newsObject.setValue(new.desription, forKey: "details")
            newsObject.setValue(new.author, forKey: "auther")
            newsObject.setValue(new.publishedAt, forKey: "publishedAt")
            newsObject.setValue(new.imageUrl, forKey: "imageUrl")
            
            do {
                try managedContext.save()
                print("News Added :)")
            } catch {
                print(error.localizedDescription)
            }
        }
    }

}
