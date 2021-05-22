//
//  Helper.swift
//  Widgics
//
//  Created by Pushpinder Pal Singh on 22/05/21.
//

import SwiftUI

public struct Colors {
	public static let color1:Color = Color("#E2FAE7")
	public static let color1Accent:Color = Color("#72BF82")
	public static let color2:Color = Color("#EEF1FF")
	public static let color2Accent:Color = Color("#4266E8")
	public static let color3:Color = Color("#FCECEA")
	public static let color3Accent:Color = Color("#E1614C")
	public static let OrangeEnd:Color = Color("#FF782C")
	public static let OrangeStart:Color = Color("#EC2301")
	public static let LegendText:Color = Color("#A7A6A8")
	public static let LegendColor:Color = Color("#E8E7EA")
	public static let LegendDarkColor:Color = Color("#545454")
	public static let IndicatorKnob:Color = Color("#FF57A6")
	public static let GradientUpperBlue:Color = Color("#C2E8FF")
	public static let GradinetUpperBlue1:Color = Color("#A8E1FF")
	public static let GradientPurple:Color = Color("#7B75FF")
	public static let GradientNeonBlue:Color = Color("#6FEAFF")
	public static let GradientLowerBlue:Color = Color("#F1F9FF")
	public static let DarkPurple:Color = Color("#1B205E")
	public static let BorderBlue:Color = Color("#4EBCFF")
}

public struct GradientColor {
	public let start: Color
	public let end: Color

	public init(start: Color, end: Color) {
		self.start = start
		self.end = end
	}

	public func getGradient() -> Gradient {
		return Gradient(colors: [start, end])
	}
}

public struct GradientColors {
	public static let orange = GradientColor(start: Colors.OrangeStart, end: Colors.OrangeEnd)
	public static let blue = GradientColor(start: Colors.GradientPurple, end: Colors.GradientNeonBlue)
	public static let green = GradientColor(start: Color("0BCDF7"), end: Color("A2FEAE"))
	public static let blu = GradientColor(start: Color("0591FF"), end: Color("29D9FE"))
	public static let bluPurpl = GradientColor(start: Color("4ABBFB"), end: Color("8C00FF"))
	public static let purple = GradientColor(start: Color("741DF4"), end: Color("C501B0"))
	public static let prplPink = GradientColor(start: Color("BC05AF"), end: Color("FF1378"))
	public static let prplNeon = GradientColor(start: Color("FE019A"), end: Color("FE0BF4"))
	public static let orngPink = GradientColor(start: Color("FF8E2D"), end: Color("FF4E7A"))
}

public class ChartData: ObservableObject, Identifiable {
	@Published var points: [(String,Double)]
	var valuesGiven: Bool = false
	var ID = UUID()

	public init<N: BinaryFloatingPoint>(points:[N]) {
		self.points = points.map{("", Double($0))}
	}
	public init<N: BinaryInteger>(values:[(String,N)]){
		self.points = values.map{($0.0, Double($0.1))}
		self.valuesGiven = true
	}
	public init<N: BinaryFloatingPoint>(values:[(String,N)]){
		self.points = values.map{($0.0, Double($0.1))}
		self.valuesGiven = true
	}
	public init<N: BinaryInteger>(numberValues:[(N,N)]){
		self.points = numberValues.map{(String($0.0), Double($0.1))}
		self.valuesGiven = true
	}
	public init<N: BinaryFloatingPoint & LosslessStringConvertible>(numberValues:[(N,N)]){
		self.points = numberValues.map{(String($0.0), Double($0.1))}
		self.valuesGiven = true
	}

	public func onlyPoints() -> [Double] {
		return self.points.map{ $0.1 }
	}
}
