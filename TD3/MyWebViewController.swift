//
//  MyWebViewController.swift
//  TD3
//
//  Created by GELE Axel on 17/01/2017.
//  Copyright © 2017 GELE Axel. All rights reserved.
//

import UIKit

class MyWebViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let webView = UIWebView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        self.view = webView
        let myToolBar = UIToolbar(frame: CGRect(x: 0, y: webView.frame.size.height - 99, width: webView.frame.size.width, height: 50))
        let goBackButton = UIBarButtonItem(barButtonSystemItem: .rewind, target: self, action: #selector(self.goBack))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        let refreshButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.refresh, target: self, action: #selector(self.reload))
        let goFollowingButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.fastForward, target: self, action: #selector(self.goForward))
        var items = [UIBarButtonItem]()
        items.append(goBackButton)
        items.append(spaceButton)
        items.append(refreshButton)
        items.append(spaceButton)
        items.append(goFollowingButton)
        myToolBar.setItems(items, animated: true)
        view.addSubview(myToolBar)
        
        // Do any additional setup after loading the view.
    }
    
    func reload(){
     let webView = self.view as! UIWebView
        webView.reload()
    }
    
    func goForward(){
        let webView = self.view as! UIWebView
        if webView.canGoForward{
            webView.goForward()
        }
    }
    func goBack(){
        let webView = self.view as! UIWebView
        if webView.canGoBack {
            webView.goBack()
        }
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
