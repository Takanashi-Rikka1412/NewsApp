//
//  NewsDB.swift
//  NewsApp
//
//  Created by Takanashi on 2021/5/31.
//  Copyright © 2021 Takanashi. All rights reserved.
//

import Foundation

class NewsDB {
    static func initDB()
    {
        let sqlite = SQLiteManager.sharedInstance
        
        if !sqlite.openDB() {return}
        
        let createSql = "CREATE TABLE IF NOT EXISTS NewsTable('title' TEXT, 'path' TEXT NOT NULL PRIMARY KEY, 'passtime' TEXT, 'image' TEXT);"
        sqlite.execNoneQuerySQL(sql: createSql)
        sqlite.closeDB()
        return
    }
    
    
    static func GetNews() -> [News]
    {
        let sqlite = SQLiteManager.sharedInstance
        
        if !sqlite.openDB() { return [] }
        
        let queryResult = sqlite.execQuerySQL(sql: "SELECT * FROM NewsTable")
        
        //print(queryResult!)
        
        var newsList: [News] = []
        for n in queryResult!
        {
            let title = n["title"] as! String
            let path = n["path"] as! String
            let passtime = n["passtime"] as! String
            let image = n["image"] as! String
            let news = News(title: title)
            news.path = path
            news.passtime = passtime
            news.image = image
            newsList.append(news)
        }
        
        sqlite.closeDB()
        
        return newsList
    }
    
    static func AddNews(news: News)
    {
        let sqlite = SQLiteManager.sharedInstance
        
        if !sqlite.openDB() { return }
        
        let result = sqlite.execNoneQuerySQL(sql: "INSERT INTO NewsTable(title, path, passtime, image) VALUES('\(news.title)', '\(news.path)', '\(news.passtime)', '\(news.image)');")
        
        //print(result)
        
        sqlite.closeDB()
        
    }
    
    static func DeleteNews(news: News)
    {
        let sqlite = SQLiteManager.sharedInstance
        
        if !sqlite.openDB() { return }
        
        let result = sqlite.execNoneQuerySQL(sql: "DELETE FROM NewsTable WHERE path = '\(news.path)';")
        
        //print(result)
        
        sqlite.closeDB()
        
    }
}
