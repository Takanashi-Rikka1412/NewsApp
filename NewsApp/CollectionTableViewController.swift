//
//  CollectionTableViewController.swift
//  NewsApp
//
//  Created by Takanashi on 2021/5/26.
//  Copyright © 2021 Takanashi. All rights reserved.
//

import UIKit

class CollectionTableViewController: UITableViewController, AddCollectionDelegate, RemoveCollectionDelegate {

    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let xib = UINib(nibName: "CustomTableViewCell", bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: "CustomCell")
        tableView.rowHeight = 110
        
        
        navigationController?.tabBarItem.badgeValue = "\(NewsManager.shared.collectedNews.count)"

        tableView.reloadData()
        initSearch()
    }
    
    func initSearch()
    {
        let resultsController = SearchResultTableViewController()
        resultsController.allNews = NewsManager.shared.collectedNews
        
        searchController = UISearchController(searchResultsController: resultsController)
        let searchBar = searchController.searchBar
        searchBar.placeholder = "请输入查询标题"
        searchBar.sizeToFit()
        searchBar.autocapitalizationType = .none
        tableView.tableHeaderView = searchBar
        searchController.searchResultsUpdater = resultsController
        self.definesPresentationContext = true
    }
    
    func addCollection(news: News) {
        NewsManager.shared.collectedNews.append(news)
        navigationController?.tabBarItem.badgeValue = "\(NewsManager.shared.collectedNews.count)"
        tableView.reloadData()
        
        NewsDB.AddNews(news: news)
        let resultsController = searchController.searchResultsUpdater as! SearchResultTableViewController
        resultsController.allNews = NewsManager.shared.collectedNews
    }
    
    func removeCollection(news: News) {
       
        var i = 0
        for n in NewsManager.shared.collectedNews
        {
            if n.path == news.path
            {
                NewsManager.shared.collectedNews.remove(at: i)
                break
            }
            i += 1
        }
        navigationController?.tabBarItem.badgeValue = "\(NewsManager.shared.collectedNews.count)"
        tableView.reloadData()
        
        NewsDB.DeleteNews(news: news)
        let resultsController = searchController.searchResultsUpdater as! SearchResultTableViewController
        resultsController.allNews = NewsManager.shared.collectedNews
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return NewsManager.shared.collectedNews.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomTableViewCell
        
        cell.newsTitle.text = NewsManager.shared.collectedNews[indexPath.row].title
        cell.newsPassTime.text = NewsManager.shared.collectedNews[indexPath.row].passtime
        cell.newsImage.downloadAsyncFrom(url: NewsManager.shared.collectedNews[indexPath.row].image)
        
        return cell
    }
    
    // 可编辑
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // 删除单元格
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete
        {
            let news = NewsManager.shared.collectedNews[indexPath.row]
            NewsManager.shared.collectedNews.remove(at: indexPath.row)

            navigationController?.tabBarItem.badgeValue = "\(NewsManager.shared.collectedNews.count)"
            NewsDB.DeleteNews(news: news)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            let resultsController = searchController.searchResultsUpdater as! SearchResultTableViewController
            resultsController.allNews = NewsManager.shared.collectedNews
        }
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showCollectedWeb", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let web = segue.destination as? WebViewController else {return}
        
        if let indexPath = tableView.indexPathForSelectedRow
        {
            web.news = NewsManager.shared.collectedNews[indexPath.row]
        }
    }
    
}
