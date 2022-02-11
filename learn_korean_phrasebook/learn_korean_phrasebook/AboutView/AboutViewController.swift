//
//  AboutViewController.swift
//  learn_korean_phrasebook
//
//  Created by Pham Van Thai on 29/11/2021.
//

import UIKit

class AboutViewController: UIViewController {
    @IBOutlet weak var txtAbout: UITextView!
    
    @IBOutlet weak var constrainTop: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        constrainTop.constant = view.frame.height/4
        txtAbout.layer.cornerRadius = 20
        txtAbout?.text = "Devsenior founded in 2020 by MRSONPRO, Devsenior is one of the startup companies specializing in developing applications on two operating systems iOS .We are a passionate group to create affecting people's lives by creating IT products that they like to use for everyday life. We like to work with new technology and demonstrate a full commitment to agile workflow for a streamlined organization. We are product oriented, not only committed to user-friendly applications but also work with high quality code for sustainable development."
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnDismiss(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
