//
//  DonateViewController.swift
//  Weatherly
//
//  Created by Affan Zukić on 2020-05-06.
//  Copyright © 2020 Affan Zukić. All rights reserved.
//

import UIKit
import SafariServices

class DonateViewController: UIViewController
{
    let donateAlert = UIAlertController(title: "Donate", message: "Please consider donating as it would help the team in further development.", preferredStyle: .alert)
    var instagramURL = ""
    
    @IBOutlet weak var vildan: UIImageView!
    @IBOutlet weak var arnes: UIImageView!
    @IBOutlet weak var almir: UIImageView!
    @IBOutlet weak var ja: UIImageView!
    @IBOutlet weak var ammarudin: UIImageView!
    
    func makeImageRounded(image: UIImageView)
    {
        image.layer.borderWidth = 1
        image.layer.masksToBounds = false
        image.layer.cornerRadius = image.frame.height / 2
        image.clipsToBounds = true
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        makeImageRounded(image: vildan)
        makeImageRounded(image: arnes)
        makeImageRounded(image: almir)
        makeImageRounded(image: ja)
        makeImageRounded(image: ammarudin)
    }
    
    @IBAction func vildanInstagram(_ sender: UIButton)
    {
        instagramURL = "https://instagram.com/vildann8"
        let url = URL(string: instagramURL)
        let svc = SFSafariViewController(url: url!)
        self.present(svc, animated: true, completion: nil)
    }
    
    @IBAction func arnesInstagram(_ sender: UIButton)
    {
        instagramURL = "https://instagram.com/arnes.rastoder"
        let url = URL(string: instagramURL)
        let svc = SFSafariViewController(url: url!)
        self.present(svc, animated: true, completion: nil)
    }
    
    @IBAction func almirInstagram(_ sender: UIButton)
    {
        instagramURL = "https://instagram.com/hadzolinou"
        let url = URL(string: instagramURL)
        let svc = SFSafariViewController(url: url!)
        self.present(svc, animated: true, completion: nil)
    }
    
    @IBAction func jaInstagram(_ sender: UIButton)
    {
        instagramURL = "https://instagram.com/zukic1"
        let url = URL(string: instagramURL)
        let svc = SFSafariViewController(url: url!)
        self.present(svc, animated: true, completion: nil)
    }
    
    @IBAction func ammarudinInstagram(_ sender: UIButton)
    {
        instagramURL = "https://instagram.com/ammarudin6173"
        let url = URL(string: instagramURL)
        let svc = SFSafariViewController(url: url!)
        self.present(svc, animated: true, completion: nil)
    }
    
    @IBAction func donateButton(_ sender: UIButton)
    {
        donateAlert.addAction(UIAlertAction(title: "Donate", style: .default, handler: {(action) -> Void in
            let url = URL(string: "https://paypal.me/2uk4")
            let svc = SFSafariViewController(url: url!)
            self.present(svc, animated: true, completion: nil)
        }))
        donateAlert.addAction(UIAlertAction(title: "Not now", style: .default, handler: nil))
        self.present(donateAlert, animated: true, completion: nil)
    }
}
