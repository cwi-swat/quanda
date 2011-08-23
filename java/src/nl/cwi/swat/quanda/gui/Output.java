package nl.cwi.swat.quanda.gui;

import nl.cwi.swat.quanda.data.Expression;
import nl.cwi.swat.quanda.data.Notifiable;

public class Output extends Node implements Notifiable {

	private Expression exp;
	
	@Override
	public void notify(int n) {
		System.out.println(exp.getValue(n));
	}

}
