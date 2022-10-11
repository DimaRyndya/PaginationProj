import SwiftUI

struct ActivityIndicatorView: View {
    let style = StrokeStyle(lineWidth: 6, lineCap: .round)
    @State private var animate = false

    let color1 = Color.red
    let color2 = Color.yellow

    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0, to: 0.7)
                .stroke(
                    AngularGradient(
                        gradient: .init(colors: [color1, color2]),
                        center: .center),
                    style: style)
                .rotationEffect(Angle(degrees: animate ? 360 : 0))
                .animation(
                    Animation.linear(duration: 0.7)
                        .repeatForever(autoreverses: false))
        }
        .onAppear {
            animate.toggle()
        }
    }
}

struct ActivityIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityIndicatorView()
    }
}
