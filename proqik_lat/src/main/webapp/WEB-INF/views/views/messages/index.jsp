<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.proqik.controller.MessagesServlet.*" %>

<%
List<Conversation> conversations = (List<Conversation>) request.getAttribute("conversations");
Conversation conversation = (Conversation) request.getAttribute("conversation");
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Messages | ProQik</title>
<link href="https://fonts.googleapis.com/css2?family=Syne:wght@600;700;800&family=Plus+Jakarta+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet"/>
<style>
:root{--navy:#122f66;--gray-50:#f6f8fc;--gray-100:#eef1f8;--gray-200:#dce2f0;--gray-400:#8b96b0;--gray-600:#4a5578;--gray-800:#1a2140;--gold:#c9a84c;--font:'Plus Jakarta Sans',system-ui,sans-serif;--disp:'Syne',system-ui,sans-serif}
*,*::before,*::after{box-sizing:border-box;margin:0;padding:0}
body{font-family:var(--font);background:var(--gray-50);color:var(--gray-800);height:100vh;display:flex;flex-direction:column}

.msg-header{background:var(--navy);padding:16px 24px;display:flex;align-items:center;justify-content:space-between}
.msg-logo{display:flex;align-items:center;gap:10px}
.msg-logo img{height:28px}
.msg-logo span{font-family:var(--disp);font-size:18px;font-weight:800;color:#fff}
.msg-back{color:#fff;font-size:14px;cursor:pointer;display:none}
.msg-back:hover{text-decoration:underline}

.msg-container{display:flex;flex:1;overflow:hidden}

.msg-sidebar{width:320px;background:#fff;border-right:1px solid var(--gray-200);overflow-y:auto}
.msg-sidebar-header{padding:16px;border-bottom:1px solid var(--gray-200)}
.msg-sidebar-title{font-family:var(--disp);font-size:16px;font-weight:700}
.msg-search{width:100%;padding:10px 14px;border:1px solid var(--gray-200);border-radius:8px;font-size:13px;margin-top:12px;font-family:var(--font)}
.msg-conv{padding:16px;border-bottom:1px solid var(--gray-100);cursor:pointer;transition:background .2s;display:flex;gap:12px}
.msg-conv:hover{background:var(--gray-50)}
.msg-conv.active{background:var(--gray-50);border-left:3px solid var(--navy)}
.msg-conv-img{width:44px;height:44px;border-radius:50%;object-fit:cover;flex-shrink:0}
.msg-conv-info{flex:1;min-width:0}
.msg-conv-name{font-weight:600;font-size:14px;margin-bottom:2px}
.msg-conv-msg{font-size:12px;color:var(--gray-600);white-space:nowrap;overflow:hidden;text-overflow:ellipsis}
.msg-conv-time{font-size:11px;color:var(--gray-400);margin-top:2px}

.msg-main{flex:1;display:flex;flex-direction:column}
.msg-main-empty{flex:1;display:flex;align-items:center;justify-content:center;color:var(--gray-400)}
.msg-chat{display:none;flex-direction:column;flex:1}
.msg-chat.active{display:flex}

.msg-chat-header{padding:16px 24px;background:#fff;border-bottom:1px solid var(--gray-200);display:flex;align-items:center;gap:12px}
.msg-chat-header img{width:40px;height:40px;border-radius:50%;object-fit:cover}
.msg-chat-name{font-weight:600;font-size:15px}
.msg-chat-cat{font-size:12px;color:var(--gray-600)}

.msg-messages{flex:1;padding:24px;overflow-y:auto;display:flex;flex-direction:column;gap:16px}
.msg-bubble{max-width:70%;padding:12px 16px;border-radius:16px;font-size:14px;line-height:1.5}
.msg-bubble.sent{background:var(--navy);color:#fff;align-self:flex-end;border-bottom-right-radius:4px}
.msg-bubble.received{background:#fff;border:1px solid var(--gray-200);align-self:flex-start;border-bottom-left-radius:4px}
.msg-bubble-time{font-size:10px;color:var(--gray-400);margin-top:4px;text-align:right}

.msg-input{padding:16px 24px;background:#fff;border-top:1px solid var(--gray-200);display:flex;gap:12px}
.msg-input input{flex:1;padding:12px 16px;border:1px solid var(--gray-200);border-radius:24px;font-size:14px;font-family:var(--font);outline:none}
.msg-input input:focus{border-color:var(--navy)}
.msg-input button{padding:12px 24px;background:var(--navy);color:#fff;border:none;border-radius:24px;font-size:14px;font-weight:600;cursor:pointer;transition:background .2s}
.msg-input button:hover{background:#1e55b0}

@media(max-width:768px){.msg-sidebar{position:absolute;left:0;top:60px;bottom:0;z-index:10;display:none}.msg-sidebar.show{display:block}.msg-back{display:block}}