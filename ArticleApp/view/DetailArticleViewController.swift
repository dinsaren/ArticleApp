//
//  DetailArticleViewController.swift
//  ArticleApp
//
//  Created by Dinsaren on 12/17/18.
//  Copyright © 2018 Dinsaren. All rights reserved.
//

import UIKit

class DetailArticleViewController: UIViewController {
    @IBOutlet weak var articleTitleLabel: UILabel!
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var articleDescriptionTextView: UITextView!
    var articletitle : String?
    var articleimgage : String?
    var articledesc :String?
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "\(articleimgage!)")
        articleImageView.kf.setImage(with: url)
        articleTitleLabel.text = articletitle
        articleDescriptionTextView.text = articledesc
        
    }
    


}
