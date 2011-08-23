package nl.cwi.swat.quanda.data;

public class Binder extends Expression {

	private Expression exp;
	private String name;

	public Binder(String name, Expression exp) {
		this.name = name;
		this.exp = exp;
		exp.addDependent(this);
	}
	
	@Override
	protected Object compute(int n) {
		return exp.getValue(n);
	}

	public String getName() {
		return name;
	}
	
}
