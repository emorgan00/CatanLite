HashMap<String, PImage> IMG;

static String[] hex_images = {
	"brick", "wool", "wood", "wheat", "ore", "desert"
};

static String[] card_images = {
	"brick_card", "wool_card", "wood_card", "wheat_card", "ore_card", "scratchy"
};

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
	IMG.get("water").mask(IMG.get("rot_hexmask"));
}

PImage getImage(String name, float w, float h) {
	int i_w = (int)w;
	int i_h = (int)h;
	String id = String.format("%s_%d_%d", name, i_w, i_h);
	if (!IMG.containsKey(id)) { // we need to do a resize
		if (!IMG.containsKey(name) && name.substring(0, 4).equals("rot_")) { // we need to do a rotation
			rotatedImage(name.substring(4));
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
	IMG.put("rot_"+name, out);
}