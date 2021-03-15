# GUI-for-multi-party-auctioning
### Background 
The matching between demand and supply of components and materials across multiple sectorsis essential for the circular economy, to facilitate re-use and re-manufacturing of products and material. To make such matchmaking efficient, such matchmaking requires digitalized negotiation support, traceability of transactions and contracts definition functionalities. Suppliers of post-use components and materials needthe possibility to offer their products and give the relevant information. Moreover, post-use material managers, including re-manufacturers and material re-processors, and re-users need the possibility to publish their capabilities and requirements or bid on their preferred products and materials. Matchmaking further demands a multi-party auction mechanismto achieve a market equilibrium between suppliers and demanders. Previous work includes automated contractual interactions and negotiations, but only in between pairs of stakeholders (not multi-party with three or more stakeholders). Multi-party contractual interactions, negotiations and auctioning are now being addressed by EISLAB at LTU.  

### Installation

1. Clone the repository with command: `git clone https://github.com/casperlundberg/GUI-for-multi-party-auctioning`.

1. [Download flutter](https://flutter.dev/docs/get-started/install), the Dart SDK is included in the newer versions of Flutter.
   1. The dev team highly recommend to follow the *get-started* tutorial linked above as it shows how to install neccessary plugins and more for the recommended editors.

1. **[Optional]** Install an editor with built-in plugins for Flutter and Dart development and syntax handling, see https://dart.dev/tools.
   1. There is open-source versions of plugins for other editors such as [Sublime Text](https://www.sublimetext.com/) but we didn't manage to make them work.

1. **[Optional]** Install [Chrome](https://www.google.com/chrome/).

1. Inside the `GUI` folder run command: `flutter run -d chrome` and the project will run in a new Chrome window(other browsers should work aswell if one have the plugins for them).
   1. One common error when trying to run for first time inside editors such as [VScode](https://code.visualstudio.com/) might be that the editor can't find Chrome(or any other web browser). Please run `flutter doctor -v` and see if there is anything that causes Flutter to fail. If you are on Windows the failure might be because the system variable path for flutter executable is wrong/missing.

### Open issue 
Assuming that solutions for multi-party contractual interactions, negotiations and auctioning will be developed, how should such mechanisms be visualized in a GUI and be connected to data and information sharing for the circular economy? 

### Objective 
Demonstrate how GUI and data/information sharing for multi-party contractual interactions, negotiations and auctioning. 

### Approach 
Explore the Dart language and develop a how GUI and data/information sharing system that can be used with a mechanism for multi-party contractual interactions, negotiations and auctioning. Make a mock-implementation of the mechanism for multi-party auctioning to facilitate the demonstration. 

### Current status
The current GUI has no connection with the API whatsoever but there is a file containing examples of API responses that is used to simulate an API and database in order to test the GUI. Another good point is that the GUI is not fully responsive and also have some manually overwritten parts of its theme and therefore just changing values in the theme will not update the entire GUI, more on this will be discussed in the TODO below.

### TODO
1. Add API-calls and uses of websockets(Dart stream), this fits best to be added inside the respective entity for each API-call. After this, one can remove the JSONUtilities file as it is just a fake database which represents examples of API responses.
   1. When implementing the REST-API to the GUI, it is important to remember the connection between the GUIs bidding system and it's interaction with the **behavioral engine** in the API.
1. Fix the notification system, at this very moment the notification system is quite buggy and it is broken i a few ways. However, the graphics is working as they should, its just the functionality and (in the future) connection with the API that is broken/missing.
1. Design a search bar, there is one in v1.0 but it is very buggy and holds no functionality(i.e. if one searches for something it wont change the auctionlist like the filters do). The search bar will provide further filtering so users can even easier find the auction that they're looking for.
1.  As this GUI is in pre-aplha(of some sort), the website is not fully responsive. In order to make the GUI ready for actual use, a responsive design is a must. Furthermore, Flutter have good compatibility with a lot of different devices and operating systems which means that the more responsive the GUI gets, the easier it will be to adapt it to new devices. 
1. The last thing that should be on the list according to the dev team is the freedom for users to choose or even create design themes. Dart have this incredibly strong design system that utilizes *themedata* files. Similar to CSS in how they work but very different in syntax and execution. 
   1. Firstly, there is some instances where the themdata is manually overwritten in the `.dart` files. Mostly when is comes to coloring, to solve this, one just go through the files one by one and add `final ThemeData themeData = Theme.of(context);` on the first line of the build method which then can be used to access the themedata loaded into `main.dart`.
   1. It is very easy to create a few themes and just add a drop-down in the user page where the user can choose a theme which then just will be a id-number on the database so the GUI knows which theme to load once a user login. 
   1. The problem with giving user the ability to create their own themes by choosing color, font-size, etc is that it would require to save the themedata file in the database which would consume a lot of unnecessary disk space.

#### Summarized TODO
- [ ] Implement API
- [ ] Fix notification system
- [ ] Design search bar
- [ ] Make the GUI responsible
- [ ] Make 3-5 design themes for users to choose from
- [ ] **[Optional]** Make a tool for users to create their own themes 
 
### Project managers 
- Shai Fernandez shai.fernandez@ltu.se
- Eric Chiquito eric.chiquito@ltu.se
- Ulf Bodin ulf.bodin@ltu.se

### Devs for the GUI
- Erik Salomonsson erisal-8@student.ltu.se
- Gustav Curan guscur-8@student.ltu.se
- Elliot Huber ellhub-8@student.ltu.se
- Casper Lundberg caslun-8@student.ltu.se

<p align="center">
  :yellow_heart:	:yellow_heart:	:yellow_heart:	:yellow_heart:
</p>

