package nl.cwi.swat.quanda.ast;

import javax.xml.bind.annotation.XmlType;

@XmlType
public class Input extends Definer {

	private String label;
	private Widget widget;
	
	public String getLabel() {
		return label;
	}
	
	public void setLabel(String label) {
		this.label = label;
	}
	
	public Widget getWidget() {
		return widget;
	}
	
	public void setWidget(Widget widget) {
		this.widget = widget;
	}
	
}
