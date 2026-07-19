package com.bm.bspmer.ui;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.TextView;

import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import com.bm.bspmer.R;
import com.bm.bspmer.beans.QrNotification;
import com.bm.bspmer.custom.MyBaseActivity;
import com.bm.bspmer.session.SessionManager;
import com.bm.bspmer.utils.LayoutConfig;

import java.util.ArrayList;
import java.util.List;

public class HomeActivity extends MyBaseActivity {

    private RecyclerView notificationsList;
    private TextView emptyView;
    private NotificationAdapter adapter;
    private SessionManager sessionManager;
    private List<QrNotification> notifications;

    public static Intent newIntent(Context context) {
        return new Intent(context, HomeActivity.class);
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_home);

        sessionManager = new SessionManager(this);
        notifications = new ArrayList<>();

        notificationsList = findViewById(R.id.notifications_list);
        emptyView = findViewById(R.id.empty_view);
        TextView logoutBtn = findViewById(R.id.logout_button);

        adapter = new NotificationAdapter(notifications, this::onNotificationClicked);
        notificationsList.setLayoutManager(new LinearLayoutManager(this));
        notificationsList.setAdapter(adapter);

        logoutBtn.setOnClickListener(v -> logout());

        // Check if opened from notification
        handleNotificationIntent(getIntent());
    }

    @Override
    protected void onNewIntent(Intent intent) {
        super.onNewIntent(intent);
        handleNotificationIntent(intent);
    }

    private void handleNotificationIntent(Intent intent) {
        if (intent != null && intent.getBooleanExtra("from_notification", false)) {
            String transactionId = intent.getStringExtra("transactionId");
            String amount = intent.getStringExtra("amount");
            String reference = intent.getStringExtra("reference");
            String customerName = intent.getStringExtra("customerName");

            Intent detailIntent = new Intent(this, NotificationDetailActivity.class);
            detailIntent.putExtra("transactionId", transactionId);
            detailIntent.putExtra("amount", amount);
            detailIntent.putExtra("reference", reference);
            detailIntent.putExtra("customerName", customerName);
            startActivity(detailIntent);
        }
    }

    private void onNotificationClicked(QrNotification notification) {
        Intent intent = new Intent(this, NotificationDetailActivity.class);
        intent.putExtra("transactionId", notification.getTransactionId());
        intent.putExtra("amount", notification.getAmount());
        intent.putExtra("reference", notification.getReference());
        intent.putExtra("customerName", notification.getCustomerName());
        intent.putExtra("customerAccount", notification.getCustomerAccount());
        intent.putExtra("timestamp", notification.getTimestamp());
        intent.putExtra("status", notification.getStatus());
        startActivity(intent);
    }

    private void logout() {
        sessionManager.clearSession();
        LayoutConfig.pushAppData("IS_LOGGED_IN", "false");
        Intent intent = new Intent(this, LoginActivity.class);
        intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP | Intent.FLAG_ACTIVITY_NEW_TASK);
        startActivity(intent);
        finishAffinity();
    }

    public void addNotification(QrNotification notification) {
        notifications.add(0, notification);
        adapter.notifyItemInserted(0);
        updateEmptyState();
    }

    private void updateEmptyState() {
        boolean empty = notifications.isEmpty();
        emptyView.setVisibility(empty ? View.VISIBLE : View.GONE);
        notificationsList.setVisibility(empty ? View.GONE : View.VISIBLE);
    }
}
