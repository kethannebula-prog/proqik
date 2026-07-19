# ProQik — Creative Professionals Marketplace

A full-stack web platform connecting clients with creative professionals (photographers, videographers, album designers) with role-based dashboards, OTP email verification, Google OAuth, and an Oracle Cloud backend.

## Tech Stack

| Layer | Technology |
|---|---|
| Backend | Java 8, Jakarta Servlets 4.0.1 |
| Frontend | JSP, JSTL 1.2, HTML5, CSS3, JavaScript |
| Database | Oracle Autonomous DB (ATP) — cloud |
| Email | AWS SES SMTP |
| Auth | Google OAuth 2.0 + session-based |
| Build | Apache Maven 3 (WAR) |
| Server | Apache Tomcat 9.0 |

Also includes an **Android companion app** (BSP Merchant) and a **Figma plugin** for UI generation.

## Project Structure

```
proqik_lat/
├── src/main/java/com/proqik/
│   ├── controller/     # Jakarta Servlets (12)
│   ├── model/          # POJOs (User, Professional, Category, Service, Testimonial)
│   ├── repository/     # UserRepository (data access)
│   └── util/           # DBConnection, OtpService, RequestLogFilter
├── src/main/resources/ # db.properties, schema.sql
├── src/main/webapp/
│   ├── WEB-INF/views/  # JSP pages (auth, dashboard, home, includes, layouts)
│   └── resources/      # CSS, JS, images
└── pom.xml
```

## Setup

### Prerequisites
- JDK 1.8, Apache Tomcat 9.0, Maven 3.6+
- Oracle Cloud ADB instance (or configure for in-memory)

### Configuration
Set these environment variables (or edit `db.properties`):

| Variable | Description |
|---|---|
| `DB_HOST` | Oracle DB host |
| `DB_PORT` | Oracle DB port |
| `DB_SERVICE` | Oracle DB service name |
| `DB_USER` | Database user |
| `DB_PASSWORD` | Database password |
| `WALLET_PATH` | Path to Oracle wallet dir |
| `WALLET_PASSWORD` | Wallet keystore password |
| `SMTP_HOST` | SMTP server for email |
| `SMTP_USER` | SMTP username |
| `SMTP_PASSWORD` | SMTP password |
| `GOOGLE_CLIENT_ID` | Google OAuth client ID |
| `GOOGLE_CLIENT_SECRET` | Google OAuth client secret |

### Build & Deploy
```bash
mvn clean package
# Deploy proqik.war to Tomcat webapps/
```

## Features

- **Landing page**: hero slideshow, category grid, booking ticker, testimonials
- **Auth**: login/signup with Google OAuth, email OTP verification
- **Vendor dashboard**: profile setup, portfolio management, bookings
- **Admin dashboard**: KPI cards, vendor approvals, user management
- **Notifications**: Email alerts for application status changes

## Related Projects

- `proqik/` — Base version (in-memory storage, no DB)
- `proqik_l/` — Intermediate version (Oracle DB + OTP)
- `bsp-merchant/` — Android app for BSP Wallet Rewards
- `figma-plugin/` — Figma plugin for UI prototyping

## License

Copyright © 2025 ProQik. All rights reserved.
