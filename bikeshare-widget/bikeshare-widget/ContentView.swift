import SwiftUI
import WidgetKit

struct ContentView: View {
    var body: some View {
                ZStack {
                    Tabbar()
                    // NOTE: Keep in here
                        VStack(alignment: .trailing) {
                           // Button("Reload Widget", action: WidgetCenter.shared.reloadAllTimelines)
                                // NOTE: Kylo --> Go to Add Snippet (top right), select colour pallette and type "Primary" to find Asset Colors!
                            Button(action: WidgetCenter.shared.reloadAllTimelines) {
                                        Text("Reload Widget")
                                    }
                                    .buttonStyle(CircleStyle())
                                    .frame(width: 40, height: 40)
                            Spacer()
                        }
                    }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CircleStyle: ButtonStyle {
    func makeBody(configuration: ButtonStyleConfiguration) -> some View {
        Circle()
            .fill(LinearGradient(gradient: Gradient(colors: [Color("Primary"), Color("Primary-Dark")]), startPoint: .leading, endPoint: .trailing))
            .overlay(
                Circle()
                    .stroke(lineWidth: 2)
                    .foregroundColor(.white)
                    .padding(4)
            )
            .overlay(
                configuration.label
                    .foregroundColor(.white)
                    .font(.footnote)
            )
            .frame(width: 60, height: 60)
    }
}

