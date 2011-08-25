package nl.cwi.swat.quanda.event;

import nl.cwi.swat.quanda.data.Output;

public class Update extends Event {

	private final Output output;
	private final Object value;

	public Update(Output output, Object value) {
		this.output = output;
		this.value = value;
	}
	
}
