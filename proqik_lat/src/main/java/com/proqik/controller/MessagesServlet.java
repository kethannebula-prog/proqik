package com.proqik.controller;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

public class MessagesServlet extends HttpServlet {

    public static class Message {
        private String id;
        private String fromId;
        private String fromName;
        private String toId;
        private String toName;
        private String content;
        private LocalDateTime timestamp;
        private boolean read;

        public Message(String id, String fromId, String fromName, String toId, String toName, String content) {
            this.id = id;
            this.fromId = fromId;
            this.fromName = fromName;
            this.toId = toId;
            this.toName = toName;
            this.content = content;
            this.timestamp = LocalDateTime.now();
            this.read = false;
        }

        public String getId() { return id; }
        public String getFromId() { return fromId; }
        public String getFromName() { return fromName; }
        public String getToId() { return toId; }
        public String getToName() { return toName; }
        public String getContent() { return content; }
        public LocalDateTime getTimestamp() { return timestamp; }
        public boolean isRead() { return read; }
        public void setRead(boolean read) { this.read = read; }
    }

    public static class Conversation {
        private String participantId;
        private String participantName;
        private String participantAvatar;
        private List<Message> messages;
        private Message lastMessage;

        public Conversation(String participantId, String participantName, String participantAvatar) {
            this.participantId = participantId;
            this.participantName = participantName;
            this.participantAvatar = participantAvatar;
            this.messages = new ArrayList<>();
        }

        public String getParticipantId() { return participantId; }
        public String getParticipantName() { return participantName; }
        public String getParticipantAvatar() { return participantAvatar; }
        public List<Message> getMessages() { return messages; }
        public Message getLastMessage() { return lastMessage; }
        public void setLastMessage(Message lastMessage) { this.lastMessage = lastMessage; }
        public void addMessage(Message m) { messages.add(m); setLastMessage(m); }
    }

    private static final List<Conversation> CONVERSATIONS = new ArrayList<>();

    static {
        Conversation c1 = new Conversation("1", "Ravi Kumar", "https://i.pravatar.cc/150?img=11");
        c1.addMessage(new Message("m1", "1", "Ravi Kumar", "me", "You", "Hi! I'm interested in your wedding photography services."));
        c1.addMessage(new Message("m2", "me", "You", "1", "Ravi Kumar", "Hello Ravi! Thanks for reaching out. What date are you looking at?"));
        c1.addMessage(new Message("m3", "1", "Ravi Kumar", "me", "You", "We're looking at April 28th, 2025. Is that available?"));
        CONVERSATIONS.add(c1);

        Conversation c2 = new Conversation("2", "Sky Vision India", "https://i.pravatar.cc/150?img=26");
        c2.addMessage(new Message("m4", "2", "Sky Vision India", "me", "You", "Thanks for your interest in our drone services!"));
        CONVERSATIONS.add(c2);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String vendorId = req.getParameter("vendor");
        
        if (vendorId != null && !vendorId.isEmpty()) {
            Conversation existing = CONVERSATIONS.stream()
                .filter(c -> c.getParticipantId().equals(vendorId))
                .findFirst()
                .orElse(null);
            
            if (existing == null) {
                String[] names = {"Ravi Kumar Photography", "Sky Vision India", "Kavya Studio"};
                String[] avatars = {"https://i.pravatar.cc/150?img=11", "https://i.pravatar.cc/150?img=26", "https://i.pravatar.cc/150?img=41"};
                int idx = Math.abs(vendorId.hashCode()) % names.length;
                existing = new Conversation(vendorId, names[idx], avatars[idx]);
                CONVERSATIONS.add(existing);
            }
            req.setAttribute("conversation", existing);
        }
        
        req.setAttribute("conversations", CONVERSATIONS);
        req.getRequestDispatcher("/WEB-INF/views/messages/index.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String toId = req.getParameter("toId");
        String message = req.getParameter("message");
        
        if (toId != null && message != null && !message.isEmpty()) {
            Conversation conv = CONVERSATIONS.stream()
                .filter(c -> c.getParticipantId().equals(toId))
                .findFirst()
                .orElse(null);
            
            if (conv != null) {
                Message msg = new Message(UUID.randomUUID().toString(), "me", "You", toId, conv.getParticipantName(), message);
                conv.addMessage(msg);
            }
        }
        
        res.sendRedirect(req.getContextPath() + "/messages?" + req.getQueryString());
    }
}