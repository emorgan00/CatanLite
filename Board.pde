// these are constants associated with tile placements and values
static final int[] tile_rows = {0, 1, 1, 2, 2, 2, 3, 3, 4, 4, 4, 5, 5, 6, 6, 6, 7, 7, 8};
static final int[] tile_cols = {2, 1, 3, 0, 2, 4, 1, 3, 0, 2, 4, 1, 3, 0, 2, 4, 1, 3, 2};
static final int[] vals = {2, 3, 3, 4, 4, 5, 5, 6, 6, 8, 8, 9, 9, 10, 10, 11, 11, 12};

// these are constants associated with vertex/link placements
static final int[] vertex_rows = {
	0, 0, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 4, 4, 4, 4,
	4, 4, 5, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6, 6, 7, 7, 7, 7, 7, 7, 8, 8,
	8, 8, 8, 8, 9, 9, 9, 9, 10, 10
};
static final int[] vertex_cols = {
	7, 9, 4, 6, 10, 12, 1, 3, 7, 9, 13, 15, 0, 4, 6, 10, 12, 16, 1, 3,
	7, 9, 13, 15, 0, 4, 6, 10, 12, 16, 1, 3, 7, 9, 13, 15, 0, 4, 6, 10,
	12, 16, 1, 3, 7, 9, 13, 15, 4, 6, 10, 12, 7, 9
};

// these are constants associated with linking objects
static final int[][] vertex_links = {
	{1, 3}, {4}, {7, 3}, {8}, {9, 5}, {10}, {12, 7}, {13}, {14, 9}, {15}, {16, 11}, {17},
	{18}, {19, 14}, {20}, {21, 16}, {22}, {23}, {24, 19}, {25}, {26, 21}, {27}, {28, 23}, {29},
	{30}, {31, 26}, {32}, {33, 28}, {34}, {35}, {36, 31}, {37}, {38, 33}, {39}, {40, 35}, {41},
	{42}, {43, 38}, {44}, {45, 40}, {46}, {47}, {43}, {48}, {49, 45}, {50}, {51, 47}, {},
	{49}, {52}, {53, 51}, {}, {53}, {}
};
// note: we only include the left half of the tile, the right half is just left +1
static final int[][] tile_links = {
	{0, 3, 8}, {2, 7, 13}, {4, 9, 15}, {6, 12, 18}, {8, 14, 20}, {10, 16, 22}, {13, 19, 25},
	{15, 21, 27}, {18, 24, 30}, {20, 26, 32}, {22, 28, 34}, {25, 31, 37}, {27, 33, 39},
	{30, 36, 42}, {32, 38, 44}, {34, 40, 46}, {37, 43, 49}, {39, 45, 51}, {44, 49, 52}
};

class Board extends Container {

	float t_width;

	private ArrayList<Vertex> vertices;
	private ArrayList<Tile> tiles;
	private ArrayList<Link> links;

	Board(String id, float x, float y, float w) {
		super(id, x, y, w, w*1.03923);
		t_width = w/5;

		vertices = new ArrayList<Vertex>();
		tiles = new ArrayList<Tile>();
		links = new ArrayList<Link>();
		addVertices();
		addLinks();
		setImage(IMG.get("board"));
	}

	// special ordering of drawing
	void display(float x, float y) {
		draw(x, y);
		for (Container child : tiles) {
			child.display(x+this.x, y+this.y);
		}
		for (Container child : links) {
			child.display(x+this.x, y+this.y);
		}
		for (Container child : vertices) {
			child.display(x+this.x, y+this.y);
		}
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
		float t_radius = t_width/2*(float)Math.sqrt(3);

		// adding the tiles
		int v_index = 0;
		for (int i = 0; i < 19; i++) {

			// determine position of each tile
			float t_y = t_radius*0.5*(tile_rows[i]+1);
			float t_x = t_width*0.75*(tile_cols[i]+0.6667);

			// create tile
			Resource r = resources.get(i);
			Tile t = new Tile("TILE_"+i, t_x, t_y, t_width, r);
			if (r == Resource.DESERT) {
				float r_width = t_width*0.15;
				ROBBER = new Container("ROBBER", (t_width-r_width)*0.5, t_width*0.5-r_width, r_width, r_width*2);
				ROBBER.setImage(copyImage("robber"));
				t.addChild(ROBBER);
			} else {
				t.setValue(values.get(v_index));
				v_index++;
			}
			addChild(t);
			tiles.add(t);

			// link tile to nearby vertices
			for (int j : tile_links[i]) {
				Vertex v = vertices.get(j);
				v.tiles.add(t);
				t.vertices.add(v);
				v = vertices.get(j+1);
				v.tiles.add(t);
				t.vertices.add(v);
			}
		}
	}

	void clearTiles() {
		for (int i = children.size()-1; i >= 0; i--) {
			if (children.get(i) instanceof Tile)
				children.remove(i);
		}
		tiles.clear();
		for (Vertex v : vertices) v.tiles.clear();
	}

	void addVertices() {
		float col_inc = t_width/4;
		float row_inc = col_inc*(float)Math.sqrt(3);
		float v_width = t_width*0.15;
		float row_offset = t_width*0.067;
		for (int i = 0; i < 54; i++) {
			float c_x = col_inc*(vertex_cols[i]+2);
			float c_y = row_offset+row_inc*(vertex_rows[i]+1);
			Vertex v = new Vertex("V_"+i, c_x-v_width/2, c_y-v_width*0.577, v_width);
			addChild(v);
			vertices.add(v);
		}
	}

	void addLinks() {
		float x_offset = t_width*0.075;
		float y_offset = x_offset*1.154;
		for (int i = 0; i < 54; i++) {
			Vertex current = vertices.get(i);
			for (int j : vertex_links[i]) {
				Vertex other = vertices.get(j);
				// establish link between current & other
				Link l = new Link("L_"+i+"_"+j, current.x+x_offset, current.y+y_offset, other.x+x_offset, other.y+y_offset);
				l.vertices.add(current);
				l.vertices.add(other);
				current.links.add(l);
				other.links.add(l);
				addChild(l);
				links.add(l);
			}
		}
	}
}