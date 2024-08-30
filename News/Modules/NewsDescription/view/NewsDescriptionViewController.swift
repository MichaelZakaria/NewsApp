//
//  NewsDescriptionViewController.swift
//  News
//
//  Created by Marco on 2024-08-01.
//

import UIKit

protocol NewsDescriptionProtocol : AnyObject{
    //func setFavouriteNews(news: [NSManagedObject])
}

class NewsDescriptionViewController: UITableViewController, NewsDescriptionProtocol {
    
    var presenter : NewsDescriptionPresenter!
    
    var news: News = News(author: "Not Found", title: "Not Found", desription: "Not Found", imageUrl: "Not Found", url: "Not Found", publishedAt: "Not Found")
    
    var favouritesList: FavoriteListViewController?

    @IBOutlet var myTable: UITableView!
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    @IBOutlet weak var newsPublishDate: UILabel!
    @IBOutlet weak var newsUrl: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsDescription: UILabel!
    @IBOutlet weak var newsAuther: UILabel!
    @IBOutlet weak var newsTitle: UILabel!
    
    override func viewDidLoad() {
        //myTable.contentInsetAdjustmentBehavior = .never
        tableView.contentInset = .init(top: 50, left: 0, bottom: 0, right: 0)
        //tableView.scrollIndicatorInsets = .init(top: 25, left: 0, bottom: 0, right: 0)
        
        presenter = NewsDescriptionPresenter(view: self, news: news)
        
        //favoriteButton.imageView?.image = UIImage(systemName: presenter.isFavourit ? "heart.fill" : "heart")
        
        favoriteButton.setImage(UIImage(systemName: presenter.isFavourit ? "heart.fill" : "heart"), for: .normal)
        
        newsTitle.text = news.title
        newsAuther.text = news.author
        newsDescription.text = news.desription
        newsImage.sd_setImage(with: URL(string: news.imageUrl), placeholderImage: UIImage(named: "Not Found"))
        newsUrl.text = news.url
        newsPublishDate.text = news.publishedAt
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addToFavorites(_ sender: Any) {
        if presenter.isFavourit {
            let alert = UIAlertController(title: "Sure 🥺", message: "Remove from favourites !!!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { action in
                self.favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
                
                self.presenter.removeFromFavourites(news: self.news)
                self.presenter.isFavourit = false
            }))
            alert.addAction(UIAlertAction(title: "cancel", style: .default, handler: nil))
            self.present(alert, animated: true)
        } else {
            favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            self.presenter.addToFavourites(news: news)
            self.presenter.isFavourit = true
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

}
