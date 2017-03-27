package panel2;

import javax.swing.JPanel;
import javax.swing.JLabel;
import javax.swing.JTextField;
import java.awt.GridLayout;
import java.util.regex.Pattern;

import javax.swing.SwingConstants;

public class InputComp extends JPanel {
	private JTextField tF;
	private JLabel lblTitle;

	/**
	 * Create the panel.
	 */
	public InputComp() {
		setLayout(new GridLayout(0, 2, 10, 0));

		lblTitle = new JLabel("New label");
		lblTitle.setHorizontalAlignment(SwingConstants.TRAILING);
		add(lblTitle);

		tF = new JTextField();
		add(tF);
		tF.setColumns(10);

	}

	public JTextField getTF() {
		return tF;
	}

	public void setTF(JTextField tF) {
		this.tF = tF;
	}

	public String getTFValue() {
		return tF.getText();
	}

	public void setTFValue(String str) {
		tF.setText(str);
	}

	public String getTitle() {
		return lblTitle.getText();
	}

	public void setTitle(String str) {
		lblTitle.setText(str);
	}
	
	public boolean isEmpty(){
		if (getTFValue().equals("")) {
			return true;
		}
		return false;
	}

	public void isEmptyCheck() throws Exception {
		if (getTFValue().equals("")) {
			throw new Exception("공백 존재");
		}
	}

	public void isValidCheck(String pattern, String msg) throws Exception {
		if (!Pattern.matches(pattern, getTFValue())) {
			throw new Exception(msg);
		}
	}
}
