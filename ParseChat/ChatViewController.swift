//
//  ChatViewController.swift
//  ParseChat
//
//  Created by Wenn Huang on 2/23/17.
//  Copyright © 2017 Wenn Huang. All rights reserved.
//

import UIKit
import Parse

struct Post {
    let author : String?
    let text : String?
}

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var messages = [Post]()
    
    @IBOutlet weak var tableView: UITableView! {
        didSet{
            tableView.dataSource = self
            tableView.estimatedRowHeight = 100
            tableView.rowHeight = UITableViewAutomaticDimension
        }
    }
    
    @IBOutlet weak var messageTextField: UITextField!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(onTimer), userInfo: nil, repeats: true)

        // Do any additional setup after loading the view.
    }

    func onTimer() {
        let query = PFQuery(className:"Message")
        query.order(byDescending: "createdAt")
        query.findObjectsInBackground { (messages, error) in query.includeKey("creator")
            if error == nil {
                print("success")
                self.messages = []
            
                for message in messages! {
                    print(message)
                    let user = message["creator"] as? String
                    let text = message["text"] as! String
                    let post = Post(author: user, text:text)
                    self.messages.append(post)
                }
                self.tableView.reloadData()
            } else {
                    print("error: \(error?.localizedDescription)")
            }
        }
    }
    
    @IBAction func createMessage(_ sender: UIButton) {
        if let message = messageTextField.text, message != "" {
            let messageObj = PFObject(className: "Message")
            messageObj["text"] = message
            messageObj["creator"] = PFUser.current()?.username
            messageObj.saveInBackground(block: {(success, error) in
                if error == nil {
                    print ("success!!")
                    
                }else {
                    print("error: \(error?.localizedDescription)")
                }
                })
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! TextCell
        
        cell.post = messages[indexPath.row]
        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
