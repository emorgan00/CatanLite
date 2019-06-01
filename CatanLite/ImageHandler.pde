HashMap<String, PImage> IMG;

static String[] hex_images = {
	"brick", "wool", "wood", "wheat", "ore", "desert"
};

static String[] card_images = {
	"brick_card", "wool_card", "wood_card", "wheat_card", "ore_card", "scratchy"
};

static final int HOFFSET = 5;

void loadImages() { // this should be called once in setup.
	File data = new File(dataPath(""));
	IMG = new HashMap<String, PImage>();
	for (File file : data.listFiles()) {
		String name = file.getName();
		IMG.put(name.substring(0, name.indexOf(".")), loadImage(name));
	}
	for (String s : hex_images) hexImage(s);
	for (String s : card_images) cardImage(s);
	// cropping board background
	rotatedImage("hexmask");
	IMG.get("water").mask(IMG.get("rotated_hexmask"));
}

PImage getImage(String name, float w, float h) {
	int i_w = (int)w;
	int i_h = (int)h;
	String id = String.format("%s_%d_%d", name, i_w, i_h);
	if (!IMG.containsKey(id)) { // we need to do a resize
		if (!IMG.containsKey(name) && name.substring(0, 8).equals("rotated_")) { // we need to do a rotation
			rotatedImage(name.substring(8));
		}
		if (!IMG.containsKey(name) && name.substring(0, 12).equals("highlighted_")) { // we need to do a rotation
			highlightedImage(name.substring(12));
		}
		PImage resize = IMG.get(name).copy();
		resize.resize(i_w, i_h);
		IMG.put(id, resize);
	}
	return IMG.get(id);
}

void hexImage(String name) {
	PImage out = IMG.get(name).copy();
	out.blend(IMG.get("hexborder"), 0, 0, 1000, 1000, 0, 0, 1000, 1000, BLEND);
	out.mask(IMG.get("hexmask"));
	IMG.put("hex_"+name, out);
}

void cardImage(String name) {
	PImage out = IMG.get("cardborder").copy();
	out.blend(IMG.get(name), 0, 0, 161, 238, 10, 10, 141, 218, BLEND);
	IMG.put(name, out);
}

void rotatedImage(String name) {
	PImage in = IMG.get(name);
	in.loadPixels();
	PImage out = createImage(in.height, in.width, ARGB);
	out.loadPixels();
	for (int x = 0; x < in.width; x++) {
		for (int y = 0; y < in.height; y++) {
			out.set(y, x, in.get(x, y));
		}
	}
	out.updatePixels();
	IMG.put("rotated_"+name, out);
}

static final int[][] neighbors = {{1, 0}, {0, 1}, {-1, 0}, {0, -1}};

class Pair {int x, y; Pair(int x, int y) {this.x = x; this.y = y;} }

void highlightedImage(String name) {
	PImage in = IMG.get(name);
	PImage out = createImage(in.width+HOFFSET*2, in.height+HOFFSET*2, ARGB);
	out.copy(in, 0, 0, in.width, in.height, HOFFSET, HOFFSET, in.width, in.height);
	out.loadPixels();
	int white = color(255, 255, 255, 255);
	ArrayList<Pair> buffer = new ArrayList<Pair>();
	for (int i = 0; i < HOFFSET; i++) {
		buffer.clear();
		for (int x = 0; x < out.width; x++) {
			for (int y = 0; y < out.height; y++) {
				if (alpha(out.get(x, y)) != 0) {
					for (int[] n : neighbors) {
						if (alpha(out.get(x+n[0], y+n[1])) == 0) {
							buffer.add(new Pair(x+n[0], y+n[1]));
						}
					}
				}
			}
		}
		for (Pair p : buffer) out.set(p.x, p.y, white);
	}
	out.updatePixels();
	IMG.put("highlighted_"+name, out);
}