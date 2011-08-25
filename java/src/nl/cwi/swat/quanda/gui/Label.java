package nl.cwi.swat.quanda.gui;

public class Label extends Node {

	private final String text;

	public Label(String text) {
		this.text = text;
	}
	
	@Override
	public void acceptRenderer(Renderer renderer) {
		renderer.render(this);
	}

}
