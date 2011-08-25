package nl.cwi.swat.quanda.test;

import java.util.ArrayList;
import java.util.List;

import nl.cwi.swat.quanda.data.Add;
import nl.cwi.swat.quanda.data.Const;
import nl.cwi.swat.quanda.data.Input;
import nl.cwi.swat.quanda.data.Output;
import nl.cwi.swat.quanda.data.Variable;
import nl.cwi.swat.quanda.event.Event;

public class Main {
	
	public static void main(String[] args) {
		Const t = new Const(true);
		Variable x = new Variable("x");
		Variable y = new Variable("y");
		Input i1 = new Input(x, t);
		Input i2 = new Input(y, t);
		Add a = new Add(x, y);
		Output o1 = new Output(a);
		
		int n = 1;
		List<Event> changes = new ArrayList<Event>();
		x.bind(n, 1);
		y.bind(n, 2);
		x.notify(n, changes);
		y.notify(n, changes);
		System.out.println(a.getValue(n, changes));
		System.out.println(changes);
	}

}
