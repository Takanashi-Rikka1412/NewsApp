//
//  AddCollectionDelegate.swift
//  NewsApp
//
//  Created by Takanashi on 2021/5/26.
//  Copyright © 2021 Takanashi. All rights reserved.
//

import UIKit

protocol AddCollectionDelegate {
    func addCollection(news: News)
}

protocol RemoveCollectionDelegate {
    func removeCollection(news: News)
}
