package com.bm.bspmer.ui;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import androidx.recyclerview.widget.RecyclerView;

import com.bm.bspmer.R;
import com.bm.bspmer.beans.QrNotification;

import java.util.List;

public class NotificationAdapter extends RecyclerView.Adapter<NotificationAdapter.ViewHolder> {

    private final List<QrNotification> items;
    private final OnItemClickListener listener;

    public interface OnItemClickListener {
        void onClick(QrNotification item);
    }

    public NotificationAdapter(List<QrNotification> items, OnItemClickListener listener) {
        this.items = items;
        this.listener = listener;
    }

    @Override
    public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext())
                .inflate(R.layout.item_notification, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(ViewHolder holder, int position) {
        QrNotification item = items.get(position);
        holder.amountText.setText("FJD " + item.getAmount());
        holder.referenceText.setText(item.getReference());
        holder.customerText.setText(item.getCustomerName());
        holder.timestampText.setText(item.getTimestamp());
        holder.itemView.setOnClickListener(v -> listener.onClick(item));
    }

    @Override
    public int getItemCount() {
        return items.size();
    }

    static class ViewHolder extends RecyclerView.ViewHolder {
        TextView amountText, referenceText, customerText, timestampText;

        ViewHolder(View view) {
            super(view);
            amountText = view.findViewById(R.id.item_amount);
            referenceText = view.findViewById(R.id.item_reference);
            customerText = view.findViewById(R.id.item_customer);
            timestampText = view.findViewById(R.id.item_timestamp);
        }
    }
}
