//
//  WebsitesTableTableViewController.swift
//  TD3
//
//  Created by GELE Axel on 16/01/2017.
//  Copyright © 2017 GELE Axel. All rights reserved.
//

import UIKit

class WebsitesTableTableViewController: UITableViewController {
    var cells = [UITableViewCell]()
    var myWebView = UIWebView()
    override func viewDidLoad() {
        super.viewDidLoad()
        let maTable = self.view as! UITableView
        maTable.rowHeight = 60
        
        
        var i = 0

        
        while i < 5{
            var url = URL(string: "")
            let labelName = UILabel(frame: CGRect(x: 70, y: 0, width: 100, height: 25))
            let labelURl = UILabel(frame: CGRect(x: 70, y: 30, width: 300, height:25))
            switch i {
            case 0:
                url = URL(string: "https://www.google.com/favicon.ico")
                labelName.text = "Google"
                labelURl.text = "http://google.com"
                break
            case 1:
                url = URL(string: "https://www.facebook.com/favicon.ico")
                labelName.text = "Facebook"
                labelURl.text = "http://facebook.com"
                break
            case 2:
                url = URL(string: "https://www.twitter.com/favicon.ico")
                labelName.text = "Twitter"
                labelURl.text = "http://Twitter.com"
            case 3:
                url = URL(string: "https://www.cafonline.com/favicon.ico")
                labelName.text = "Coupe d'afrique des nations"
                labelURl.text = "http://cafonline.com"
            case 4:
                url = URL(string: "https://www.youtube.com/favicon.ico")
                labelName.text = "Youtube"
                labelURl.text = "http://youtube.com"

                
            default:
                return
                
            }
            
            let cell : UITableViewCell = UITableViewCell()
            let viewRow = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
            let imageViewRow = UIImageView(frame: CGRect(x: 13, y: 13, width: 32, height: 32))
            let data = try! Data(contentsOf: url!)
            imageViewRow.image = UIImage (data : data)
            viewRow.backgroundColor = UIColor.lightGray
            labelName.font = UIFont.boldSystemFont(ofSize: 20)
            viewRow.addSubview(imageViewRow)
            cell.addSubview(viewRow)
            cell.addSubview(labelURl)
            cell.addSubview(labelName)
            cells.append(cell)
            
            i = i + 1
            
        }
        // cell to add new website
        let cell : UITableViewCell = UITableViewCell()
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 50))
        label.text = "Click to add a new website"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = NSTextAlignment.center
        cell.addSubview(label)
        cells.append(cell)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cells.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cells[indexPath.row]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        if(indexPath.row != cells.count - 1)
        {
            let subviews = cells[indexPath.row].subviews
            let labelUrl = subviews[3] as! UILabel
            let url = labelUrl.text
            let myWebViewController = MyWebViewController()
            myWebView = myWebViewController.view as! UIWebView
            let urlRequest = URLRequest(url: URL(string: url!)!)
            myWebView.loadRequest(urlRequest)
            createButtonSafari(aWebviewController: myWebViewController)
            
            
            self.navigationController?.pushViewController(myWebViewController, animated: true)
        }
        else
        {
            let alertView = UIAlertController(title: "New website", message: "", preferredStyle: UIAlertControllerStyle.alert)
            alertView.addTextField(configurationHandler: {(textField : UITextField!) -> Void in
                textField.placeholder = "myWebsiteName"
            })
            alertView.addTextField(configurationHandler: {(textField : UITextField!) -> Void in
                textField.placeholder = "format: http://mywebsite.com"
            })
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
            let okAction = UIAlertAction(title: "Add", style: .default, handler: {action in
                self.addWebsite(name: alertView.textFields![0], url: alertView.textFields![1])})
            alertView.addAction(cancelAction)
            alertView.addAction(okAction)
            alertView.preferredAction = okAction
            self.present(alertView, animated: true, completion: nil)
            
        }
    }
    
    func createButtonSafari(aWebviewController: MyWebViewController)
    {
        let myButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(self.navigateToSafari))
        aWebviewController.navigationItem.setRightBarButton(myButton, animated: true)
        
        //aWebviewController
        
        
    }
    
    func navigateToSafari(sender: AnyObject)
    {
        NSLog((myWebView.request?.url?.absoluteString)!)
        UIApplication.shared.open((myWebView.request?.url!)!)
    }
    
    func addWebsite(name: UITextField, url: UITextField)
    {
        
        let myUrl = URL(string: url.text! + "/favicon.ico")
        let labelName = UILabel(frame: CGRect(x: 70, y: 0, width: 100, height: 25))
        labelName.text = name.text
        let labelURl = UILabel(frame: CGRect(x: 70, y: 30, width: 300, height:25))
        labelURl.text = url.text!
        
        let cell : UITableViewCell = UITableViewCell()
        let viewRow = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        let imageViewRow = UIImageView(frame: CGRect(x: 13, y: 13, width: 32, height: 32))

        let data = try? Data(contentsOf: myUrl!)
        if(data != nil)
        {
            imageViewRow.image = UIImage (data : data!)
        }
        else
        {
            let alertView = UIAlertController(title: "Info", message: "Image not found", preferredStyle: UIAlertControllerStyle.alert)
            self.present(alertView, animated: true, completion: nil)
            alertView.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
        }
        viewRow.backgroundColor = UIColor.lightGray
        labelName.font = UIFont.boldSystemFont(ofSize: 20)
        viewRow.addSubview(imageViewRow)
        cell.addSubview(viewRow)
        cell.addSubview(labelURl)
        cell.addSubview(labelName)
        
        cells.insert(cell, at: cells.count - 1)
        
        let myTable = self.view as! UITableView
        myTable.beginUpdates()
        myTable.insertRows(at: [IndexPath(row: cells.count - 2, section: 0)], with: .automatic)
        myTable.reloadData()
        myTable.endUpdates()

    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
