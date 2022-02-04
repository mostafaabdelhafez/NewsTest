//
//  NewViewModel.swift
//  NewsApp
//
//  Created by Mostafa on 2/4/22.
//

import Foundation
import RxSwift
import RxCocoa
import RealmSwift
import Alamofire
struct NewsViewModel {
    let realm = try! Realm()
    func removeFromRealm(){
        try! realm.write {
            realm.delete(realm.objects(OfflineArticle.self))
        }
    }
    func saveToRealmFrom(Articles:[Article]){
        removeFromRealm()
        realm.beginWrite()

        var listOfArticles = [OfflineArticle]()
        Articles.forEach { (art) in
            let article = OfflineArticle()
            article.title = art.title ?? ""
            article.content = art.content ?? ""
            article.urlToImage = art.urlToImage ?? ""
            article.articleDescription = art.description ?? ""
            listOfArticles.append(article)
        }
        realm.add(listOfArticles)
        try! realm.commitWrite()
    }

    var articleModelObservable: Observable<[Article]> {
    return articleModelSubject
    }
     var articleModelSubject = PublishSubject<[Article]>()
    var offlineArticleModelSubject = PublishSubject<[OfflineArticle]>()
   var offlineArticleModelObservable: Observable<[OfflineArticle]> {
   return offlineArticleModelSubject
   }

}

class Connectivity {
    class func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
