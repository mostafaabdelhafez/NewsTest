//
//  NewsViewController.swift
//  NewsApp
//
//  Created by Mostafa on 2/2/22.
//

import UIKit
import Alamofire
import RxCocoa
import RxSwift
import RealmSwift
class NewsViewController: UIViewController {
    let realm = try! Realm()

    private let cellId = "newsTableViewCell"
    private  let disposeBag = DisposeBag()

    private var newsViewModel = NewsViewModel()
    var statusCode:StatusCodes!{
        didSet{
            
        }
    }

    func readFromRealm(){
        let offlineArticles  = try! realm.objects(OfflineArticle.self)
        
        var listOfArticles = [OfflineArticle]()
        offlineArticles.forEach { (offlineArticle) in
            listOfArticles.append(offlineArticle)
        }
        self.subsribeToRealm()
        self.newsViewModel.offlineArticleModelSubject.onNext(listOfArticles)
    }
    
    @IBOutlet weak var newsTableView:UITableView!
    private func populateNews(){
        if Connectivity.isConnectedToInternet(){
        let url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=9c2a2ff0b6df41068074d87ce7053d93"
        
        AF.request(url, method: .get).responseJSON { [weak self](response) in
            guard let self = self else{return}
            switch response.result{
             case .success:
                guard let fetchedResponse = response.response else{return}
                if fetchedResponse.statusCode == 200{
                     do{
                         let model = try JSONDecoder().decode(ArticleModel.self, from: response.data!)
                            self.subsribeToResponse()
                            self.newsViewModel.saveToRealmFrom(Articles: model.articles)
                        self.newsViewModel.articleModelSubject.onNext(model.articles)
                        DispatchQueue.main.async {
                            self.newsTableView.reloadData()
                        }
                     }
                     catch{
                        
                    }
                 }
               else if fetchedResponse.statusCode == 401 {
                self.statusCode = .unAuthorized
                 }
             case .failure:
                self.statusCode = .error
             }
        }}
        
        else{
            self.readFromRealm()
        }

    }
    func subsribeToResponse(){
        newsViewModel.articleModelObservable.bind(to: self.newsTableView
                                                    .rx
                                                    .items(cellIdentifier: cellId,
                                                           cellType: NewsTableViewCell.self)) { row, news, cell in
                                                            print(row)
            cell.title.text = news.title
            cell.details.text = news.description
            cell.thumbnail.kf.indicatorType = .activity
            cell.thumbnail.kf.setImage(with: (news.urlToImage ?? "").convertToUrl())
        }.disposed(by: disposeBag)
    }
    func subsribeToRealm(){
        newsViewModel.offlineArticleModelObservable.bind(to: self.newsTableView
                                                    .rx
                                                    .items(cellIdentifier: cellId,
                                                           cellType: NewsTableViewCell.self)) { row, news, cell in
                                                            print(row)
            cell.title.text = news.title
            cell.details.text = news.articleDescription
            cell.thumbnail.kf.indicatorType = .activity
            cell.thumbnail.kf.setImage(with: (news.urlToImage).convertToUrl())
        }.disposed(by: disposeBag)
    }

    func setupTableView() {
        newsTableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: cellId)
    }

    func navigateToDetailsWith(article:[Article]){
        let detailsScreen = ArticleDetailsViewController(nibName: "ArticleDetailsViewController", bundle: nil)
        detailsScreen.article = article
        self.present(detailsScreen, animated: true, completion: nil)
    }
    func subscribeToNewsSelection(){
        if Connectivity.isConnectedToInternet(){
            Observable
                .zip(newsTableView.rx.itemSelected, newsTableView.rx.modelSelected(Article.self))
                .bind { [weak self] selectedIndex, article in
                    guard let self = self else{return}
                    print(selectedIndex,article.content ?? "")
                    self.navigateToDetailsWith(article:[article])
            }
            .disposed(by: disposeBag)
        }
        else{
            Observable
                .zip(newsTableView.rx.itemSelected, newsTableView.rx.modelSelected(OfflineArticle.self))
                .bind { [weak self] selectedIndex, article in
                    guard let self = self else{return}
                    let singleArticle = Article(title: article.title, description: article.articleDescription, urlToImage: article.urlToImage, content: article.content)

                    self.navigateToDetailsWith(article:[singleArticle])
            }
            .disposed(by: disposeBag)


        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        setupTableView()
        populateNews()
        subscribeToNewsSelection()
    }

}

