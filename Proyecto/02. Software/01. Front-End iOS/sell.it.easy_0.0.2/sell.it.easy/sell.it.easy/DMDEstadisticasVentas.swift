//
//  DMDEstadisticasVentas.swift
//  sell.it.easy
//
//  Created by David Márquez Delgado on 7/10/17.
//  Copyright © 2017 David Márquez Delgado. All rights reserved.
//

import UIKit
import Charts


class DMDEstadisticasVentas: UIViewController {
    
    //MARK: - Variables locales
    
    //MARK: - IBOutlets
    @IBOutlet weak var myBarChartView: BarChartView!
    
    @IBOutlet weak var myPieChartView: PieChartView!
    
    //MARK: - IBActions
    @IBAction func myGuardarACTION(_ sender: Any) {
        let image = myBarChartView.getChartImage(transparent: false)
        UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myPieChartView.delegate = self
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let idTienda = Session.shared.tiendaSeleccionada?.id!
        
        let gregorian = Calendar(identifier: .gregorian)
        let now = Date()
        var components = gregorian.dateComponents([.year, .month, .day, .hour, .minute, .second], from: now)
        
        // Change the time to 9:30:00 in your locale
        //TODO: quitar mes
        components.hour = 23
        components.minute = 59
        components.second = 59
        let night = gregorian.date(from: components)!
        
        
        components.hour = 0
        components.minute = 0
        components.second = 0
        let morning = gregorian.date(from: components)!
        
        
        
        
        EstadisticasService.shared.venta(idTienda: idTienda!, fechaInicio: morning, fechaFin: night) { (estadisticas) in
            self.setChart(self.myBarChartView, etiquetas: self.getString((estadisticas?.horas)!), valores: (estadisticas?.dineroHoras)!)
            self.setChart(self.myPieChartView, dataPoints: (estadisticas?.nombreVendedores)!, values: (estadisticas?.porcentajeVendedores)!)

        }
        
    }
    
    
    //MARK: - Utils
    func setChart(_ graficoBarras: BarChartView, etiquetas: [String], valores: [Double]){
        //Texto sin datos
        myBarChartView.noDataText = "No existen datos"
        
        //Recuperar los datos
        var datos = [BarChartDataEntry]()
        for i in 0..<etiquetas.count {
            let dato = BarChartDataEntry(x: Double(i), y: valores[i])
            
            datos.append(dato)
        }
        //Crear conjunto de datos
        let conjuntoDeDatos = BarChartDataSet(values: datos, label: "Vendido por hora")
        
        //Crear datos para el gráfico a partir del conjunto
        let datosGrafico = BarChartData(dataSet: conjuntoDeDatos)
        
        //Asignar los datos al gráfico
        graficoBarras.data = datosGrafico
        
        //Eliminar la descripción del gráfico
        graficoBarras.chartDescription?.text = ""
        
        graficoBarras.xAxis.valueFormatter = IndexAxisValueFormatter(values: etiquetas)
        
        graficoBarras.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInOutBounce)
        
    }
    
    func setChart(_ pieChartView: PieChartView, dataPoints: [String], values: [Double]) {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry1 = PieChartDataEntry(value: values[i], label: dataPoints[i])
            
            dataEntries.append(dataEntry1)
        }
        
        let pieChartDataSet = PieChartDataSet(values: dataEntries, label: "")
        pieChartDataSet.selectionShift = 10.0
        pieChartDataSet.sliceSpace = 1.0
        
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 1
        formatter.multiplier = 1.0
        pieChartData.setValueFormatter(DefaultValueFormatter(formatter: formatter))
        
        pieChartView.data = pieChartData
        
        var colors: [UIColor] = []
        
        for i in 0..<dataPoints.count {
            
            var color : UIColor
            
            switch i{
            case 0:
                color = #colorLiteral(red: 0.7725490196, green: 1, blue: 0.5490196078, alpha: 1)
            case 1:
                color = #colorLiteral(red: 1, green: 0.968627451, blue: 0.5490196078, alpha: 1)
            case 2:
                color = #colorLiteral(red: 1, green: 0.8235294118, blue: 0.5490196078, alpha: 1)
            case 3:
                color = #colorLiteral(red: 0.5490196078, green: 0.9215686275, blue: 1, alpha: 1)
            default:
                color = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            }
            
            colors.append(color)
        }
        
        pieChartDataSet.colors = colors
        pieChartView.animate(yAxisDuration: 2.0, easingOption: .easeInBack)
        
        pieChartView.centerText = "V. por vendedor"
        
        pieChartView.chartDescription?.text = ""
        pieChartView.drawSlicesUnderHoleEnabled = true
        
    }
    
    
    func getString(_ enteros: [Int]) -> [String]{
        var toReturn = [String]()
        for entero in enteros {
            toReturn.append(String(entero) + " h.")
        }
        return toReturn
    }
    
    
}

//MARK: - extensión delegado grafico
extension DMDEstadisticasVentas: ChartViewDelegate{
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        
    }
}
