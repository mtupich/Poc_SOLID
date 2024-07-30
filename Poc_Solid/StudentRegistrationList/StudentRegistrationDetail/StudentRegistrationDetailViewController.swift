//
//  StudentRegistrationDetailViewController.swift
//  Poc_Solid
//
//  Created by Maria Tupich on 26/07/24.
//

import UIKit

class StudentRegistrationDetailViewController: UIViewController {

    @IBOutlet weak var studentsView: UIView!
    @IBOutlet weak var studentsName: UITextField!
    @IBOutlet weak var studentsGender: UITextField!
    @IBOutlet weak var studentsEmail: UITextField!
    @IBOutlet weak var studentsID: UITextField!
    
//    var student: StudentModel?
    var student2: Student?

        override func viewDidLoad() {
        super.viewDidLoad()
        setupUIAdditionalConfiguration()
        fillFields()
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
    
    func fillFields() {
        guard let student = student2 else { return }
        studentsName.text = student.studentName
        studentsGender.text = student.studentGender
        studentsEmail.text = student.studentEmail
        studentsID.text = student.studentId
    }
    
    
    @IBAction func didTapSave(_ sender: UIButton) {
        guard let student2 = self.student2 else { return }
        
        guard let updatedName = studentsName.text,
              let updatedGender = studentsGender.text,
              let updatedEmail = studentsEmail.text,
              let updatedID = studentsID.text else {
            let errorAlert = UIAlertController(title: "Erro", message: "Todos os campos são obrigatórios.", preferredStyle: .alert)
            errorAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(errorAlert, animated: true, completion: nil)
            return
        }
        
        let updatedProperties: [String: Any] = [
            "studentName": updatedName,
            "studentGender": updatedGender,
            "studentEmail": updatedEmail,
            "studentId": updatedID
        ]
        
        let persistenceManager = CoreDataPersistenceManager<Student>()
        do {
            try persistenceManager.updateObject(object: student2, with: updatedProperties)
            self.navigationController?.popViewController(animated: true)
        } catch {
            print("Erro ao atualizar o objeto: \(error)")
            let errorAlert = UIAlertController(title: "Erro", message: "Não foi possível atualizar o registro. Tente novamente.", preferredStyle: .alert)
            errorAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(errorAlert, animated: true, completion: nil)
        }
    }
    

    @IBAction func didTapDelete(_ sender: UIButton) {
        let alert = UIAlertController(title: "Atenção", message: "Você quer mesmo deletar esse formulário?", preferredStyle: .alert)
           
           let confirmAction = UIAlertAction(title: "Deletar", style: .destructive) { (action) in
               let persistenceManager = CoreDataPersistenceManager<Student>()
               do {
                   guard let student2 = self.student2 else {
                       print("Objeto para deletar não encontrado.")
                       return
                   }
                   try persistenceManager.deleteObject(object: student2)
                   self.navigationController?.popViewController(animated: true)
               } catch {
                   print("Erro ao deletar o objeto: \(error)")
                   let errorAlert = UIAlertController(title: "Erro", message: "Não foi possível deletar o registro. Tente novamente.", preferredStyle: .alert)
                   errorAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                   self.present(errorAlert, animated: true, completion: nil)
               }
           }
           alert.addAction(confirmAction)
           
           let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
           alert.addAction(cancelAction)
           
           present(alert, animated: true, completion: nil)
    }
    
}
