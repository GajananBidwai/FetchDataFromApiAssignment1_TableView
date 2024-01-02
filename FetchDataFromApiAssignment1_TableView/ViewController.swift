//
//  ViewController.swift
//  FetchDataFromApiAssignment1_TableView
//
//  Created by Mac on 19/12/23.
//

import UIKit

class ViewController: UIViewController {

    var post : [Post] = []
    
    @IBOutlet weak var postTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        initializeTableView()
        registerXIBWithTableView()
    }
    func fetchData()
    {
        let posturl = URL(string: "https://jsonplaceholder.typicode.com/albums")
        var postUrlRequest = URLRequest(url: posturl!)
        postUrlRequest.httpMethod = "Get"
        

        let urlSession = URLSession(configuration: .default)
        let postDataTask = urlSession.dataTask(with: postUrlRequest) { postdata, postresponse, posterror in
            
            let postUrlResponse = try! JSONSerialization.jsonObject(with: postdata!) as! [[String : Any]]
            print(postdata)
            print(postresponse)
            print(posterror)
            
            for eachResponse in postUrlResponse
            {
                let postDictionary = eachResponse as! [String : Any]
                let postUserId = postDictionary["userId"] as! Int
                let postId = postDictionary["id"] as! Int
                let postTitle = postDictionary["title"] as! String
                
                let postObjec = Post(userId: postUserId, id: postId, title: postTitle)
                self.post.append(postObjec)
            }
            DispatchQueue.main.async {
                self.postTableView.reloadData()
            }
        }
        postDataTask.resume()
    }
    func initializeTableView()
    {
        postTableView.dataSource = self
        postTableView.delegate = self
    }
    func registerXIBWithTableView()
    {
        let uinib = UINib(nibName: "PostTableViewCell", bundle: nil)
        postTableView.register(uinib, forCellReuseIdentifier: "PostTableViewCell")
    }
}
extension ViewController : UITableViewDelegate
{
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150.5
    }
}
extension ViewController : UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        post.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let postTableViewCell = self.postTableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as! PostTableViewCell
        
        postTableViewCell.userId.text = String(post[indexPath.row].userId)
        postTableViewCell.idLabel.text = String(post[indexPath.row].id)
        postTableViewCell.titleLabel.text = post[indexPath.row].title
        
        return postTableViewCell
    }
    
    
}


