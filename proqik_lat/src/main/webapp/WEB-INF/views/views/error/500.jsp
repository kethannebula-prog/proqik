<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>500 - Server Error | ProQik</title>
    <link href="https://fonts.googleapis.com/css2?family=Syne:wght@400;500;600;700;800&family=Manrope:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body {
            font-family: 'Manrope', sans-serif;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(135deg, #031F16 0%, #052e1d 100%);
            color: white;
            text-align: center;
            padding: 20px;
        }
        .error-container {
            max-width: 500px;
        }
        .error-code {
            font-family: 'Syne', sans-serif;
            font-size: 120px;
            font-weight: 800;
            color: rgba(244, 63, 94, 0.2);
            line-height: 1;
            margin-bottom: 20px;
        }
        h1 {
            font-family: 'Syne', sans-serif;
            font-size: 32px;
            margin-bottom: 16px;
        }
        p {
            color: rgba(255, 255, 255, 0.7);
            font-size: 16px;
            margin-bottom: 32px;
        }
        a {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            background: #1b4a97;
            color: white;
            padding: 14px 28px;
            border-radius: 12px;
            font-weight: 700;
            text-decoration: none;
            transition: all 0.25s;
        }
        a:hover {
            background: #00A87E;
            transform: translateY(-2px);
        }
    </style>
</head>
<body>
    <div class="error-container">
        <div class="error-code">500</div>
        <h1>Something Went Wrong</h1>
        <p>We're experiencing technical difficulties. Our team has been notified. Please try again in a few moments.</p>
        <a href="${pageContext.request.contextPath}/">
            <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"/>
                <polyline points="9 22 9 12 15 12 15 22"/>
            </svg>
            Back to Home
        </a>
    </div>
</body>
</html>
