# iOS-Bikeshare-Widget

### Design Document
https://docs.google.com/document/d/1fFUbVZTqyzEapmKPTILehrKUpdssHOdbVpHc9oh15KA/edit

### Image Preview
<img src="https://user-images.githubusercontent.com/4282741/108644729-3ba06200-747e-11eb-9920-f6b40c7663f3.jpg" width="300">

### API
https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_information

### Instructions
1. `git clone` this repo and `checkout` `master`. We used Xcode 12.4 to build this app.
2. Launch the `bikeshare-widget` scheme to the simulator/device
3. Allow the app to run until you see the "Allow While Using App" for Location Permissions in App. Click it.
<img src="https://user-images.githubusercontent.com/4282741/108654603-05231100-7497-11eb-9c3d-2dbaebdd2017.png" width="300">
  Note: This may take several minutes to appear, please be patient.
4. With permissions allowed, terminate the app.
5. Go to the widget editor by holding down the Home Screen.
6. Hit the Plus button to add a Widget and scroll to "bikeshare-widget"
<img src="https://user-images.githubusercontent.com/4282741/108654797-6e0a8900-7497-11eb-9dbd-b19996ad85d4.png" width="300">
7. Click on the "bikeshare-widget" and "Add Widget"
 <img src="https://user-images.githubusercontent.com/4282741/108654870-90040b80-7497-11eb-83c8-b990a8285d5f.png" width="300">
8. Click Done to place the widget on the screen.
9. At some point between steps 5 and 8 you will see a Widget Location Permissions dialog (Allow/Don't Allow). Please allow it so the widget can update its layout with your position.
10. For several minutes you might see a blank layout, this is because the system controls when it shows both the popup above and when it does the layout update for the widget.
11. The final result should show you your location and the three (or less) closest bikeshare locations to you (within 500 m). It might also show more on the map all within a 500 m range.
<img src="https://user-images.githubusercontent.com/4282741/108659282-b1b1c280-7498-11eb-8fcd-63592ef3d627.jpeg" width="300">
