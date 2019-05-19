// these are constants associated with tile placements and values
static final int[] tile_rows = {0, 1, 1, 2, 2, 2, 3, 3, 4, 4, 4, 5, 5, 6, 6, 6, 7, 7, 8};
static final int[] tile_cols = {2, 1, 3, 0, 2, 4, 1, 3, 0, 2, 4, 1, 3, 0, 2, 4, 1, 3, 2};
static final int[] vals = {2, 3, 3, 4, 4, 5, 5, 6, 6, 8, 8, 9, 9, 10, 10, 11, 11, 12};

// these are constants associated with vertex/link placements
static final int[] vertex_rows = {
	0, 0, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 4, 4, 4, 4,
	4, 4, 5, 5, 5, 5, 5, 5, 6, 6, 6, 6, 6, 6, 7, 7, 7, 7, 7, 7, 8, 8,
	8, 8, 8, 8, 9, 9, 9, 9, 10, 10};
static final int[] vertex_cols = {
	7, 9, 4, 6, 10, 12, 1, 3, 7, 9, 13, 15, 0, 4, 6, 10, 12, 16, 1, 3,
	7, 9, 13, 15, 0, 4, 6, 10, 12, 16, 1, 3, 7, 9, 13, 15, 0, 4, 6, 10,
	12, 16, 1, 3, 7, 9, 13, 15, 4, 6, 10, 12, 7, 9};

// these are constants associated with linking objects

class Board extends Container {

	float t_width;
	float t_offset;

	private ArrayList<Vertex> vertices;
	private ArrayList<Tile> tiles;
	private ArrayList<Link> links;

	Board(String id, float x, float y, float w) {
		super(id, x, y, w*1.1, w*1.116);
		t_width = w/4;
		t_offset = w*0.05;

		vertices = new ArrayList<Vertex>();
		tiles = new ArrayList<Tile>();
		links = new ArrayList<Link>();
		addVertices();
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
			float t_y = t_radius*0.5*tile_rows[i];
			float t_x = t_width*0.75*tile_cols[i];

			// create tile
			Resource r = resources.get(i);
			Tile t = new Tile("TILE_"+i, t_offset+t_x, t_y, t_width, r);
			if (r == Resource.DESERT) {
				float r_width = t_width*0.2;
				ROBBER = new Container("ROBBER", (t_width-r_width)*0.5, t_width*0.5-r_width, r_width, r_width*2);
				ROBBER.setImage(copyImage("robber"));
				t.addChild(ROBBER);
			} else {
				t.setValue(values.get(v_index));
				v_index++;
			}
			addChild(t);
			tiles.add(t);
		}
	}

	void clearTiles() {
		for (int i = children.size()-1; i >= 0; i--) {
			if (children.get(i) instanceof Tile)
				children.remove(i);
		}
	}

	void addVertices() {
		float col_inc = t_width/4;
		float row_inc = col_inc*(float)Math.sqrt(3);
		float row_offset = t_width*0.067;
		float v_width = t_width*0.15;
		for (int i = 0; i < 54; i++) {
			float c_x = t_offset+col_inc*vertex_cols[i];
			float c_y = row_offset+row_inc*vertex_rows[i];
			Vertex v = new Vertex("V_"+i, c_x-v_width/2, c_y-v_width*0.577, v_width, vertex_cols[i]%3 == 0 ? VertexType.RIGHT : VertexType.LEFT);
			addChild(v);
			vertices.add(v);

			v.setImage(pieceImage("settlement"));
		}
	}

	void addLinks() {

	}

}