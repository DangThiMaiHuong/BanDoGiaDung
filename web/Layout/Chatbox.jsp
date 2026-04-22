<%-- 
    Document   : Chatbox
    Created on : Apr 18, 2026, 11:44:36 PM
    Author     : PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!-- NÚT CHAT -->
<div id="chat-button" onclick="toggleChat()">
    🤖
</div>

<!-- POPUP CHÀO -->
<div id="chat-welcome">
    Xin chào! Tôi là AI hỗ trợ 🤖<br>
    Bạn cần tìm gì?
</div>

<!-- CHATBOX -->
<div id="chatbox">
    <div id="chat-header">
        <span>🤖 Hỗ trợ</span>
        <span class="close" onclick="closeChatBox()">&times;</span>
    </div>

    <div id="messages">
        <div class="msg ai">Xin chào! Tôi có thể giúp gì cho bạn?</div>
    </div>

    <div id="chat-input">
        <input type="text" id="input" placeholder="Nhập tin nhắn..."
               onkeypress="if (event.key === 'Enter') {
                           sendMessage();
                           return false;
                       }"/>
        <button onclick="sendMessage()">➤</button>
    </div>
</div>

<script>
    function toggleChat() {
        let box = document.getElementById("chatbox");
        let welcome = document.getElementById("chat-welcome");

        if (box.style.display === "none" || box.style.display === "") {
            box.style.display = "flex";
            welcome.style.display = "none";
        } else {
            box.style.display = "none";
        }
    }

    function addMessage(text, type) {
        let messages = document.getElementById("messages");

        let div = document.createElement("div");
        div.className = "msg " + type;
        div.innerHTML = text;

        messages.appendChild(div);
        messages.scrollTop = messages.scrollHeight;
        // ⭐ lưu lịch sử
        saveChat(type, text);
    }

    function sendMessage() {
        let input = document.getElementById("input");
        let msg = input.value.trim();

        if (msg === "")
            return;

        let messages = document.getElementById("messages");

        // HIỂN THỊ USER
        addMessage(msg, "user");

        // loading
        let loading = document.createElement("div");
        loading.className = "msg ai";
        loading.innerText = "Đang trả lời...";
        messages.appendChild(loading);

        messages.scrollTop = messages.scrollHeight;

        fetch("ChatBoxAI", {
            method: "POST",
            headers: {
                "Content-Type": "application/x-www-form-urlencoded"
            },
            body: "message=" + encodeURIComponent(msg)
        })
                .then(res => res.text())
                .then(data => {
                    loading.remove();             // xóa loading
                    addMessage(data, "ai");       // HIỂN THỊ AI
                })
                .catch(err => {
                    loading.remove();
                    addMessage("Lỗi kết nối!", "ai");
                });

        input.value = "";
    }
    function saveChat(role, text) {

        let key = getUserKey();
        if (!key)
            return;

        let chats = JSON.parse(localStorage.getItem(key)) || [];

        chats.push({role, text});

        localStorage.setItem(key, JSON.stringify(chats));
    }
    function getUserKey() {
        let id = localStorage.getItem("userId");

        if (!id || id === "null" || id === "") {
            return null;
        }

        return "chatHistory_" + id;
    }
    document.addEventListener("DOMContentLoaded", function () {

        let key = getUserKey();
        if (!key)
            return;
        let chats = JSON.parse(localStorage.getItem(key)) || [];

        let messages = document.getElementById("messages");

        chats.forEach(c => {
            let div = document.createElement("div");
            div.className = "msg " + c.role;
            div.innerHTML = c.text;
            messages.appendChild(div);
        });

        messages.scrollTop = messages.scrollHeight;

    });
    window.addEventListener("load", function () {
        let user = "${sessionScope.user != null ? sessionScope.user.username : ''}";

        if (user && user !== '') {
            localStorage.setItem("userId", user);
        } else {
            // QUAN TRỌNG: logout thì xoá hết chat
            localStorage.removeItem("userId");

            // xoá tất cả chat history (hoặc theo user cũ)
            for (let key in localStorage) {
                if (key.startsWith("chatHistory_")) {
                    localStorage.removeItem(key);
                }
            }
        }
    });
    function clearChat() {
        for (let key in localStorage) {
            if (key.startsWith("chatHistory_")) {
                localStorage.removeItem(key);
            }
        }
        localStorage.removeItem("userId");
    }
    function closeChatBox() {
        document.getElementById("chatbox").style.display = "none";
    }
</script>
<script>
    let user = "${sessionScope.user != null ? sessionScope.user.username : ''}";

    if (user && user !== '') {
        localStorage.setItem("userId", user);
    } else {
        localStorage.removeItem("userId");
    }
</script>
