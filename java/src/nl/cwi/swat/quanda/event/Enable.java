package nl.cwi.swat.quanda.event;

public class Enable extends Event {
	private final boolean value;
	private final String name;
	
	public Enable(String name, boolean enable) {
		this.name = name;
		this.value = enable;
	}
	
	@Override
	public String toString() {
		return "enable(" + value + ")";
	}
	
	public boolean getValue() {
		return value;
	}

	public String getName() {
		return name;
	}
	
}
