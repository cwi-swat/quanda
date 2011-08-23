package nl.cwi.swat.quanda.ctl;

import nl.cwi.swat.quanda.data.Expression;
import nl.cwi.swat.quanda.data.Node;


public class Repeat extends Node {
	
	private final Expression count;
	
	public Repeat(Expression count) {
		this.count = count;
	}

	@Override
	protected void update(int n) {
		Object c = count.getValue(n);
		if (c != null) {
			readjust((Integer)c);
		}
	}

	private void readjust(int size) {
		// TODO Auto-generated method stub
		
	}
	
	
}
