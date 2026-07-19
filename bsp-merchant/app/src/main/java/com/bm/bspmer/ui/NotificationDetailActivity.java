package com.bm.bspmer.ui;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.TextView;

import com.bm.bspmer.R;
import com.bm.bspmer.custom.MyBaseActivity;

public class NotificationDetailActivity extends MyBaseActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_notification_detail);

        TextView amountText = findViewById(R.id.detail_amount);
        TextView referenceText = findViewById(R.id.detail_reference);
        TextView customerText = findViewById(R.id.detail_customer);
        TextView accountText = findViewById(R.id.detail_customer_account);
        TextView timeText = findViewById(R.id.detail_timestamp);
        TextView statusText = findViewById(R.id.detail_status);
        View backButton = findViewById(R.id.back_button);

        Intent intent = getIntent();
        String amount = intent.getStringExtra("amount");
        String reference = intent.getStringExtra("reference");
        String customerName = intent.getStringExtra("customerName");
        String customerAccount = intent.getStringExtra("customerAccount");
        String timestamp = intent.getStringExtra("timestamp");
        String status = intent.getStringExtra("status");

        if (amount != null) amountText.setText("FJD " + amount);
        if (reference != null) referenceText.setText(reference);
        if (customerName != null) customerText.setText(customerName);
        if (customerAccount != null) accountText.setText(customerAccount);
        if (timestamp != null) timeText.setText(timestamp);
        if (status != null) {
            statusText.setText(status);
            statusText.setTextColor(getColor(
                    "Completed".equals(status) ? R.color.success : R.color.warning));
        }

        backButton.setOnClickListener(v -> finish());
    }
}
