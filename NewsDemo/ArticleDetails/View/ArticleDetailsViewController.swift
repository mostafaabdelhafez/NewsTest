//
//  ArticleDetailsViewController.swift
//  NewsApp
//
//  Created by Mostafa on 2/3/22.
//

import UIKit
import RxCocoa
import RxSwift

class ArticleDetailsViewController: UIViewController {
    var article:[Article]!
    var articleModelObservable: Observable<[Article]> {
    return articleModelSubject
    }
     var articleModelSubject = PublishSubject<[Article]>()
    private let disposeBag = DisposeBag()

    @IBOutlet weak var newsDetailsTableView:UITableView!
    private var cellId = "details"
    private var headerId = "header"
    let articleHeader = ArticleHeader()
    let articleFooter:DetailsFooter = UIView.fromNib()
    func setupTableView() {
        newsDetailsTableView.register(UITableViewCell.self, forCellReuseIdentifier:cellId)
        articleHeader.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 400)
        articleFooter.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 200)
        newsDetailsTableView.tableHeaderView = articleHeader
        newsDetailsTableView.tableFooterView = articleFooter
        articleFooter.showAlert = {[weak self] in
            self?.showAlert()
        }

    }
    func showAlert(){
        let alert = UIAlertController(title: "", message: "تم التقييم بنجاح", preferredStyle: .alert)
        self.present(alert, animated: true) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                alert.dismiss(animated: false, completion: nil)
            }
        }
    }
    func subsribeToModel(){
        
        articleModelObservable.bind(to: newsDetailsTableView.rx
                                                    .items(cellIdentifier: cellId,
                                                           cellType: UITableViewCell .self)) { row, news, cell in
            print(news)
            cell.textLabel?.text = news.content
            cell.textLabel?.numberOfLines = 0
            self.articleHeader.articleImage.kf.setImage(with: (news.urlToImage ?? "").convertToUrl())
            
        }.disposed(by: disposeBag)
        articleModelSubject.onNext(article)
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        subsribeToModel()
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }
}
