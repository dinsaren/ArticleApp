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
     var refeshing : UIRefreshControl!
    var page = 1
    var limit = 15
    let headers = ["Authorization" : "Basic QU1TQVBJQURNSU46QU1TQVBJUEBTU1dPUkQ="]
    var articleList = [Article]()
    override func viewDidLoad() {
        super.viewDidLoad()
        refeshing=UIRefreshControl()
        refeshing.attributedTitle = NSAttributedString(string: "កុំពុងទាញទិន្ន័យ")
        refeshing.addTarget(self, action: #selector(ViewController.getArticle), for: UIControl.Event.valueChanged)
        articleTable.addSubview(refeshing)
        getArticle(page: 1, limit: 15)
        // Do any additional setup after loading the view, typically from a nib.
    }
    @objc func getArticle(page : Int,limit : Int){
        let url = "http://api-ams.me/v1/api/articles?page=\(page)&limit=\(limit)"
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
                self.refeshing.endRefreshing()
               
            }else{
                print("........")
            }
        }
    }
    func insertArticle(title:String,desc:String,authorId:Int,categorId:Int,status:String,image:String){
                let parameters: Parameters = [
                    "TITLE": title,
                    "DESCRIPTION": desc,
                    "AUTHOR": authorId,
                    "CATEGORY_ID": categorId,
                    "STATUS": status,
                    "IMAGE": image
                ]
        
                let url = "http://www.api-ams.me/v1/api/articles"
                let headers: HTTPHeaders = [
                    "Authorization": "Basic QU1TQVBJQURNSU46QU1TQVBJUEBTU1dPUkQ=",
                    "Accept": "application/json"
                ]
                Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers:headers ).responseData { ( response) in
                    guard response.result.isSuccess,let value = response.result.value else {
                        print("Error while fetching: \(String(describing: response.result.error))")
                        return
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
        let image = articleList[indexPath.row].IMAGE
        if image == nil{
            cell.ArticleImageView.image = UIImage(named: "Placeholder.png")
        }else{
             cell.ArticleImageView.kf.setImage(with: url)
        }
       
     return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailView = storyboard?.instantiateViewController(withIdentifier: "detailArticleViewController") as! DetailArticleViewController
        detailView.articletitle = articleList[indexPath.row].TITLE
        detailView.articledesc=articleList[indexPath.row].DESCRIPTION
        detailView.articleimgage=articleList[indexPath.row].IMAGE
        self.navigationController?.pushViewController(detailView, animated: true)
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.articleList.remove(at: indexPath.row)
            self.articleTable.reloadData()
        }
        
    }
    
}

