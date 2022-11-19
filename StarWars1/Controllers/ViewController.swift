//
//  ViewController.swift
//  StarWars1
//
//  Created by Home on 11/10/22.
//

import UIKit


//extension UITableViewCell{
extension UILabel{
    func getDataLabel(url: URL, StructName: String){
    //contentMode = mode
    
    //GET request
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    let task = URLSession.shared.dataTask(with: request) {
        data, response, error in
        
        if let data = data {
            //let str = String(data: data, encoding: .utf8)
            let decoder = JSONDecoder()
            do {// try?  in case error, there is no data
                //Characters.self below means " there is a class which has the same name in the file Characters,swift "
                // then parsedData get the whole JSON data ( characters and results
//                let parsedData2 = try? decoder.decode(Planet.self, from: data)
                if(StructName == "Planet") {
                    let parsedData2 = try? decoder.decode(Planet.self, from: data)
                // the variable character get the results only
                
                    DispatchQueue.main.async {
                    // when data is retrieved, we need to display on table view with function reloadData() that works with the function tableView() to display
                    //self.MyTableView.reloadData()
                        self.text = parsedData2?.name
                   // self.
                    }
                }else if (StructName == "Film"){
                    let parsedData2 = try? decoder.decode(Film.self, from: data)
                    DispatchQueue.main.async {
                        self.text = parsedData2?.title
                    }
                }else {
                        print( "Error : No Data Structure found with :", StructName)
                    }
                
            }catch {
                print(error.localizedDescription)
            }
            
            //let str = String(data: data!, encoding: .utf8)
            //   print(str)
        }
        
    }
    // the previous code of the URLSession has the purpose to prepare but the session is suspended and URLSession.resume() function allows to create the session and run the closure function script
    task.resume()
   // return (planet.name!)
}
}



class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var MyTableView: UITableView!
    
    //var parseData: String?  https://swapi.py4e.com/      //https://swapi.dev/api/people
    let url = URL(string: "https://swapi.py4e.com/api/people/?page=1")
    // below I declare an array of TYPE "Result" which is a struct in the Characters.swift file
    var character = [Result]()
    var planet: Planet?
    var nextPage:String?
    var previousPage:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        MyTableView.delegate = self
        MyTableView.dataSource = self
        getCharacters(url: url!)
        
    }
    
    
    
    func getCharacters(url: URL){
        
        //GET request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            
            if let data = data {
                //let str = String(data: data, encoding: .utf8)
                let decoder = JSONDecoder()
                do {// try?  in case error, there is no data
                    //Characters.self below means " there is a class which has the same name in the file Characters,swift "
                    // then parsedData get the whole JSON data ( characters and results
                     let parsedData = try? decoder.decode(Characters.self, from: data)
                    // the variable character get the results only
                     self.character = parsedData!.results!
                     DispatchQueue.main.async {
                        // when data is retrieved, we need to display on table view with function reloadData() that works with the function tableView() to display
                        self.MyTableView.reloadData()
                    }

                    // like parseData contains the whole JSON, we can get access to the "next" and "previous" element in the Characters structure
                    self.nextPage = parsedData?.next
                    self.previousPage = parsedData?.previous
                  //  print("NextPage:",self.nextPage)
                  //  print("PreviousPage:",self.previousPage)
                    
                    self.character.forEach { i in
                      //  print("Title Data: \(i.name)")
                    }
                    
                }catch {
                    print(error.localizedDescription)
                }
                
                //let str = String(data: data!, encoding: .utf8)
                //   print(str)
            }
            
        }
        // the previous code of the URLSession has the purpose to prepare but the session is suspended and URLSession.resume() function allows to create the session and run the closure function script
        task.resume()
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return character.count
     }
     // here
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MyTableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! MyTableViewCell
        
        cell.NameCharacter.text = character[indexPath.row].name
        cell.EyeCharacter.text = character[indexPath.row].eye_color
        cell.HairCharacter.text = character[indexPath.row].hair_color
        let url = URL(string: character[indexPath.row].homeworld!)!
        // at this moment, this viewController, this tableViewCell and this Label is invoked, so I can access to this label PlanetCharacter and the function getDataLabel
        cell.PlanetCharacter.getDataLabel(url: url, StructName: "Planet")
        return cell


     }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let SecondController = storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        //print("Select Character :",character[indexPath.row].name)
        SecondController.getName   = character[indexPath.row].name!
        SecondController.getEye    = character[indexPath.row].eye_color!
        SecondController.getHair   = character[indexPath.row].hair_color!
        SecondController.getFilms  = character[indexPath.row].films!
        // at this moment, this SecondViewController, this MytableViewCell2 and this Label Planet is NOT invoked yet, so I can NOT access to any label and invoke the function getDataLabel

        SecondController.getPlanet = character[indexPath.row].homeworld!
                
        // any viewController have a navagation controller, then the PROPERTY navigationController contains the reference of NAVIGATION CONTROLLER
        // any viewController child get also the ANCESTOR NAVIGATION CONTROLLER
        // Function pushViewController push the SecondController that become the first viewcontroller in the navigation view
        // Animated = true : view is animated ( displyed ?)
        // we can have OTHER METHOD to pass the parameter by using the method PREPARE SEGUE and make a LINK ON STORYBOARD
        self.navigationController?.pushViewController(SecondController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
      //  DispatchQueue.main.async {
           // when data is retrieved, we need to display on table view with function reloadData() that works with the function tableView() to display
           self.MyTableView.reloadData()
       //}

    }
    
    @IBAction func PreviousBtn(_ sender: Any) {
        guard (previousPage == nil) else{
        let url = URL(string: previousPage!)
        getCharacters(url: url!)
            return
        }

    }
    
    
    @IBAction func NextBtn(_ sender: Any) {
        guard (nextPage == nil) else{
        let url = URL(string: nextPage!)
        getCharacters(url: url!)
            return
        }
    }
    
    
}

