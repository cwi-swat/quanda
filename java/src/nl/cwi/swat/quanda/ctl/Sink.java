package nl.cwi.swat.quanda.ctl;

import nl.cwi.swat.quanda.data.Expression;
import nl.cwi.swat.quanda.data.Node;


public class Sink extends Node {

	private Expression exp;

	public Sink(Expression exp) {
		this.exp = exp;
	}
	
	@Override
	protected void update(int n) {
		System.out.println(exp.getValue(n));
	}
	

}
