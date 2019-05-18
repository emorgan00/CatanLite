import java.util.Collections;

class Board extends Container {

	Board(String id, float x, float y, float w) {
		super(id, x, y, w, w);
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
		int[] vals = {2, 3, 3, 4, 4, 5, 5, 6, 6, 8, 8, 9, 9, 10, 10, 11, 11, 12};
		ArrayList<Integer> values = new ArrayList<Integer>();
		for (int v : vals) values.add(v);
		// randomize tile positions and values
		Collections.shuffle(resources);
		Collections.shuffle(values);

		int v_index = 0;
		for (int i = 0; i < 19; i++) {
			Resource r = resources.get(i);
			Tile t = new Tile("TILE_"+i, (float)Math.random()*w, (float)Math.random()*h, 200, r);
			addChild(t);
			if (r != Resource.DESERT) {
				t.setValue(values.get(v_index));
				v_index++;
			}
		}
	}

	void clearTiles() {
		for (int i = children.size(); i >= 0; i--) {
			if (children.get(i) instanceof Tile)
				children.remove(i);
		}
	}

}