package panel2;

import javax.swing.JPanel;
import javax.swing.JLabel;
import javax.swing.JTextField;
import java.awt.GridLayout;
import java.util.regex.Pattern;

import javax.swing.SwingConstants;
import java.awt.GridBagLayout;
import java.awt.GridBagConstraints;
import java.awt.Insets;

public class bookCodePanel extends JPanel {
	private JTextField tfBCode;
	private JTextField tfBSubCode;

	/**
	 * Create the panel.
	 */
	public bookCodePanel() {
		setLayout(new GridLayout(0, 2, 10, 0));
		
		JLabel lblNewLabel = new JLabel("도서코드");
		lblNewLabel.setHorizontalAlignment(SwingConstants.TRAILING);
		add(lblNewLabel);
		
		JPanel panel = new JPanel();
		add(panel);
		GridBagLayout gbl_panel = new GridBagLayout();
		gbl_panel.columnWidths = new int[] {150, 70, 0};
		gbl_panel.rowHeights = new int[]{300, 0};
		gbl_panel.columnWeights = new double[]{0.0, 0.0, Double.MIN_VALUE};
		gbl_panel.rowWeights = new double[]{0.0, Double.MIN_VALUE};
		panel.setLayout(gbl_panel);
		
		tfBCode = new JTextField();
		GridBagConstraints gbc_tfBCode = new GridBagConstraints();
		gbc_tfBCode.fill = GridBagConstraints.BOTH;
		gbc_tfBCode.insets = new Insets(0, 0, 0, 5);
		gbc_tfBCode.gridx = 0;
		gbc_tfBCode.gridy = 0;
		panel.add(tfBCode, gbc_tfBCode);
		tfBCode.setColumns(10);
		
		tfBSubCode = new JTextField();
		GridBagConstraints gbc_tfBSubCode = new GridBagConstraints();
		gbc_tfBSubCode.fill = GridBagConstraints.BOTH;
		gbc_tfBSubCode.gridx = 1;
		gbc_tfBSubCode.gridy = 0;
		panel.add(tfBSubCode, gbc_tfBSubCode);
		tfBSubCode.setColumns(2);

	}

	public String getTfBCode() {
		return tfBCode.getText();
	}

	public void setTfBCode(String bCode) {
		tfBCode.setText(bCode);
	}
	public String getTfBSubCode() {
		return tfBSubCode.getText();
	}

	public void setTfBSubCode(int bSubCode) {
		tfBSubCode.setText(bSubCode+"");
	}

	
	public boolean isEmpty(){
		if (getTfBCode().equals("") || getTfBSubCode().equals("")) {
			return true;
		}
		return false;
	}

	public void isEmptyCheck() throws Exception {
		if (getTfBCode().equals("") || getTfBSubCode().equals("")) {
			throw new Exception("공백 존재");
		}
	}

	public void isValidCheck() throws Exception {
		if (!Pattern.matches("[A-Z]{1}[0-9]{3}", getTfBCode())) {
			throw new Exception("도서코드 형식 오류");
		}
		if (!Pattern.matches("[0-9]{2}", getTfBSubCode())) {
			throw new Exception("도서중복코드 형식 오류");
		}
		
	}
	
	

}
