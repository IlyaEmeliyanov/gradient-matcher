//
//  ContentView.swift
//  GradientMatcher
//
//  Created by Ilya Emeliyanov on 05/05/22.
//

import SwiftUI


struct ContentView: View {
    
    init() {
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    @State var isPresented: Bool = false
    @State var isEqual = false
    
    @State var red1: Double = 255
    @State var green1: Double = 149
    @State var blue1: Double = 0
    
    @State var red2: Double = 255
    @State var green2: Double = 204
    @State var blue2: Double = 0
    
    let color1: Color = .orange
    let color2: Color = .yellow
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.black)
                    .ignoresSafeArea()
                VStack(alignment: .leading, spacing: 0) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Match this gradient")
                            .font(.system(size: 18, weight: .semibold, design: .rounded))
                            .foregroundColor(.white)
                        LinearGradient(colors: [color1, color2], startPoint: .leading, endPoint: .trailing)
                            .frame(maxWidth: .infinity, maxHeight: 100)
                            .cornerRadius(10)
                    }.padding([.leading, .trailing, .bottom], 10)
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Your gradient")
                            .font(.system(size: 18, weight: .semibold, design: .rounded))
                            .foregroundColor(.white)
                        LinearGradient(colors: [Color(red: red1/255, green: green1/255, blue: blue1/255), Color(red: red2/255, green: green2/255, blue: blue2/255)], startPoint: .leading, endPoint: .trailing)
                            .frame(maxWidth: .infinity, maxHeight: 100)
                            .cornerRadius(10)
                    }.padding([.leading, .trailing, .bottom], 10)
                    
                    // ControlPanels
                    HStack(alignment: .center, spacing: 10) {
                        // Left ControlPanel
                        ZStack {
                            Color("TileBackgroundColor")
                            VStack(alignment: .center, spacing: 20) {
                                Stepper(onIncrement: {if (red1 != 255) {red1+=1}}, onDecrement: {if (red1 != 0) {red1-=1}}) {
                                    Text("R: \(round(red1))")
                                        .font(.system(size: 12, weight: .bold))
                                        .foregroundColor(.red)
                                }.foregroundColor(.blue).tint(.blue).padding([.leading, .trailing], 15)
                                Slider(value: $red1, in: 0...255, step: 1).tint(.red).padding([.leading, .trailing], 15)
                                
                                Stepper(onIncrement: {if (green1 != 255) {green1+=1}}, onDecrement: {if (green1 != 0) {green1-=1}}) {
                                    Text("G: \(round(green1))")
                                        .font(.system(size: 12, weight: .bold))
                                        .foregroundColor(.green)
                                }.foregroundColor(.blue).tint(.blue).padding([.leading, .trailing], 15)
                                Slider(value: $green1, in: 0...255, step: 1).tint(.green).padding([.leading, .trailing], 15)

                                
                                Stepper(onIncrement: {if (blue1 != 255) {blue1+=1}}, onDecrement: {if (blue1 != 0) {blue1-=1}}) {
                                    Text("B: \(round(blue1))")
                                        .font(.system(size: 12, weight: .bold))
                                        .foregroundColor(.blue)
                                }.foregroundColor(.blue).tint(.blue).padding([.leading, .trailing], 15)
                                Slider(value: $blue1, in: 0...255, step: 1).tint(.blue).padding([.leading, .trailing], 15)

                            }.padding(10)
                        }.cornerRadius(20)
                        
                        // Right ControlPanel
                        ZStack {
                            Color("TileBackgroundColor")
                            VStack(alignment: .center, spacing: 10) {
                                Stepper(onIncrement: {if (red2 != 255) {red2+=1}}, onDecrement: {if (red2 != 0) {red2-=1}}) {
                                    Text("R: \(round(red2))")
                                        .font(.system(size: 12, weight: .bold))
                                        .foregroundColor(.red)
                                }.foregroundColor(.blue).tint(.blue).padding([.leading, .trailing], 15)
                                Slider(value: $red2, in: 0...255, step: 1).tint(.red).padding([.leading, .trailing], 15)
                                
                                Stepper(onIncrement: {if (green2 != 255) {green2+=1}}, onDecrement: {if (green2 != 0) {green2-=1}}) {
                                    Text("G: \(round(green2))")
                                        .font(.system(size: 12, weight: .bold))
                                        .foregroundColor(.green)
                                }.foregroundColor(.blue).tint(.blue).padding([.leading, .trailing], 15)
                                Slider(value: $green2, in: 0...255, step: 1).tint(.green).padding([.leading, .trailing], 15)

                                
                                Stepper(onIncrement: {if (blue2 != 255) {blue2+=1}}, onDecrement: {if (blue2 != 0) {blue2-=1}}) {
                                    Text("B: \(round(blue2))")
                                        .font(.system(size: 12, weight: .bold))
                                        .foregroundColor(.blue)
                                }.foregroundColor(.blue).tint(.blue).padding([.leading, .trailing], 15)
                                Slider(value: $blue2, in: 0...255, step: 1).tint(.blue).padding([.leading, .trailing], 15)

                            }.padding(10)
                        }.cornerRadius(20)
                    }.padding([.bottom], 20)
                    Button {
                        self.isPresented.toggle()
                        if (Color(red: red1, green: green1, blue: blue1).cgColor == color1.cgColor && Color(red: red2, green: green2, blue: blue2).cgColor == color2.cgColor) {
                            isEqual = true
                        }
                    } label: {
                        Text("Evaluate")
                            .font(.system(size: 16, weight: .semibold)).foregroundColor(.white).padding(4)
                            .frame(maxWidth: .infinity, maxHeight: 30)
                    }.buttonStyle(.borderedProminent).tint(.indigo).padding().sheet(isPresented: $isPresented) {
                        ResultView(isEqual: isEqual)
                    }
                }.navigationTitle("Gradients")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ResultView: View {
    @Environment(\.dismiss) var dismiss
    
    var isEqual: Bool
    
    var body: some View {
        ZStack {
            Color("BackgroundColor").ignoresSafeArea()
            VStack(alignment: .center) {
                Spacer()
                Text("\(isEqual ? "Yey 🥳 you' nailed it!" : "Sorry 😢,\nanother time")")
                    .font(.system(size: 36, weight: .semibold))
                    .foregroundColor(.white)
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Text("Dismiss")
                        .font(.system(size: 16, weight: .semibold)).foregroundColor(.white).padding(4)
                        .frame(maxWidth: .infinity, maxHeight: 30)
                }.buttonStyle(.borderedProminent).tint(.indigo).padding()

            }
        }
    }
}
