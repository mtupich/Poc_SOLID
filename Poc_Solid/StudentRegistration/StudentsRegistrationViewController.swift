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
    
    
    @IBAction func didTapConfirm(_ sender: UIButton) {
        if validateFields() {
            saveStudentForm()
        }
    }
    
    func validateFields() -> Bool {
        guard let name = studentsName.text, !name.isEmpty,
              let gender = studentsGender.text, !gender.isEmpty,
              let email = studentsEmail.text, !email.isEmpty,
              let id = studentsID.text, !id.isEmpty
        else {
            showAlert(title: "Erro", messsage: "Todos os campos são obrigatórios.", titleBtn: "OK")
            return false
        }
        return true
    }
    
    func saveStudentForm() {
        guard let name = studentsName.text, !name.isEmpty,
              let gender = studentsGender.text, !gender.isEmpty,
              let email = studentsEmail.text, !email.isEmpty,
              let id = studentsID.text, !id.isEmpty else { return }
        do {
            try persistenceManager.saveObject(properties: [
                "studentName": name,
                "studentGender": gender,
                "studentEmail": email,
                "studentId": id
            ])
            cleanSavedData()
            showAlert(title: "Sucesso", messsage: "Dados salvos com sucesso.", titleBtn: "OK")
        } catch {
            showAlert(title: "Erro", messsage: "Não foi possível salvar os dados.", titleBtn: "OK")
        }
    }
    
    func showAlert(title: String, messsage: String, titleBtn: String) {
        let alert = UIAlertController(title: "Erro", message: "Todos os campos são obrigatórios.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
    }
    
    func cleanSavedData() {
        DispatchQueue.main.async {
            self.studentsName.text = ""
            self.studentsGender.text = ""
            self.studentsEmail.text = ""
            self.studentsID.text = ""
        }
    }
}

extension StudentsRegistrationViewController {
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
    
}
