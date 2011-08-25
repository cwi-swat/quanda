package nl.cwi.swat.quanda.data;


public class Variable extends Binding {
	public Variable(String name) {
		super(name);
	}
	
	@Override
	public void notify(int n) {
		// bind has been called before.
		setUpToDate(n);
		notifyDependents(n);
	}

	public void bind(int n, Object x) {
		Object v = getValue();
		if (x == v || (x != null && x.equals(v))) {
			return;
		}
		update(n, x);
	}
	
	@Override
	protected Object compute(int n) {
		return getValue(n);
	}

}
