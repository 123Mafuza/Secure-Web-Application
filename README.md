# 🔒 Secure Web Application

A secure web application built using **Python, Flask, SQLite, SQLAlchemy, and Bootstrap 5**. The application demonstrates secure authentication, user management, password hashing, session handling, and an admin dashboard with role-based access.

This project was developed as part of a **Cyber Security Internship**.

---

# 📌 Project Objective

To develop a secure web application that implements authentication, authorization, secure password storage, session management, and an admin dashboard following secure coding practices.

---

# 🚀 Features

## 👤 User Features

- User Registration
- User Login
- Secure Password Hashing
- Dashboard
- User Profile
- Change Password
- Delete Account
- Logout
- Show / Hide Password
- Flash Messages

---

## 👑 Admin Features

- Separate Admin Account
- Admin Dashboard
- View All Registered Users
- Total Registered Users Counter
- Delete Registered Users
- Admin Account Protection
- Restricted Admin Access

---

## 🔐 Security Features

- Password Hashing using Werkzeug
- Session-Based Authentication
- Protected Routes
- Duplicate Username Validation
- Duplicate Email Validation
- SQLAlchemy ORM (Helps Prevent SQL Injection)
- Flash Message Alerts
- Admin Authorization

---

# 🛠 Technologies Used

- Python 3
- Flask
- Flask-SQLAlchemy
- SQLite
- Bootstrap 5
- HTML5
- Jinja2
- Werkzeug

---

# 📂 Project Structure

```text
Secure-Web-App/
│
├── app.py
├── database.db
├── requirements.txt
├── README.md
├── .gitignore
│
└── templates/
    ├── register.html
    ├── login.html
    ├── dashboard.html
    ├── profile.html
    ├── admin.html
    ├── users.html
    ├── change_password.html
    └── delete_account.html
```

---

# ⚙ Installation

### Clone the repository

```bash
git clone https://github.com/YOUR_USERNAME/Secure-Web-App.git
```

### Go to project directory

```bash
cd Secure-Web-App
```

### Create Virtual Environment

```bash
python -m venv venv
```

### Activate Virtual Environment

**Windows**

```bash
venv\Scripts\activate
```

**Linux / macOS**

```bash
source venv/bin/activate
```

### Install Dependencies

```bash
pip install -r requirements.txt
```

### Run the Project

```bash
python app.py
```

Open your browser and visit:

```
http://127.0.0.1:5000
```

---

# 👑 Admin Login

Use your admin account to access the Admin Dashboard.

Example:

```
Email:
admin@gmail.com

Password:
admin@123
```

---

# 🔐 Security Implemented

- Password Hashing
- Session Authentication
- SQLAlchemy ORM
- Secure Logout
- Duplicate Account Prevention
- Route Protection
- Admin Authorization
- Password Verification Before Deleting Account
- Password Verification Before Changing Password

---

# 📈 Future Enhancements

- Email Verification
- Forgot Password
- Two-Factor Authentication (2FA)
- Role-Based Authentication
- User Profile Picture
- Password Strength Meter
- Activity Logs
- Login History
- Export Users to CSV

---

# 🎯 Learning Outcomes

Through this project, I learned:

- Flask Web Development
- Authentication & Authorization
- Password Hashing
- Session Management
- SQLAlchemy ORM
- Bootstrap 5
- CRUD Operations
- Admin Dashboard Development
- Secure Coding Practices
- Database Management

---

# 👨‍💻 Author

**Paramjit Basumatary**

Cyber Security Internship Project

---

# 📄 License

This project is developed for educational and internship purposes only.
