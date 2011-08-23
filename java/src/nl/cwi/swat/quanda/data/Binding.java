package nl.cwi.swat.quanda.data;

public abstract class Binding extends Expression {

	private String name;
	
	public Binding(String name) {
		this.name = name;
	}
	
	public String getName() {
		return name;
	}
	
}
