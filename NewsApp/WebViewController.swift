//
//  WebViewController.swift
//  NewsApp
//
//  Created by Takanashi on 2021/5/25.
//  Copyright © 2021 Takanashi. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    @IBOutlet weak var browser: WKWebView!
    
    @IBOutlet weak var nvgItem: UINavigationItem!
    
    var news: News?
    var btnCollect: UIButton = UIButton(type: .custom)
    var addDelegate: AddCollectionDelegate?
    var removeDelegate: RemoveCollectionDelegate?
    var isCollected: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for n in NewsManager.shared.collectedNews
        {
            if n.path == news?.path
            {
                isCollected = true
                break
            }
        }
        if isCollected
        {
            btnCollect.setImage(UIImage(named: "iconfont-collected"), for: .normal)
        }
        else
        {
            btnCollect.setImage(UIImage(named: "iconfont-uncollected"), for: .normal)
        }
        nvgItem.rightBarButtonItem = UIBarButtonItem(customView: btnCollect)
        btnCollect.widthAnchor.constraint(equalToConstant: 45).isActive = true
        btnCollect.addTarget(self, action: #selector(collect), for: .touchUpInside)
        
        let nav = tabBarController?.viewControllers?[1] as? UINavigationController
        let sectab = nav?.viewControllers.first as? CollectionTableViewController
        addDelegate = sectab
        removeDelegate = sectab
        
        let url = URL(string: news!.path)
        let req = URLRequest(url: url!)
        browser.load(req)
    }
    
    @objc func collect()
    {
        if isCollected
        {
            btnCollect.setImage(UIImage(named: "iconfont-uncollected"), for: .normal)
            isCollected = false
            removeDelegate?.removeCollection(news: news!)
        }
        else
        {
            btnCollect.setImage(UIImage(named: "iconfont-collected"), for: .normal)
            isCollected = true
            addDelegate?.addCollection(news: news!)
        }
    }
    
}
