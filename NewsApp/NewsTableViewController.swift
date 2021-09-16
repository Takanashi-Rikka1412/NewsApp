//
//  ViewController.swift
//  NewsApp
//
//  Created by Takanashi on 2021/5/18.
//  Copyright © 2021 Takanashi. All rights reserved.
//

import Foundation
import UIKit

class NewsTableViewController: UITableViewController
{
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 注册自定义单元格
        let xib = UINib(nibName: "CustomTableViewCell", bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: "CustomCell")
        tableView.rowHeight = 110
        
        NewsDB.initDB()
        for news in NewsDB.GetNews()
        {
            NewsManager.shared.collectedNews.append(news)
        }
        
        
        setRefreshView()
        setMoreView()
        refreshData()
    }
    
    // 返回单元格个数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return NewsManager.shared.news.count
    }
    
    // 显示单元格
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomTableViewCell
        if NewsManager.shared.news.count <= indexPath.row
        {
            print("refresh too fast")
            return cell
        }
        cell.newsTitle.text = NewsManager.shared.news[indexPath.row].title
        cell.newsPassTime.text = NewsManager.shared.news[indexPath.row].passtime
        cell.newsImage.downloadAsyncFrom(url: NewsManager.shared.news[indexPath.row].image)
        
        if (indexPath.row == NewsManager.shared.news.count-1) {
            loadMore()
        }
        return cell
    }
    
    // 选择单元格
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showWeb", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let web = segue.destination as? WebViewController else {return}

        if let indexPath = tableView.indexPathForSelectedRow
        {
            web.news = NewsManager.shared.news[indexPath.row]
        }
    }
    
    //上拉刷新视图
    func setMoreView() {
        let loadMoreView = UIView(frame: CGRect(x:0, y:self.tableView.contentSize.height,width:self.tableView.bounds.size.width, height:60))
        loadMoreView.autoresizingMask = UIView.AutoresizingMask.flexibleWidth
        loadMoreView.backgroundColor = self.tableView.backgroundColor
        
        //添加中间的环形进度条
        let indicator = UIActivityIndicatorView()
        //indicator.color = UIColor.darkGray
        let indicatorX = self.view.frame.width/2-indicator.frame.width/2
        let indicatorY = loadMoreView.frame.size.height/2-indicator.frame.height/2
        indicator.frame = CGRect(x:indicatorX, y:indicatorY, width:indicator.frame.width, height:indicator.frame.height)
        indicator.startAnimating()
        loadMoreView.addSubview(indicator)
        self.tableView.tableFooterView = loadMoreView
    }
    
    // 下拉重新加载的设置
    func setRefreshView()
    {
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        self.refreshControl!.attributedTitle = NSAttributedString(string: "下拉刷新数据")
    }
    
    // 下拉重新加载数据
    @objc func refreshData() {
        NewsManager.shared.refresh{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        self.refreshControl!.endRefreshing()
    }
    
    // 上拉加载更多数据
    func loadMore(){
        //print("加载新数据！")
        NewsManager.shared.fetchMore {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
}
