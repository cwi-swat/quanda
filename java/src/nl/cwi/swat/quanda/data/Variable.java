package nl.cwi.swat.quanda.data;


public class Variable extends Binding {
	public Variable(String name) {
		super(name);
	}

	public void bind(int n, Object x) {
		Object value = getValue();
		if (x == value || (x != null && x.equals(value))) {
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

}
