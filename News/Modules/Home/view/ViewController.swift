//
//  ViewController.swift
//  News
//
//  Created by Marco on 2024-08-01.
//

import UIKit
import SDWebImage

protocol HomeProtocol : AnyObject{
    func reloadData()
    func setNews(news: [News])
}


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, HomeProtocol {
    
    var presenter : HomePresenter!
    
    let indicator = UIActivityIndicatorView(style: .medium)
    
    var news: [News] = []
    
    @IBOutlet weak var myTable: UITableView!
    
    func reloadData() {
        myTable.reloadData()
    }
    
    func setNews(news: [News]) {
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
        return "News"
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let newsDescription: NewsDescriptionViewController = self.storyboard?.instantiateViewController(withIdentifier: "StaticTableView") as! NewsDescriptionViewController
        
            newsDescription.news = news[indexPath.row]
        
        self.navigationController?.pushViewController(newsDescription, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = HomePresenter(view: self)
        
        myTable.delegate = self
        myTable.dataSource = self
        
        indicator.center = view.center
        indicator.startAnimating()
        view.addSubview(indicator)
        
        presenter.getNews()
    
        indicator.stopAnimating()
        myTable.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.getFavouriteNews()
    }

}

