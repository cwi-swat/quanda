package nl.cwi.swat.quanda.data;

public class Const extends Expression {

	public Const(Object value) {
		setValue(value);
	}
	
	@Override
	public void notify(int n) {
		setUpToDate(n);
	}
	
	@Override
	protected Object compute(int n) {
		return getValue(n);
	}
	
	

}
