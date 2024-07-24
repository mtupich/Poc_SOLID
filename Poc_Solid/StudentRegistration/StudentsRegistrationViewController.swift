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
            // Exibir um alerta se algum campo estiver vazio
            let alert = UIAlertController(title: "Erro", message: "Todos os campos são obrigatórios.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        // Obter o contexto do Core Data
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        // Criar uma nova entidade Student
        let student = Student(context: context)
        student.studentName = name
        student.studentGender = gender
        student.studentEmail = email
        student.studentEmail = id
        
        // Salvar o contexto
        do {
            try context.save()
            // Exibir um alerta de sucesso
            let alert = UIAlertController(title: "Sucesso", message: "Dados salvos com sucesso.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        } catch {
            // Exibir um alerta de erro
            let alert = UIAlertController(title: "Erro", message: "Falha ao salvar os dados.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            print("Falha ao salvar os dados: \(error)")
        }
    }
    
    func getCoreDataSavedObjects() {
        // Obter o contexto do Core Data
              let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
              
              // Criar uma requisição para a entidade Student
              let fetchRequest: NSFetchRequest<Student> = Student.fetchRequest()
              
              do {
                  // Executar a requisição
                  let students = try context.fetch(fetchRequest)
                  
                  // Exibir os dados dos estudantes
                  for student in students {
                      print("Nome: \(student.studentName ?? "Sem nome")")
                      print("Gênero: \(student.studentGender ?? "Sem gênero")")
                      print("Email: \(student.studentEmail ?? "Sem email")")
                      print("ID: \(student.studentId ?? 0)")
                  }
                  
                  // Se quiser exibir um alerta com os dados
                  let alertMessage = students.map { student in
                      """
                      Nome: \(student.studentName ?? "Sem nome")
                      Gênero: \(student.studentGender ?? "Sem gênero")
                      Email: \(student.studentEmail ?? "Sem email")
                      ID: \(student.studentId  ?? 0)
                      """
                  }.joined(separator: "\n\n")
                  
                  let alert = UIAlertController(title: "Estudantes", message: alertMessage, preferredStyle: .alert)
                  alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                  present(alert, animated: true, completion: nil)
                  
              } catch {
                  print("Falha ao buscar os dados: \(error)")
              }
          }
}
