package com.bm.bspmer.fcm;

import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;
import android.os.Build;
import android.util.Log;

import androidx.core.app.NotificationCompat;
import androidx.core.app.NotificationManagerCompat;

import com.bm.bspmer.R;
import com.bm.bspmer.ui.HomeActivity;
import com.bm.bspmer.ui.NotificationDetailActivity;
import com.bm.bspmer.utils.LayoutConfig;
import com.google.firebase.messaging.FirebaseMessagingService;
import com.google.firebase.messaging.RemoteMessage;

public class MerchantFCMService extends FirebaseMessagingService {

    private static final String TAG = "MerchantFCM";
    private static final String CHANNEL_ID = "merchant_notifications";

    @Override
    public void onCreate() {
        super.onCreate();
        createNotificationChannel();
    }

    @Override
    public void onNewToken(String token) {
        Log.d(TAG, "New FCM token: " + token);
        LayoutConfig.pushAppData("FCMTOKEN", token);
    }

    @Override
    public void onMessageReceived(RemoteMessage message) {
        Log.d(TAG, "Message received: " + message.getData());

        String title = message.getNotification() != null
                ? message.getNotification().getTitle()
                : "New Payment";
        String body = message.getNotification() != null
                ? message.getNotification().getBody()
                : "A QR payment has been received";

        String transactionId = message.getData().get("transactionId");
        String amount = message.getData().get("amount");
        String reference = message.getData().get("reference");
        String customerName = message.getData().get("customerName");

        showNotification(title, body, transactionId, amount, reference, customerName);
    }

    private void showNotification(String title, String body,
                                   String transactionId, String amount,
                                   String reference, String customerName) {

        Intent intent;
        String isLoggedIn = LayoutConfig.pullAppData("IS_LOGGED_IN");

        if ("true".equals(isLoggedIn)) {
            intent = new Intent(this, NotificationDetailActivity.class);
            intent.putExtra("transactionId", transactionId);
            intent.putExtra("amount", amount);
            intent.putExtra("reference", reference);
            intent.putExtra("customerName", customerName);
            intent.putExtra("from_notification", true);
        } else {
            intent = new Intent(this, HomeActivity.class);
        }
        intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP | Intent.FLAG_ACTIVITY_SINGLE_TOP);

        PendingIntent pendingIntent = PendingIntent.getActivity(
                this, 0, intent,
                PendingIntent.FLAG_UPDATE_CURRENT | PendingIntent.FLAG_IMMUTABLE);

        NotificationCompat.Builder builder = new NotificationCompat.Builder(this, CHANNEL_ID)
                .setSmallIcon(R.drawable.ic_launcher_foreground)
                .setContentTitle(title)
                .setContentText(body)
                .setPriority(NotificationCompat.PRIORITY_HIGH)
                .setAutoCancel(true)
                .setContentIntent(pendingIntent)
                .setVibrate(new long[]{0, 200, 100, 200});

        NotificationManagerCompat.from(this).notify((int) System.currentTimeMillis(), builder.build());
    }

    private void createNotificationChannel() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            NotificationChannel channel = new NotificationChannel(
                    CHANNEL_ID,
                    getString(R.string.channel_name),
                    NotificationManager.IMPORTANCE_HIGH
            );
            channel.setDescription(getString(R.string.channel_desc));
            NotificationManager manager = getSystemService(NotificationManager.class);
            if (manager != null) {
                manager.createNotificationChannel(channel);
            }
        }
    }
}
