//
//  SecondViewController.swift
//  StarWars1
//
//  Created by Home on 11/11/22.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var NameSV: UILabel!
    @IBOutlet weak var EyeSV: UILabel!
    @IBOutlet weak var HairSV: UILabel!
    @IBOutlet weak var PlanetSV: UILabel!
    @IBOutlet weak var MyTableView2: UITableView!
    
    var getName: String = ""
    var getEye: String = ""
    var getHair:String = ""
    var getPlanet : String = ""
    var getFilms: [String] = []
    
//    let planetsv = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        NameSV.text = getName
        EyeSV.text = getEye
        HairSV.text = getHair
        PlanetSV.getDataLabel(url:URL(string: getPlanet)!, StructName: "Planet")
        MyTableView2.delegate = self
        MyTableView2.dataSource = self
                
    }
    

    func DisplayFilms (){
        getFilms.forEach { i in
            print("Film link: \(i)")
        }
        
        
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        getFilms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MyTableView2.dequeueReusableCell(withIdentifier: "myCell2", for: indexPath) as! MyTableViewCell2
        
        cell.LabelFilm.getDataLabel(url: URL(string: getFilms[indexPath.row])!, StructName: "Film")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }


}
