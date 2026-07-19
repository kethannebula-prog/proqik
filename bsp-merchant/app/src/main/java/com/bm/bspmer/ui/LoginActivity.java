package com.bm.bspmer.ui;

import android.os.Bundle;
import android.text.InputType;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import com.bm.bspmer.R;
import com.bm.bspmer.custom.MyBaseActivity;
import com.bm.bspmer.session.SessionManager;
import com.bm.bspmer.utils.LayoutConfig;

public class LoginActivity extends MyBaseActivity {

    private EditText mpinInput;
    private Button loginButton;
    private SessionManager sessionManager;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);

        sessionManager = new SessionManager(this);

        TextView title = findViewById(R.id.login_title);
        mpinInput = findViewById(R.id.mpin_input);
        loginButton = findViewById(R.id.login_button);

        mpinInput.setInputType(InputType.TYPE_CLASS_NUMBER | InputType.TYPE_NUMBER_VARIATION_PASSWORD);
        mpinInput.setTransformationMethod(new android.text.method.PasswordTransformationMethod());

        loginButton.setOnClickListener(v -> attemptLogin());
    }

    private void attemptLogin() {
        String mpin = mpinInput.getText().toString().trim();

        if (mpin.isEmpty()) {
            Toast.makeText(this, "Please enter MPIN", Toast.LENGTH_SHORT).show();
            return;
        }

        if (mpin.length() != 4) {
            Toast.makeText(this, "MPIN must be 4 digits", Toast.LENGTH_SHORT).show();
            return;
        }

        // For MVP: accept any 4-digit MPIN
        performLogin(mpin);
    }

    private void performLogin(String mpin) {
        sessionManager.setLoggedIn(true);
        sessionManager.setUserId("MERCHANT001");
        sessionManager.setMerchantId("MCH001");
        sessionManager.setTerminalId("TRM001");
        sessionManager.setSessionId("SESS_" + System.currentTimeMillis());

        LayoutConfig.pushAppData("IS_LOGGED_IN", "true");
        LayoutConfig.pushAppData("USER_ID", "MERCHANT001");

        startActivity(HomeActivity.newIntent(this));
        finish();
    }
}
