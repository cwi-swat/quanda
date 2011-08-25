package nl.cwi.swat.quanda.event;


public class Update extends Event {

	private final String name;
	private final Object value;

	public Update(String name, Object value) {
		this.name = name;
		this.value = value;
	}

	public String getName() {
		return name;
	}

	public Object getValue() {
		return value;
	}
	
	@Override
	public String toString() {
		return "update(" + name + ", " + value + ")";
	}
	
	
	
}
