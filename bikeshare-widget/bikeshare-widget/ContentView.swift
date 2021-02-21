import SwiftUI
import WidgetKit

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Button("Reload Widget Timelines", action: WidgetCenter.shared.reloadAllTimelines)
                    .background(Color(#colorLiteral(red: 0.7755630612, green: 0.9019065499, blue: 0.1580779552, alpha: 1)))
                    .accentColor(Color(#colorLiteral(red: 0.7004067898, green: 0.4684002399, blue: 0.8790591955, alpha: 1))) // NOTE: Kylo --> Go to Add Snippet (top right), select colour pallette and type "Primary" to find Asset Colors!
                    .font(Font.system(.title))
                    .cornerRadius(5)
                Spacer()
            }
            .navigationBarTitle("Bikeshare App")
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
