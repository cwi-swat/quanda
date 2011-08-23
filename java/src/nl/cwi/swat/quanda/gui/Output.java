package nl.cwi.swat.quanda.gui;

import nl.cwi.swat.quanda.data.Expression;
import nl.cwi.swat.quanda.data.Notifiable;

public class Output extends Notifiable {

	private Expression exp;

	public Output(Expression exp) {
		this.exp = exp;
	}
	
	@Override
	protected void update(int n) {
		System.out.println(exp.getValue(n));
	}
	

}
