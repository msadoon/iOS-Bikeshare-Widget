# iOS-Bikeshare-Widget

### Nov 2021 SwiftUIJam Entry Note
- The widget of this app was created in the first jam entry this year.
- This entry is the supporting in-app functionality.

### Image Preview
<img src="https://user-images.githubusercontent.com/4282741/108644729-3ba06200-747e-11eb-9920-f6b40c7663f3.jpg" width="300">

### API
https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_information

### Instructions
1. `git clone` this repo and `checkout` `master`. We used Xcode 13.1 to build and run.<br>
2. Launch the `bikeshare-widget` scheme to the device<br>

Here's a ![demo](https://user-images.githubusercontent.com/4282741/140672454-4cf9e342-ddb3-49d5-83f4-6f9276439f7e.mp4) of how to use the app on device.

### Not working/needs fixing:
- Station list is emptied after selecting one station from the list.
- Unsure how denying location services on first launch of app/widget would be handled gracefully.
- Unsure how denying location services after first launch of app/widget would be handled gracefully.
- Unsure how app would behave if backgrounded and opened by widget.
- `MapKit` and overlays with directions doesn't seem to be supported yet on SwiftUI, which is why it had to be a `UIViewRepresentable` (limiting its' updates to `Binding` as opposed to `ObservedObject` or `EnvironmentObject`). Take a look at possible refactors after routes can be added through SwiftUI.
