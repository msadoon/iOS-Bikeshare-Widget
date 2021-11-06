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
2. Launch the `bikeshare-widget` scheme to the simulator/device<br>
3. Allow the app to run until you see the "Allow While Using App" for Location Permissions in App. Click it.
<img src="https://user-images.githubusercontent.com/4282741/108654603-05231100-7497-11eb-9c3d-2dbaebdd2017.png" width="300">
  Note: This may take several minutes to appear, please be patient.<br>
4. With permissions allowed, terminate the app.<br>
5. Go to the widget editor by holding down the Home Screen.<br>
6. Hit the Plus button to add a Widget and scroll to "bikeshare-widget"
<img src="https://user-images.githubusercontent.com/4282741/108654797-6e0a8900-7497-11eb-9dbd-b19996ad85d4.png" width="300"><br>
7. Click on the "bikeshare-widget" and "Add Widget"
 <img src="https://user-images.githubusercontent.com/4282741/108654870-90040b80-7497-11eb-83c8-b990a8285d5f.png" width="300"><br>
8. Click Done to place the widget on the screen.<br>
9. At some point between steps 5 and 8 you will see a Widget Location Permissions dialog (Allow/Don't Allow). Please allow it so the widget can update its layout with your position.<br>
10. The widget should show you your location and the closest bikeshare locations to you (within 500 m).
<img src="https://user-images.githubusercontent.com/4282741/108659282-b1b1c280-7498-11eb-8fcd-63592ef3d627.jpeg" width="300">
