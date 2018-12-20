//
//  ViewController.swift
//  ArticleApp
//
//  Created by Dinsaren on 12/14/18.
//  Copyright © 2018 Dinsaren. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

class ViewController: UIViewController {
    @IBOutlet weak var articleTable: UITableView!
    var page = 1
    var limit = 15
    let url = "http://api-ams.me/v1/api/articles?page=1&limit=15"
    let headers = ["Authorization" : "Basic QU1TQVBJQURNSU46QU1TQVBJUEBTU1dPUkQ="]
    var articleList = [Article]()
    override func viewDidLoad() {
        super.viewDidLoad()
        getArticle();
        // Do any additional setup after loading the view, typically from a nib.
    }
    func getArticle(){
        Alamofire.request(url, method: .get, parameters: nil, headers: nil ).responseJSON { ( response) in
            if response.result.isSuccess{
                var json = response.result.value as? [String:Any]
                let jsonData = json?["DATA"] as! NSArray
                self.articleList.removeAll()
                for data in jsonData{
                    self.articleList.append(Article(JSON:(data as? [String:Any])!)!)
                    
                }
                for c in self.articleList{
                    let ar = c as Article
                    print(ar.TITLE!)
                }
                self.articleTable.reloadData();
            }else{
                print("........")
            }
        }
    }
}
extension ViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("ArticleTableViewCell", owner: self, options: nil)?.first as! ArticleTableViewCell
//        let cell = tableView.dequeueReusableCell(withIdentifier: "articleTableViewCell", for: indexPath) as! ArticleTableViewCell
        cell.titleLabel!.text = articleList[indexPath.row].TITLE
        let url = URL(string: "\(articleList[indexPath.row].IMAGE!)")
        cell.ArticleImageView.kf.setImage(with: url)
     return cell
    }
    
    
}

