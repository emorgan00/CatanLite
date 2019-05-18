HashMap<String, PImage> IMG;

void loadImages() {

	// this should be called once in setup.
	File data = new File(dataPath(""));
	IMG = new HashMap<String, PImage>();

	for (File file : data.listFiles()) {
		String name = file.getName();
		IMG.put(name.substring(0, name.indexOf(".")), loadImage(name));
	}

}

PImage copyImage(String name) {
	return IMG.get(name).copy();
}

PImage hexImage(String name) {
	PImage out = copyImage(name);
	out.mask(IMG.get("hexmask"));
	return out;
}