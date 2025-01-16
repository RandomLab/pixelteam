
Color[] loadBank(String filename) {
	String[] lines = loadStrings(filename);
	Color[] colors = new Color[lines.length];
	
	for (int i = 0; i < lines.length; i++) {
		String line = lines[i];
		String[] parts = split(line, ','); // Diviser la ligne en parties
		if (parts.length == 4) {
			String name = parts[0];          // Nom de la couleur
			int r = int(parts[1]);           // Composante rouge
			int g = int(parts[2]);           // Composante verte
			int b = int(parts[3]);           // Composante bleue
			
			// Stocker la couleur dans le tableau
			colors[i] = new Color(name, color(r, g, b));
		}
	}
	return colors;
}

class Color {
	String name;
	int value;
	
	Color(String name, int value) {
		this.name = name;
		this.value = value;
	}
}