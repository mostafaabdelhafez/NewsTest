//
//  NewsModel.swift
//  NewsApp
//
//  Created by Mostafa on 2/4/22.
//


import Foundation
import RealmSwift
struct ArticleModel:Decodable {
    let articles:[Article]
}

struct Article:Decodable {
    let title:String?
    let description:String?
    let urlToImage:String?
    let content:String?
}
class OfflineArticle:Object{
    @objc dynamic var title:String = ""
    @objc dynamic var articleDescription:String = ""
    @objc dynamic var urlToImage:String = ""
    @objc dynamic var content:String = ""
}
enum StatusCodes{
    case unAuthorized
    case sucess
    case error
}

