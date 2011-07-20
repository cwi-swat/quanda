package nl.cwi.swat.quanda.eval;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Stack;

import javax.swing.JButton;
import javax.swing.JComponent;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JTextField;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Unmarshaller;

import net.miginfocom.swing.MigLayout;
import nl.cwi.swat.quanda.model.Question;
import nl.cwi.swat.quanda.model.Questionnaire;

import org.mozilla.javascript.Context;
import org.mozilla.javascript.EcmaError;
import org.mozilla.javascript.Scriptable;

public class Eval {
	private final Questionnaire questionnaire;
	private final JFrame frame; 

	private Env env;
	private Stack<State> trail;
	private List<Question> enabled;
	private List<Question> answered;
	
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
		this.enabled = new ArrayList<Question>(questionnaire.getInitial());
		this.answered = new ArrayList<Question>();
		this.env = new Env();
		this.frame = makeFrame();
		frame.setVisible(true);
	}
	
	public void handle(Map<JComponent, Question> fieldMap, Question q, Object a) {
		env.put(q.getVariable(), a);
		disable(q);
		for (Question nextq: q.getNext()) {
			if (eval(nextq)) {
				enable(nextq);
			}
		}
		update(fieldMap);
	}
	
	
	private void enable(Question q) {	
		this.enabled.add(q);
	}
	
	private void disable(Question q) {
		enabled.remove(q);
		answered.add(q);
	}

	private boolean eval(Question q) {
		Context ctx = Context.enter();
		try {
			Scriptable scope = ctx.initStandardObjects();
			env.define(scope);
			try {
				Object result = ctx.evaluateString(scope, q.getCondition(), q.getId(), 1, null);
				return result == null ? false : result.equals(true);
			}
			catch (EcmaError e) {
				return false;
			}
		}
		finally {
			Context.exit();
		}
	}
	
//	public Set<Question> reachable(State s) {
//		Set<Question> reachable = new HashSet<Question>();
//		List<State> todo = new ArrayList<State>();
//		todo.add(s);
//		
//		while (!todo.isEmpty()) {
//			State cur = todo.remove(0);
//			for (Transition t: cur.getTransitions()) {
//				if (!eval(t.getAnswered())) {
//					continue;
//				}
//				reachable.add(t.getAnswered());
//				for (Goto g: t.getGotos()) {
//					if (!todo.contains(g.getTarget())) {
//						todo.add(g.getTarget());
//					}
//				}
//			}
//		}
//		return reachable;
//	}
	
	public void update(Map<JComponent, Question> fieldMap) {
		System.out.println("ENV = " + env);
		
		for (JComponent c: fieldMap.keySet()) {
			Question q = fieldMap.get(c);
			c.setEnabled(isEnabled(q));
		}
	}
	
	private boolean isEnabled(Question q) {
		return enabled.contains(q);
	}

//	public State findLastEdit(Question q) {
//		for (int i = trail.size() - 1; i >= 0; i--) {
//			State s = trail.elementAt(i);
//			if (s.getEnabled().contains(q)) {
//				return s;
//			}
//		}
//		return null;
//	}
	
	public JFrame makeFrame() {
		final Map<JComponent, Question> fieldMap = new HashMap<JComponent, Question>();
		JFrame frame = new JFrame("Quanda");
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		JPanel panel = (JPanel) frame.getContentPane();
		panel.setLayout(new MigLayout());
		for (final Question q: questionnaire.getQuestions()) {
			panel.add(new JLabel(q.getLabel()));
			JTextField f = new JTextField(20);
			panel.add(f, "wrap");
//			JButton b = new JButton("Revise");
//			b.addActionListener(new ActionListener() {
//				@Override
//				public void actionPerformed(ActionEvent e) {
//					State s = findLastEdit(q);
//					if (s != null) {
//						goTo(s);
//						update(fieldMap, s);
//					}
//				}
//			});
//			panel.add(b, "wrap");
			fieldMap.put(f, q);
		}
		
//		JButton back = new JButton("Back");
//		back.addActionListener(new ActionListener() {
//			@Override
//			public void actionPerformed(ActionEvent arg0) {
//				State s = goBack();
//				update(fieldMap, s);
//			}
//		});
//		panel.add(back);

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
		update(fieldMap);
		return frame;
	}
	
}
