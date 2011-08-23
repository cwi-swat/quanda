package nl.cwi.swat.quanda.data;

public class Seq extends Expression {

	private Expression lhs;
	private Expression rhs;

	public Seq(Expression lhs, Expression rhs) {
		this.lhs = lhs;
		this.rhs = rhs;
		rhs.addDependent(this);
	}
	
	@Override
	protected Object compute(int n) {
		return rhs.getValue(n);
	}

	
}
