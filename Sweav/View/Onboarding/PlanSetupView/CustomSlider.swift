import SwiftUI

struct CustomSlider: View {
    @Binding var value: Double
    @Binding var isValueChanged: Bool
    
    let minValue: Double = 0
    let maxValue: Double = 7
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let knobSize: CGFloat = 32
            let progress = CGFloat((value - minValue) / (maxValue - minValue))
            let knobPosition = progress * (width - knobSize)
            
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(Color(hex: "#F0EEEA"))
                    .frame(height: 12)
                
                Circle()
                    .fill(Color.main)
                    .frame(width: knobSize, height: knobSize)
                    .overlay(
                        Circle().stroke(Color.white, lineWidth: 3)
                    )
                    .offset(x: knobPosition)
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                isValueChanged = true
                                let location = min(max(0, gesture.location.x - knobSize / 2), width - knobSize)
                                let newValue = Double(location / (width - knobSize)) * (maxValue - minValue) + minValue
                                value = min(maxValue, max(minValue, round(newValue)))
                            }
                    )

                HStack {
                    Text("0")
                        .foregroundColor(
                            isValueChanged && value == 0 ? Color.default : Color.tertiary
                        )
                    
                    Spacer()
                    
                    Text("7")
                        .foregroundColor(
                            value == 7 ? Color.default : Color.tertiary
                        )
                }
                .font(.system(size: 18, weight: .medium))
                .padding(.horizontal, 8)
                .offset(y: 36)
                
                if ![0,7].contains(value) {
                    Text("\(Int(value))")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(Color(hex: "#252525"))
                        .frame(width: 36, height: 28)
                        .cornerRadius(8)
                        .shadow(radius: 1)
                        .offset(x: knobPosition - 2, y: 36)
                }
            }
            .frame(height: 64)
        }
        .frame(height: 64)
        .padding(.horizontal, 8)
    }
}
