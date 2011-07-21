package nl.cwi.swat.quanda.ast;

import java.util.List;

import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlIDREF;
import javax.xml.bind.annotation.XmlList;
import javax.xml.bind.annotation.XmlType;

@XmlType
public class Output extends Stat {
	private Widget widget;
	private String expression;
	
	private List<Binder> dependencies;
	
	public Widget getWidget() {
		return widget;
	}
	public void setWidget(Widget widget) {
		this.widget = widget;
	}
	
	@XmlAttribute
	public String getExpression() {
		return expression;
	}
	public void setExpression(String expression) {
		this.expression = expression;
	}
	
	@XmlAttribute
	@XmlIDREF
	@XmlList
	public List<Binder> getDependencies() {
		return dependencies;
	}

	
}
