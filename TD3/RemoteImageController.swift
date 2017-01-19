//
//  RemoteImageController.swift
//  TD3
//
//  Created by GELE Axel on 16/01/2017.
//  Copyright © 2017 GELE Axel. All rights reserved.
//

import UIKit

class RemoteImageController: UIViewController {
    let imageView = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.lightGray
        
        let buttonCreateImageView = UIButton()
        buttonCreateImageView.backgroundColor = UIColor.white
        buttonCreateImageView.frame = CGRect(x: 50, y: 20, width: 300, height: 50)
        buttonCreateImageView.backgroundColor = UIColor.white
        buttonCreateImageView.setTitle("Create image view", for: UIControlState.normal)
        buttonCreateImageView.addTarget(self, action: #selector(self.createImageView), for: UIControlEvents.touchDown)
        buttonCreateImageView.setTitleColor(UIColor.blue, for: .normal)
        view.addSubview(buttonCreateImageView)
        
        let buttonAssociateImageBundle = UIButton(frame: CGRect(x: 50, y: 90, width: 300, height: 50))
        buttonAssociateImageBundle.backgroundColor = UIColor.white
        buttonAssociateImageBundle.setTitle("Associer à l'image du bundle", for: UIControlState.normal)
        buttonAssociateImageBundle.addTarget(self, action: #selector(self.associateImageBundle), for: UIControlEvents.touchDown)
        buttonAssociateImageBundle.setTitleColor(UIColor.blue, for: UIControlState.normal)
        view.addSubview(buttonAssociateImageBundle)
        
        let buttonAssociateImageUrl = UIButton(frame: CGRect(x: 50, y: 160, width: 300, height: 50))
        buttonAssociateImageUrl.backgroundColor = UIColor.white
        buttonAssociateImageUrl.setTitle("Associer à l'image d'une URL", for: UIControlState.normal)
        buttonAssociateImageUrl.addTarget(self, action: #selector(self.associateImageURL), for: UIControlEvents.touchDown)
        buttonAssociateImageUrl.setTitleColor(UIColor.blue, for: .normal)
        view.addSubview(buttonAssociateImageUrl)
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createImageView()
    {
        imageView.frame = CGRect(x: 0, y: 400, width: view.frame.width, height: 200)
        imageView.image = nil
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.backgroundColor = UIColor.white
        view.addSubview(imageView)
        
    }
    
    func associateImageBundle(){
        let monImage = UIImage(named: "background")
        imageView.image = monImage
    }
    
    func associateImageURL(){
        let url = URL(string: "https://a3-images.myspacecdn.com/images03/1/dfbcc45c9c36430bbf31a5819de9c339/300x300.jpg")
        
        let data = try? Data(contentsOf: url!)
        
        imageView.image = UIImage(data: data!)

        
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
