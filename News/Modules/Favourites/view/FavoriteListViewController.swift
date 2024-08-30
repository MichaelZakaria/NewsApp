//
//  FavoriteListViewController.swift
//  News
//
//  Created by Marco on 2024-08-03.
//

import UIKit
import CoreData

protocol FavouriteProtocol : AnyObject{
    func setFavouriteNews(news: [News])
}

class FavoriteListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FavouriteProtocol {
    
    var presenter : FavouritesPresenter!
    var news: [News] = []

    @IBOutlet weak var myTable: UITableView!
    @IBOutlet weak var emptyImage: UIImageView!
    
    func setFavouriteNews(news: [News]) {
        self.news = news
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyTableViewCell
        
        cell.newsImage.sd_setImage(with: URL(string: news[indexPath.row].imageUrl), placeholderImage: UIImage(named: "Not Found"))
        cell.newsTitle.text = news[indexPath.row].title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Favorites"
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let newsDescription: NewsDescriptionViewController = self.storyboard?.instantiateViewController(withIdentifier: "StaticTableView") as! NewsDescriptionViewController
        
        newsDescription.news = news[indexPath.row]
        
        self.navigationController?.pushViewController(newsDescription, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Remove") {_,_,_ in
            self.presenter.deleteFromFavourites(news: self.news[indexPath.row])
            self.presenter.getFavouriteNews()
            self.reloadTable()
        }
        
        let swipeCongiguration = UISwipeActionsConfiguration(actions: [action])
        
        return swipeCongiguration
    }
    
    override func viewDidLoad() {
        presenter = FavouritesPresenter(view: self)
        
        myTable.delegate = self
        myTable.dataSource = self
        
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.getFavouriteNews()
        reloadTable()
    }
    
    func reloadTable() {
        self.emptyImage.layer.isHidden = self.news.count == 0 ? false : true
        myTable.reloadData()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
