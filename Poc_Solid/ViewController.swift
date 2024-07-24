//
//  ViewController.swift
//  Poc_Solid
//
//  Created by Maria Tupich on 23/07/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var studentsView: UIView!
    @IBOutlet weak var studentsName: UITextField!
    @IBOutlet weak var studentsGender: UITextField!
    @IBOutlet weak var studentsEmail: UITextField!
    @IBOutlet weak var studentsID: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUIAdditionalConfiguration()
    }
    
    func setupUIAdditionalConfiguration() {
        studentsView.layer.cornerRadius = 10 // Ajuste o raio conforme necessário
        studentsView.layer.shadowColor = UIColor.black.cgColor
        studentsView.layer.shadowOpacity = 0.50 // Ajuste a opacidade conforme necessário
        studentsView.layer.shadowOffset = CGSize(width: 0, height: 2) // Ajuste o deslocamento conforme necessário
        studentsView.layer.shadowRadius = 4 // Ajuste o raio conforme necessário
        studentsView.layer.masksToBounds = false
        
        studentsName.layer.borderWidth = 2
        studentsName.layer.borderColor = UIColor.black.cgColor
        studentsGender.layer.borderWidth = 2
        studentsGender.layer.borderColor = UIColor.black.cgColor
        studentsEmail.layer.borderWidth = 2
        studentsEmail.layer.borderColor = UIColor.black.cgColor
        studentsID.layer.borderWidth = 2
        studentsID.layer.borderColor = UIColor.black.cgColor
    }
    
    
    @IBAction func didTapConfirm(_ sender: UIButton) {
    }
}



