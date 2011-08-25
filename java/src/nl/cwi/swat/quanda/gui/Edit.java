package nl.cwi.swat.quanda.gui;

import nl.cwi.swat.quanda.event.Enable;
import nl.cwi.swat.quanda.event.Event;

public class Edit extends Node {
	
	private boolean enabled = false;
	private final String name;
	
	public Edit(String name) {
		this.name = name;
	}

	public void acceptEvent(Event event) {
		// TODO: double dispatch
		if (event instanceof Enable) {
			Enable en = (Enable)event;
			if (name.equals(en.getName())) {
				setEnabled(en.getValue());
			}
		}
	}

	private void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}

	public boolean getEnabled() {
		return enabled;
	}
	
	@Override
	public void acceptRenderer(Renderer renderer) {
		renderer.render(this);
	}
	
}
