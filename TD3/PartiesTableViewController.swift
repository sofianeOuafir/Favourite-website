//
//  PartiesTableViewController.swift
//  TD3
//
//  Created by GELE Axel on 23/01/2017.
//  Copyright © 2017 GELE Axel. All rights reserved.
//

import UIKit
import SWXMLHash

class PartyCell: UITableViewCell {
    
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelHour: UILabel!
    @IBOutlet weak var labelName: UILabel!
    var nameLbl: UILabel!
}

class PartiesTableViewController: UITableViewController {
    
    var events = [Event]()
    var cells = [UITableViewCell]()
    override func viewDidLoad() {
        super.viewDidLoad()

            NSLog("foreground")
            let url = URL(string: "http://sealounge.lanoosphere.com/seadata_en.xml")
            let data = try! Data(contentsOf: url!)
            let xml = SWXMLHash.lazy(data)
            self.createEventList(xml: xml)
        
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
        return events.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func createEventList(xml: XMLIndexer)
    {
        
        for elem in xml["Data"]["Event"].all {
            let id = elem.element?.attribute(by: "id")?.text
            let name = elem.element?.attribute(by: "name")?.text
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
            let date = dateFormatter.date(from: (elem.element?.attribute(by: "date")?.text)!)
            let url = URL(string: (elem.element?.attribute(by: "flyer")?.text)!)
            let event = Event(id: id!, date: date!, name: name!, url: url!)
            events.append(event)
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "partycell", for: indexPath) as! PartyCell
        let event = self.events[indexPath.row]
        cell.coverImageView.image = nil
        //cell.nameLbl.text = event._name

        let backgroundQueue = DispatchQueue(label: "com.app.queue", qos: .background, target: nil)
        backgroundQueue.async {
            
            let data = try! Data(contentsOf: event._url)
            
            let myImage = UIImage(data: data)
            
            if myImage != nil{
                cell.coverImageView.image = myImage
                cell.coverImageView.alpha = 0
                
                UIView.animate(withDuration: 1.0, animations: {
                    cell.coverImageView.alpha = 1
                })
            }
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        cell.labelDate.text = "Le " + formatter.string(from: event._date)
        formatter.dateFormat = "HH"
        cell.labelHour.text = formatter.string(from: event._date) + "H"
        cell.labelName.text = event._name
        


        return cell
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
