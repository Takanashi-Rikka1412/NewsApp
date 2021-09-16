//
//  News.swift
//  NewsApp
//
//  Created by Takanashi on 2021/5/19.
//  Copyright © 2021 Takanashi. All rights reserved.
//

import Foundation

class News: NSObject, Codable
{
    var title: String = ""
    var path: String = ""
    var passtime: String = ""
    var image: String = ""
    
    private enum CodingKeys: String, CodingKey{
        case title
        case path
        case passtime
        case image
    }
    
    init(title: String)
    {
        self.title = title
    }
    
    override var description: String {
        return "title:\(title)"
    }
    
}

class NewsResponse: NSObject, Codable
{
    var code: Int = 0
    var result: [News] = []
    var message: String = ""
    
    private enum CodingKeys: String, CodingKey{
        case code
        case result
        case message
    }
}

class NewsManager
{
    static let shared: NewsManager = NewsManager()
    
    var news: [News] = []
    var collectedNews: [News] = []
    var curPage: Int = 1
    var pageSize: Int = 20
    
    // 加载更多新闻
    func fetchMore(complete: @escaping ()->Void) {
        curPage += 1
        fetchData(complete: complete)
    }
    
    // 重新加载
    func refresh(complete: @escaping  ()->Void)  {
        news.removeAll()
        curPage = 1
        fetchData(complete: complete)
    }
    
    // 加载新闻
    private func fetchData(complete: @escaping ()->Void)
    {
        let url = URL(string: //"https://api.apiopen.top/getWangYiNews?page=\(curPage)&count=\(pageSize)")!
        "http://zy.whu.edu.cn/news/api/news/getList?page=\(curPage)&count=\(pageSize)")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, let moreNews = try? JSONDecoder().decode(NewsResponse.self, from:data)
            {
                moreNews.result.forEach{self.news.append($0)}
                print(self.news.count)
                Thread.sleep(forTimeInterval: 2)
                complete()
            }
        }
        task.resume()

    }
}

