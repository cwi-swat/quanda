package nl.cwi.swat.quanda.eval;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.Stack;

import javax.swing.JButton;
import javax.swing.JCheckBox;
import javax.swing.JComponent;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JTextField;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Unmarshaller;

import net.miginfocom.swing.MigLayout;
import nl.cwi.swat.quanda.model.Goto;
import nl.cwi.swat.quanda.model.Question;
import nl.cwi.swat.quanda.model.Questionnaire;
import nl.cwi.swat.quanda.model.State;
import nl.cwi.swat.quanda.model.Transition;

import org.mozilla.javascript.Context;
import org.mozilla.javascript.EcmaError;
import org.mozilla.javascript.Scriptable;
import org.mozilla.javascript.ScriptableObject;

public class Eval {
	private final Questionnaire questionnaire;
	private final JFrame frame; 

	private Map<String, Object> env;
	private Stack<State> trail;
	
	public static void main(String[] args) throws FileNotFoundException, JAXBException {
		new Eval(load(new File("resources/example.xml")));
	}

	private static Questionnaire load(File file) throws JAXBException, FileNotFoundException {
		String packageName = Questionnaire.class.getPackage().getName();
		JAXBContext jc = JAXBContext.newInstance(packageName);
		Unmarshaller u = jc.createUnmarshaller();
		FileReader f = new FileReader(file);
		return (Questionnaire)u.unmarshal(f);
	}
	
	public Eval(Questionnaire questionnaire) {
		this.questionnaire = questionnaire;
		this.trail = new Stack<State>();
		goTo(questionnaire.getInitial());
		this.env = new HashMap<String, Object>();
		this.frame = makeFrame(getCurrent());
		frame.setVisible(true);
	}
	
	public void handle(Map<JComponent, Question> fieldMap, Question q, Object a) {
		env.put(q.getVariable(), a);
		for (Transition t: getCurrent().getTransitions()) {
			if (t.getAnswered().equals(q)) {
				for (Goto g: t.getGotos()) {
					boolean b = true;
					for (Question c: g.getGuards()) {
						b &= eval(c);
					}
					if (b) {
						System.out.println("Moving from " + getCurrent() + " to " + g.getTarget());
						goTo(g.getTarget());
						update(fieldMap, getCurrent());
						return;
					}
				}
			}
		}
	}
	
	
	private void goTo(State s) {
		trail.push(s);
	}
	
	private State getCurrent() {
		return trail.peek();
	}
	
	private State goBack() {
		if (trail.size() > 1) {
			trail.pop();
		}
		return getCurrent();
	}
	
	private boolean eval(Question q) {
		Context ctx = Context.enter();
		try {
			Scriptable scope = ctx.initStandardObjects();
			for (String name: env.keySet()) {
				ScriptableObject.defineProperty(scope, name, env.get(name), 0);
			}
			Object result = ctx.evaluateString(scope, q.getCondition(), q.getId(), 1, null);
			if (result == null) {
				return false;
			}
			else if (result.equals(true)) {
				return true;
			}
			return false;
		}
		finally {
			Context.exit();
		}
	}
	
	public void update(Map<JComponent, Question> fieldMap, State s) {
		
		// This is terribly ugly, but it works.
		Set<Question> reachableAnswers = new HashSet<Question>();
		List<State> todo = new ArrayList<State>();
		todo.add(s);
		
		while (!todo.isEmpty()) {
			State cur = todo.remove(0);
			for (Transition t: cur.getTransitions()) {
				try {
					if (eval(t.getAnswered())) {
						reachableAnswers.add(t.getAnswered());
						for (Goto g: t.getGotos()) {
							if (!todo.contains(g.getTarget())) {
								todo.add(g.getTarget());
							}
						}
					}
				}
				catch (EcmaError e) {
					continue;
				}
			}
		}
		
		System.out.println("Reachable: " + reachableAnswers);
		
		
		for (JComponent c: fieldMap.keySet()) {
			Question q = fieldMap.get(c);
			if (!s.getEnabled().contains(q) && !s.getAnswered().contains(q)) {
				c.setEnabled(false);
				if (!reachableAnswers.contains(q)) {
					((JTextField)c).setText("");
					env.remove(q.getVariable());
				}
			}
			if (s.getAnswered().contains(q)) {
//				if (env.containsKey(q.getVariable())) {
//					((JTextField)c).setText((String) env.get(q.getVariable()));
//				}
				c.setEnabled(false);
			}
			if (s.getEnabled().contains(q)) {
//				if (env.containsKey(q.getVariable())) {
//					((JTextField)c).setText((String) env.get(q.getVariable()));
//				}
				c.setEnabled(true);
			}
		}
	}
	
	public State findLastEdit(Question q) {
		for (int i = trail.size() - 1; i >= 0; i--) {
			State s = trail.elementAt(i);
			if (s.getEnabled().contains(q)) {
				return s;
			}
		}
		return null;
	}
	
	public JFrame makeFrame(State init) {
		final Map<JComponent, Question> fieldMap = new HashMap<JComponent, Question>();
		JFrame frame = new JFrame("Quanda");
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		JPanel panel = (JPanel) frame.getContentPane();
		panel.setLayout(new MigLayout());
		for (final Question q: questionnaire.getQuestions()) {
			panel.add(new JLabel(q.getLabel()));
			JTextField f = new JTextField(20);
			panel.add(f);
			JButton b = new JButton("Revise");
			b.addActionListener(new ActionListener() {
				@Override
				public void actionPerformed(ActionEvent e) {
					State s = findLastEdit(q);
					if (s != null) {
						goTo(s);
						update(fieldMap, s);
					}
				}
			});
			panel.add(b, "wrap");
			fieldMap.put(f, q);
		}
		
		JButton back = new JButton("Back");
		back.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent arg0) {
				State s = goBack();
				update(fieldMap, s);
			}
		});
		panel.add(back);

		JButton button = new JButton("Next");
		button.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent e) {
				for (JComponent c: fieldMap.keySet()) {
					if (c.isEnabled()) {
						if (c instanceof JTextField) {
							String txt = ((JTextField)c).getText();
							// empty string means undefined
							if (!txt.equals("")) { 
								handle(fieldMap, fieldMap.get(c), txt);
							}
						}
					}
				}
			}
		});
		panel.add(button);
		
		frame.pack();
		update(fieldMap, init);
		return frame;
	}
	
}
