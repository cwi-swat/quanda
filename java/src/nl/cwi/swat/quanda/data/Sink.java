package nl.cwi.swat.quanda.data;


public class Sink extends Flow {

	private Expression exp;

	public Sink(Expression exp) {
		this.exp = exp;
	}
	
	@Override
	protected void update(int n) {
		System.out.println(exp.getValue(n));
	}
	

}
