package nl.cwi.swat.quanda.data;


public class Variable extends Expression {
	
	private final String name;
	
	public Variable(String name) {
		this.name = name;
	}

	public void bind(int n, Object x) {
		if (x == getValue()) {
			setUpToDate(n);
			return;
		}
		if (x != null && x.equals(x)) {
			setUpToDate(n);
			return;
		}
		update(n, x);
		setUpToDate(n);
		notifyDependents(n);
	}
	
	
	@Override
	protected Object compute(int n) {
		return getValue(n);
	}

	public Variable copy() {
		return new Variable(name);
	}

	public String getName() {
		return name;
	}
	
}
