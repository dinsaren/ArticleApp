//
//  CreateArticleViewController.swift
//  ArticleApp
//
//  Created by Dinsaren on 12/17/18.
//  Copyright © 2018 Dinsaren. All rights reserved.
//

import UIKit
import Alamofire
class CreateArticleViewController: UIViewController{
    @IBOutlet weak var articleTitleTextField: UITextField!
    
    @IBOutlet weak var articleDescriptionTextView: UITextView!
    @IBOutlet weak var articleimageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(uploadImageTapped))
        articleimageView.isUserInteractionEnabled = true
        articleimageView.addGestureRecognizer(tapGestureRecognizer)
        

    }
    @IBAction func didInsertArticle(_ sender: Any) {
        insertArticle(title: "\(articleTitleTextField.text!)", desc: "\(articleDescriptionTextView.text!)", authorId: 1, categorId: 1, status: "true", image: "http://cdn.sabay.com/cdn/media.sabay.com/media/sabay-news/Sport-News/Local-Sports/Kun-Khmer-Boxing/MMA/ONE-FC1/5c185a871c0a6_1545099900_large.jpg")
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
            print("Insert Success!")
        }
    }
    //upload image
    func uploadArticleImage(){
        let url = "";
        let headers = [
            "Authorization" : "Basic QU1TQVBJQURNSU46QU1TQVBJUEBTU1dPUkQ=",
            "Accept" : "application/json",
            "Content-Type" : "application/json"
        ]
    }
   

   
}
extension CreateArticleViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @objc func uploadImageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let alert = UIAlertController(title: "សូមជ្រើសរើសរូបភាព", message: "", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "ការម៉េរ៉ា", style: .default, handler: { (action) in
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.allowsEditing = false
            
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                picker.sourceType = .camera
            } else {
                picker.sourceType = .photoLibrary
                picker.modalPresentationStyle = .fullScreen
            }
            
            self.present(picker, animated: true)
        }))
        alert.addAction(UIAlertAction(title: "Gallary", style: .default, handler: { (action) in
            let imagePickerView = UIImagePickerController()
            imagePickerView.delegate = self
            self.present(imagePickerView, animated: true)
        }))
        present(alert, animated: true)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        articleimageView.image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
      dismiss(animated: true, completion: nil)
    }
    

}
