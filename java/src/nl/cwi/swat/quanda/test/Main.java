package nl.cwi.swat.quanda.test;

import nl.cwi.swat.quanda.data.Add;
import nl.cwi.swat.quanda.data.Const;
import nl.cwi.swat.quanda.data.Variable;
import nl.cwi.swat.quanda.gui.Input;

public class Main {
	
	public static void main(String[] args) {
		Const t = new Const(true);
		Variable x = new Variable("x");
		Variable y = new Variable("y");
		Input i1 = new Input(x, t);
		Input i2 = new Input(y, t);
		Add a = new Add(x, y);
		int n = 1;
		x.bind(n, 1);
		y.bind(n, 2);
		x.notify(n);
		y.notify(n);
		System.out.println(a.getValue(n));
	}

}
