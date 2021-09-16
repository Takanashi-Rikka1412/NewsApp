//
//  SearchResultTableViewController.swift
//  NewsApp
//
//  Created by Takanashi on 2021/6/2.
//  Copyright © 2021 Takanashi. All rights reserved.
//

import UIKit

class SearchResultTableViewController: UITableViewController, UISearchResultsUpdating {
    
    var allNews: [News] = []
    var filterNews: [News] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let xib = UINib(nibName: "CustomTableViewCell", bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: "CustomCell")
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let searchString = searchController.searchBar.text else {return}
        if searchString.isEmpty {return}
        
        filterNews = allNews.filter {(news) -> Bool in
                return news.title.contains(searchString)}
        
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterNews.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomTableViewCell
        
        cell.newsTitle.text = filterNews[indexPath.row].title
        cell.newsPassTime.text = filterNews[indexPath.row].passtime
        cell.newsImage.downloadAsyncFrom(url: filterNews[indexPath.row].image)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainstoryboard = UIStoryboard(name: "Main", bundle: nil)
        let webVC = mainstoryboard.instantiateViewController(withIdentifier: "WebVC") as! WebViewController
        webVC.news = filterNews[indexPath.row]
        let nav = self.presentingViewController?.navigationController
        nav?.pushViewController(webVC, animated: true)
        
    }
    
}

