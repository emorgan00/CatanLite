Benjamin Avrahami and Ethan Morgan's APCS2 Final Project

immediate to do list: (all of these are things we can do right now without needing other parts working to build off of)
  * (tricky) add PlayerSelectEvent, with parameter cancellable (for choosing who to rob and potentially who to trade with)
  * (medium) add CardArray object
  * (tricky) add ability to cancel build events, this should only be possible when setup == false

down the line to do list: (no big deal if we don't get to these)
  * (easy) add CollectResourceEvent, called from TurnEvent when dicesum != 7, with Player and Resource as parameters
  * (hard) add the ability to highlight and unhighlight objects, this will be a huge aesthetic improvement
  * (hard) add CardSelectEvent, with a CardArray as parameter

5/16/19:
  * Benjamin:
    * Managed to create generalized hexagon
    * Made tile hover when mouse is upon it
  * Ethan:
    * Created the CatanLite file to run everything from
    * Added GameObjects, Containers, and the viewport

5/17/19:
  * Benjamin:
    * Rotated tile so it would be vertically oriented
  * Ethan:
    * Replaced GameObject with Container
    * Containers now can contain images

5/18/19:
  * Ethan:
    * Added TileMarkers and the robber
    * Added the Board, created Tile generation
    * Added Links and Vertices
    * Created the Event handler

5/19/19:
  * Ethan:
    * Added Link/Vertex/Tile linking

5/20/19:
  * Benjamin:
    * Allowed for board to be inactive (disappear)
    * Created outline of Player
    * Made several Event methods
  * Ethan:
    * Added absolute positioning and resizing
    * Added the MoveRobberEvent

5/21/19:
  * Benjamin:
    * Placed events into queue
    * Filled out Player
    * Worked on the addObject Events
  * Ethan:
    * Added image caching
    * Added hovered item snapping

5/22/19:
  * Benjamin:
    * Restricted settlement/city/road placement
    * Adjusted snapping to location
  * Ethan:
    * Prevented snapping to invalid locations

5/23/19:
  * Benjamin:
    * Uploaded images of building costs, longest road, and largest army
    * Made pictures appear on left side of screen

5/24/19:
  * Benjamin:
    * Uploaded images of resource cards
    * Started die and rollDie
  * Ethan:
    * Started Cards

5/25/19:
  * Ethan:
    * Added MessageBox and MessageBoxEvent
    * Added AddPlayerEvent
    * Added PlayerMenuEvent

5/26/19:
  * Ethan:
    * Started TurnEvent
    * Added newGame