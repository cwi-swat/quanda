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
import javax.swing.JPanel;
import javax.swing.JTextField;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Unmarshaller;

import org.mozilla.javascript.Context;
import org.mozilla.javascript.EcmaError;
import org.mozilla.javascript.Scriptable;

import net.miginfocom.swing.MigLayout;
import nl.cwi.swat.quanda.model.Question;
import nl.cwi.swat.quanda.model.Questionnaire;

public class Eval {
	private final Questionnaire questionnaire;
	private final JFrame frame; 

	private Env env;
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
		this.enabled = new ArrayList<Question>(questionnaire.getInitial());
		this.answered = new ArrayList<Question>();
		this.env = new Env();
		this.frame = makeFrame();
		frame.setVisible(true);
	}
	
	public void handle(Map<JComponent, Question> fieldMap, Question q, Object a) {
		env.put(q.getVariable(), a);
		answer(q);
		for (Question nextq: q.getNext()) {
			if (nextq.isEnabled(env)) {
				enable(nextq);
			}
		}
		update(fieldMap);
	}
	
	public boolean isEnabled(Env env) {
		Context ctx = Context.enter();
		try {
			Scriptable scope = ctx.initStandardObjects();
			env.define(scope);
			try {
				Object result = ctx.evaluateString(scope, getCondition(), getId(), 1, null);
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
	
	
	private void enable(Question q) {	
		this.enabled.add(q);
	}
	
	private void answer(Question q) {
		enabled.remove(q);
		answered.add(q);
	}

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

	private JFrame makeFrame() {
		Map<JComponent, Question> fieldMap = new HashMap<JComponent, Question>();
		JFrame frame = new JFrame("Quanda");
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		JPanel panel = (JPanel) frame.getContentPane();
		panel.setLayout(new MigLayout());
		for (Question q: questionnaire.getQuestions()) {
			fieldMap.put(q.render(panel), q);
		}
		panel.add(nextButton(fieldMap));
		frame.pack();
		update(fieldMap);
		return frame;
	}
	
	private JButton nextButton(final Map<JComponent, Question> fieldMap) {
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
		return button;
	}
	
}
