from flask import Flask, render_template, request, redirect, url_for, session, flash
from flask_sqlalchemy import SQLAlchemy
from werkzeug.security import generate_password_hash, check_password_hash

app = Flask(__name__)

app.config['SECRET_KEY'] = 'your_secret_key'
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///database.db'

db = SQLAlchemy(app)

# Admin Email
ADMIN_EMAIL = "admin@gmail.com"


# ==========================
# Database Model
# ==========================
class User(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(100), unique=True, nullable=False)
    email = db.Column(db.String(100), unique=True, nullable=False)
    password = db.Column(db.String(200), nullable=False)


# ==========================
# Home Page
# ==========================
@app.route("/")
def home():
    return redirect(url_for("register"))


# ==========================
# Register
# ==========================
@app.route("/register", methods=["GET", "POST"])
def register():

    if request.method == "POST":

        username = request.form["username"]
        email = request.form["email"]
        password = generate_password_hash(request.form["password"])

        # Check if email already exists
        existing_user = User.query.filter_by(email=email).first()

        if existing_user:
            flash("Email already registered!", "danger")
            return redirect(url_for("register"))

        # Check if username already exists
        existing_username = User.query.filter_by(username=username).first()

        if existing_username:
            flash("Username already taken!", "danger")
            return redirect(url_for("register"))

        # Create new user
        new_user = User(
            username=username,
            email=email,
            password=password
        )

        db.session.add(new_user)
        db.session.commit()

        flash("Registration Successful! Please login.", "success")
        return redirect(url_for("login"))

    return render_template("register.html")


# ==========================
# Login
# ==========================
@app.route("/login", methods=["GET", "POST"])
def login():

    if request.method == "POST":

        email = request.form["email"]
        password = request.form["password"]

        user = User.query.filter_by(email=email).first()

        if user and check_password_hash(user.password, password):

            session["user"] = user.username
            session["email"] = user.email

            return redirect(url_for("dashboard"))

        flash("Invalid Email or Password!", "danger")
        return redirect(url_for("login"))

    return render_template("login.html")


# ==========================
# Dashboard
# ==========================
@app.route("/dashboard")
def dashboard():

    if "user" not in session:
        flash("Please login first.", "warning")
        return redirect(url_for("login"))

    return render_template("dashboard.html")

# ==========================
# Admin Dashboard
# ==========================
@app.route("/admin")
def admin():

    if "user" not in session:
        flash("Please login first.", "warning")
        return redirect(url_for("login"))

    if session["email"] != ADMIN_EMAIL:
        flash("Access Denied! Admins only.", "danger")
        return redirect(url_for("dashboard"))

    users = User.query.all()
    total_users = User.query.count()

    return render_template(
        "admin.html",
        users=users,
        total_users=total_users
    )

# ==========================
# Delete User (Admin)
# ==========================
@app.route("/delete_user/<int:id>")
def delete_user(id):

    if "user" not in session:
        flash("Please login first.", "warning")
        return redirect(url_for("login"))

    if session["email"] != ADMIN_EMAIL:
        flash("Access Denied!", "danger")
        return redirect(url_for("dashboard"))

    user = User.query.get_or_404(id)

    if user.email == ADMIN_EMAIL:
        flash("Admin account cannot be deleted!", "danger")
        return redirect(url_for("admin"))
    db.session.delete(user)
    db.session.commit()

    flash("User deleted successfully.", "success")

    return redirect(url_for("admin"))

# ==========================
# Profile
# ==========================
@app.route("/profile")
def profile():

    if "user" not in session:
        flash("Please login first.", "warning")
        return redirect(url_for("login"))

    user = User.query.filter_by(username=session["user"]).first()

    return render_template("profile.html", user=user)

# ==========================
# User Statistics
# ==========================
@app.route("/users")
def users():

    if "user" not in session:
        flash("Please login first.", "warning")
        return redirect(url_for("login"))

    all_users = User.query.all()
    total_users = User.query.count()

    return render_template(
        "users.html",
        users=all_users,
        total_users=total_users
    )

# ==========================
# Change Password
# ==========================
@app.route("/change_password", methods=["GET", "POST"])
def change_password():

    if "user" not in session:
        flash("Please login first.", "warning")
        return redirect(url_for("login"))

    user = User.query.filter_by(username=session["user"]).first()

    if request.method == "POST":

        current_password = request.form["current_password"]
        new_password = request.form["new_password"]

        # Verify current password
        if not check_password_hash(user.password, current_password):
            flash("Current password is incorrect!", "danger")
            return redirect(url_for("change_password"))

        # Hash and save the new password
        user.password = generate_password_hash(new_password)
        db.session.commit()

        flash("Password changed successfully!", "success")
        return redirect(url_for("dashboard"))

    return render_template("change_password.html")

# ==========================
# Delete Account
# ==========================
@app.route("/delete_account", methods=["GET", "POST"])
def delete_account():

    if "user" not in session:
        flash("Please login first.", "warning")
        return redirect(url_for("login"))

    user = User.query.filter_by(username=session["user"]).first()

    if request.method == "POST":

        password = request.form["password"]

        if not check_password_hash(user.password, password):
            flash("Incorrect password!", "danger")
            return redirect(url_for("delete_account"))

        db.session.delete(user)
        db.session.commit()

        session.clear()

        flash("Your account has been deleted successfully.", "success")
        return redirect(url_for("register"))

    return render_template("delete_account.html")

# ==========================
# Logout
# ==========================
@app.route("/logout")
def logout():

    session.clear()

    return redirect(url_for("login"))


# ==========================
# Run Application
# ==========================
if __name__ == "__main__":

    with app.app_context():
        db.create_all()

    app.run(debug=True)
