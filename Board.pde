import java.util.Collections;

// these are constants associated with tile placements and values
static final int[] rows = {0, 1, 1, 2, 2, 2, 3, 3, 4, 4, 4, 5, 5, 6, 6, 6, 7, 7, 8};
static final int[] cols = {2, 1, 3, 0, 2, 4, 1, 3, 0, 2, 4, 1, 3, 0, 2, 4, 1, 3, 2};
static final int[] vals = {2, 3, 3, 4, 4, 5, 5, 6, 6, 8, 8, 9, 9, 10, 10, 11, 11, 12};

class Board extends Container {

	Board(String id, float x, float y, float w) {
		super(id, x, y, w, w*1.116);
	}

	void generateTiles() {

		// resources to use
		ArrayList<Resource> resources = new ArrayList<Resource>();
		for (int i = 0; i < 4; i++) {
			if (i < 3) {
				resources.add(Resource.BRICK);
				resources.add(Resource.ORE);
			}
			resources.add(Resource.WOOD);
			resources.add(Resource.WOOL);
			resources.add(Resource.WHEAT);
		}
		resources.add(Resource.DESERT);
		
		// numbers to add to tiles
		ArrayList<Integer> values = new ArrayList<Integer>();
		for (int v : vals) values.add(v);
		
		// randomize tile positions and values
		Collections.shuffle(resources);
		Collections.shuffle(values);

		// determine size of tiles
		float t_width = w/4;
		float t_radius = t_width/2*(float)Math.sqrt(3);

		// adding the tiles
		int v_index = 0;
		for (int i = 0; i < 19; i++) {

			// determine position of each tile
			float t_y = t_radius*0.5*rows[i];
			float t_x = t_width*0.75*cols[i];

			// create tile
			Resource r = resources.get(i);
			Tile t = new Tile("TILE_"+i, t_x, t_y, t_width, r);
			if (r != Resource.DESERT) {
				t.setValue(values.get(v_index));
				v_index++;
			}
			addChild(t);
		}
	}

	void clearTiles() {
		for (int i = children.size(); i >= 0; i--) {
			if (children.get(i) instanceof Tile)
				children.remove(i);
		}
	}

}