import SwiftUI
import WidgetKit

struct ContentView: View {
    var body: some View {
                ZStack {
                    Tabbar()
                    // NOTE: Keep in here
                    Button("🚩 Reload", action: WidgetCenter.shared.reloadAllTimelines)
                        // NOTE: Kylo --> Go to Add Snippet (top right), select colour pallette and type "Primary" to find Asset Colors!
                        .frame(minWidth: 0)
                        .padding()
                        .foregroundColor(.white)
                        .background(LinearGradient(gradient: Gradient(colors: [Color("Primary"), Color("Primary-Dark")]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(40)
                        .padding(.horizontal, 20)
                }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
