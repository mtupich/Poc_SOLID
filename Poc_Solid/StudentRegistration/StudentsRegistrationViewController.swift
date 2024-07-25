//
//  StudentsRegistrationViewController.swift
//  Poc_Solid
//
//  Created by Maria Tupich on 24/07/24.
//

import UIKit
import CoreData

class StudentsRegistrationViewController: UIViewController {
    @IBOutlet weak var studentsView: UIView!
    @IBOutlet weak var studentsName: UITextField!
    @IBOutlet weak var studentsGender: UITextField!
    @IBOutlet weak var studentsEmail: UITextField!
    @IBOutlet weak var studentsID: UITextField!
    let persistenceManager = CoreDataPersistenceManager<Student>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUIAdditionalConfiguration()
    }
    
    func setupUIAdditionalConfiguration() {
        studentsView.layer.cornerRadius = 10
        studentsView.layer.shadowColor = UIColor.black.cgColor
        studentsView.layer.shadowOpacity = 0.50
        studentsView.layer.shadowOffset = CGSize(width: 0, height: 2)
        studentsView.layer.shadowRadius = 4
        studentsView.layer.masksToBounds = false
        studentsName.layer.borderWidth = 1
        studentsName.layer.borderColor = UIColor.black.cgColor
        studentsGender.layer.borderWidth = 1
        studentsGender.layer.borderColor = UIColor.black.cgColor
        studentsEmail.layer.borderWidth = 1
        studentsEmail.layer.borderColor = UIColor.black.cgColor
        studentsID.layer.borderWidth = 1
        studentsID.layer.borderColor = UIColor.black.cgColor
    }
    
    
    @IBAction func didTapConfirm(_ sender: UIButton) {
        guard let name = studentsName.text, !name.isEmpty,
              let gender = studentsGender.text, !gender.isEmpty,
              let email = studentsEmail.text, !email.isEmpty,
              let id = studentsID.text, !id.isEmpty else {
            let alert = UIAlertController(title: "Erro", message: "Todos os campos são obrigatórios.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
                
        do {
            try persistenceManager.saveObject(properties: [
                "studentName": name,
                "studentGender": gender,
                "studentEmail": email,
                "studentId": id
            ])
            
            let alert = UIAlertController(title: "Sucesso", message: "Dados salvos com sucesso.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            
        } catch {
            let alert = UIAlertController(title: "Erro", message: "Não foi possível salvar os dados.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
        
    }
}

