package nl.cwi.swat.quanda.data;


public class Variable extends Expression {
	
	private final String name;
	
	public Variable(String name) {
		this.name = name;
	}

	public void assign(int n, Object x) {
		update(n, x);
		setUpToDate(n);
		notifyDeps(n);
	}
	
	
	@Override
	protected Object compute(int n) {
		return getValue();
	}

	public Variable copy() {
		return new Variable(name);
	}

	public String getName() {
		return name;
	}
	
}
