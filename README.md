# 🌟 Store Rating Application (Storeapp)

A full-stack web application built from scratch with **React.js, Node.js, Express.js, and MySQL**. The platform allows users to explore registered stores and submit 1–5 star ratings, allows store owners to track their store's performance and customer feedback, and provides system administrators with platform-wide analytics, store management, and user control.

---

## 📑 Table of Contents
1. [Tech Stack](#-tech-stack)
2. [Project Structure](#-project-structure)
3. [Key Features by Role](#-key-features-by-role)
4. [Form Validations](#-form-validations)
5. [Database Schema & Architecture](#-database-schema--architecture)
6. [Prerequisites](#-prerequisites)
7. [Installation & Setup Guide](#-installation--setup-guide)
8. [Database Initialization & Seeding](#-database-initialization--seeding)
9. [Running the Application](#-running-the-application)
10. [Pre-configured Test Accounts](#-pre-configured-test-accounts)
11. [REST API Documentation](#-rest-api-documentation)
12. [Security Best Practices](#-security-best-practices)

---

## 🚀 Tech Stack

### Frontend
- **React.js (v18)** – Functional components, Hooks (`useState`, `useEffect`, `useContext`)
- **Vite** – Fast build tool and development server
- **React Router DOM (v6)** – Declarative routing and role-based route protection
- **Axios** – HTTP client with request and response interceptors
- **Modern CSS** – Custom CSS variables, responsive grid/flexbox, custom animations

### Backend
- **Node.js & Express.js** – Modular RESTful API server
- **mysql2/promise** – High-performance MySQL connection pool
- **bcryptjs** – Secure password hashing (10 salt rounds)
- **jsonwebtoken (JWT)** – Stateless authentication and role-based authorization
- **dotenv** – Secure environment variable management
- **cors** – Cross-Origin Resource Sharing handling

### Database
- **MySQL (v8.0+)** – Relational database with Foreign Keys, Cascades, and SQL Aggregate Functions

---

## 📁 Project Structure

```
Storeapp/
├── backend/
│   ├── config/
│   │   └── db.js                        # MySQL connection pool (mysql2/promise)
│   ├── controllers/
│   │   ├── authController.js            # Login, Signup, Profile, Password update
│   │   ├── adminController.js           # Admin stats, Store & User management
│   │   ├── storeController.js           # Store listings & Store Owner data
│   │   └── ratingController.js          # Rating submissions & calculations
│   ├── middleware/
│   │   ├── authMiddleware.js            # JWT verification & role-based guards
│   │   └── validationMiddleware.js      # Backend input validation
│   ├── models/
│   │   ├── User.js                      # User database queries
│   │   ├── Store.js                     # Store database queries & rating averages
│   │   └── Rating.js                    # Rating upsert and retrieval
│   ├── routes/
│   │   ├── authRoutes.js                # /api/auth
│   │   ├── adminRoutes.js               # /api/admin
│   │   ├── storeRoutes.js               # /api/stores
│   │   └── ratingRoutes.js              # /api/ratings
│   ├── scripts/
│   │   ├── initDb.js                    # Database creation & table setup script
│   │   └── seedDb.js                    # Initial test users & sample stores seeder
│   ├── .env                             # Environment configuration
│   ├── .env.example                     # Environment template
│   ├── package.json                     # Backend dependencies & scripts
│   └── server.js                        # Express server entry point
├── frontend/
│   ├── public/
│   │   └── favicon.svg                  # Application favicon
│   ├── src/
│   │   ├── assets/                      # Static assets
│   │   ├── components/
│   │   │   ├── Navbar.jsx               # Top navigation & user status bar
│   │   │   ├── Sidebar.jsx              # Role-specific dashboard navigation
│   │   │   ├── StarRating.jsx           # Interactive & read-only star component
│   │   │   ├── Modal.jsx                # Reusable popup dialog
│   │   │   ├── ProtectedRoute.jsx       # Route guard for auth and roles
│   │   │   └── Alert.jsx                # Informational & error banners
│   │   ├── context/
│   │   │   └── AuthContext.jsx          # Global authentication state
│   │   ├── pages/
│   │   │   ├── Login.jsx                # Single unified login with demo buttons
│   │   │   ├── Signup.jsx               # Normal user registration
│   │   │   ├── AdminDashboard.jsx       # System Administrator dashboard
│   │   │   ├── UserDashboard.jsx        # Normal User store explorer & rating
│   │   │   ├── StoreOwnerDashboard.jsx  # Store Owner feedback & stats
│   │   │   ├── ChangePassword.jsx       # Password update for all users
│   │   │   └── NotFound.jsx             # 404 fallback page
│   │   ├── services/
│   │   │   ├── api.js                   # Axios instance with JWT interceptors
│   │   │   ├── authService.js           # Authentication API calls
│   │   │   ├── adminService.js          # Admin API calls
│   │   │   ├── storeService.js          # Store queries
│   │   │   ├── ratingService.js         # Rating submission API calls
│   │   │   └── validators.js            # Frontend input validation functions
│   │   ├── App.jsx                      # Routing definitions
│   │   ├── App.css                      # UI Component styles
│   │   ├── index.css                    # Base styling & CSS variables
│   │   └── main.jsx                     # React DOM entry point
│   ├── index.html                       # HTML template
│   ├── package.json                     # Frontend dependencies
│   └── vite.config.js                   # Vite configuration
├── schema.sql                           # Raw SQL schema definition
└── README.md                            # Complete documentation
```

---

## 👥 Key Features by Role

### 1. Unified Authentication
- **Single Login Page (`/login`)**: Automatically routes users to their corresponding dashboard based on their role (`admin`, `store_owner`, or `user`).
- **Demo Quick-Fill Buttons**: Allows instant 1-click test credentials filling on the login screen.
- **Change Password**: Any logged-in user can update their password from their dashboard.

### 2. System Administrator (`/admin`)
- **Live Statistics Overview**: Total users, total stores, and total submitted ratings.
- **Add Stores**: Register new stores with name, contact email, address, and optional assignment to a store owner.
- **Add Users**: Create accounts for any role (System Administrator, Normal User, or Store Owner).
- **View Stores Table**: Displays Store Name, Email, Address, and real-time Average Rating with column sorting.
- **View Users Table**: Displays Name, Email, Address, and Role with column sorting.
- **View User Details Modal**: Inspects full profile. **If the user is a Store Owner, displays their store's name, email, address, and overall average rating!**
- **Filtering & Search**: Filter stores or users by Name, Email, Address, or Role.

### 3. Normal User (`/dashboard`)
- **Store Directory**: Cards showing Store Name, Address, Contact Email, and Overall Average Rating.
- **Search Functionality**: Real-time search across store names and addresses.
- **Interactive 1–5 Star Rating**:
  - Displays user's submitted rating (e.g. `Rated 4/5 ★`).
  - Submit new ratings or modify existing ratings using an interactive modal.
  - SQL `ON DUPLICATE KEY UPDATE` guarantees one rating per user per store.

### 4. Store Owner (`/owner`)
- **Store Performance Card**: Displays the owner's assigned store name, address, overall average rating, and total review count.
- **Customer Ratings Table**: Lists all customers who rated the store, including their name, email, address, rating given, and date submitted.
- **Security Guard**: Strictly restricted to the owner's assigned store.

---

## 🔍 Form Validations

Both frontend forms and backend API middleware strictly enforce the following rules:

| Field | Rule | Error Message |
|---|---|---|
| **Name** | Minimum 20 characters, Maximum 60 characters | *Name must be between 20 and 60 characters in length.* |
| **Address** | Required, Maximum 400 characters | *Address is required and must not exceed 400 characters.* |
| **Password** | 8 to 16 characters, >= 1 uppercase letter (`[A-Z]`), >= 1 special character (`[!@#$%^&*...]`) | *Password must be 8-16 characters long, contain at least one uppercase letter and at least one special character.* |
| **Email** | Standard valid email format | *Please provide a valid email address.* |
| **Rating** | Integer between 1 and 5 | *Rating must be an integer between 1 and 5.* |

---

## 🗄 Database Schema & Architecture

The database `store_rating_db` uses InnoDB with UTF-8 character encoding:

### `users` Table
```sql
CREATE TABLE `users` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(60) NOT NULL,
  `email` VARCHAR(255) NOT NULL UNIQUE,
  `password` VARCHAR(255) NOT NULL,
  `address` VARCHAR(400) NOT NULL,
  `role` ENUM('admin', 'user', 'store_owner') NOT NULL DEFAULT 'user',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  INDEX `idx_users_role` (`role`),
  INDEX `idx_users_email` (`email`)
);
```

### `stores` Table
```sql
CREATE TABLE `stores` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(60) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `address` VARCHAR(400) NOT NULL,
  `owner_id` INT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT `fk_stores_owner` FOREIGN KEY (`owner_id`) 
    REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  INDEX `idx_stores_owner` (`owner_id`),
  INDEX `idx_stores_name` (`name`)
);
```

### `ratings` Table
```sql
CREATE TABLE `ratings` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `user_id` INT NOT NULL,
  `store_id` INT NOT NULL,
  `rating` TINYINT NOT NULL CHECK (`rating` >= 1 AND `rating` <= 5),
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT `fk_ratings_user` FOREIGN KEY (`user_id`) 
    REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_ratings_store` FOREIGN KEY (`store_id`) 
    REFERENCES `stores` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `unique_user_store_rating` UNIQUE (`user_id`, `store_id`),
  INDEX `idx_ratings_store` (`store_id`),
  INDEX `idx_ratings_user` (`user_id`)
);
```

---

## ⚙ Prerequisites

Before starting, ensure you have installed:
1. **Node.js** (v18.0 or higher) & **npm** (v9.0 or higher)
2. **MySQL Server** (v8.0 or higher) running locally on port `3306`

---

## 📦 Installation & Setup Guide

### 1. Configure Backend Environment
Open `backend/.env` (or copy from `backend/.env.example`):

```env
PORT=5000
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=your_actual_mysql_password
DB_NAME=store_rating_db
DB_PORT=3306
JWT_SECRET=storeapp_jwt_super_secret_key_2026_dev
JWT_EXPIRES_IN=24h
CLIENT_URL=http://localhost:5173
```

> **Note:** Replace `your_actual_mysql_password` with your local MySQL password.

### 2. Install Dependencies
Dependencies are already installed in this directory, but you can verify them at any time:
```bash
# In backend/
cd backend
npm install

# In frontend/
cd ../frontend
npm install
```

---

## 🗄 Database Initialization & Seeding

Run the built-in automated scripts from the `backend/` folder:

```bash
cd backend

# Step 1: Create the store_rating_db database and tables
npm run init-db

# Step 2: Seed initial test accounts, stores, and ratings
npm run seed-db
```

Alternatively, you can import the raw SQL schema using the MySQL command line:
```bash
mysql -u root -p < schema.sql
```

---

## 🏃 Running the Application

### Start the Backend Server
```bash
cd backend
npm run dev
# Server will run on: http://localhost:5000
# Health check: http://localhost:5000/api/health
```

### Start the Frontend Application
In a separate terminal:
```bash
cd frontend
npm run dev
# Frontend will run on: http://localhost:5173
```

Open your browser and navigate to:
**`http://localhost:5173`**

---

## 🔑 Pre-configured Test Accounts

All accounts below adhere strictly to the 20–60 character name rule and the 8–16 character password rule:

| Role | Email | Password | Display Name |
|---|---|---|---|
| **System Administrator** | `admin@storeapp.com` | `Admin@123` | `System Administrator User` |
| **Store Owner 1** | `owner1@storeapp.com` | `Owner@123` | `Prime Organic Foods Owner` |
| **Store Owner 2** | `owner2@storeapp.com` | `Owner@123` | `Tech Haven Electronics Guy` |
| **Normal User 1** | `user1@storeapp.com` | `User@1234` | `John Regular Customer Person` |
| **Normal User 2** | `user2@storeapp.com` | `User@1234` | `Emily Active Shopper Client` |
| **Normal User 3** | `user3@storeapp.com` | `User@1234` | `Robert Verified Reviewer Man` |

*(Tip: You can also click the quick-fill buttons on the login page to fill these credentials instantly!)*

---

## 🌐 REST API Documentation

### Authentication (`/api/auth`)
- `POST /api/auth/register` – Register a new normal user account
- `POST /api/auth/login` – Log in and receive JWT token
- `GET /api/auth/me` – Fetch current user profile (Bearer Token required)
- `POST /api/auth/change-password` – Change password for authenticated user

### Administrator (`/api/admin`) - *Admin role only*
- `GET /api/admin/stats` – Platform summary metrics (users, stores, ratings)
- `GET /api/admin/stores` – View stores with average ratings, filtering & sorting
- `POST /api/admin/stores` – Add a new store
- `GET /api/admin/users` – View users with filtering & sorting
- `POST /api/admin/users` – Create a new user (any role)
- `GET /api/admin/users/:id` – View user details (includes store info for store owners)
- `GET /api/admin/store-owners` – List store owners for assignment

### Stores (`/api/stores`)
- `GET /api/stores` – List stores with search & user's own rating (Authenticated)
- `GET /api/stores/owner/my-store` – View store owner's store and customer ratings (*Store Owner only*)

### Ratings (`/api/ratings`)
- `POST /api/ratings/:storeId` – Submit or modify rating (1–5) (*Normal User only*)

---

## 🔒 Security Best Practices

1. **Password Hashing**: Passwords are never stored in plain text. `bcryptjs` with 10 salt rounds hashes every password before database insertion.
2. **Stateless JWT**: JSON Web Tokens securely transmit user identity and roles without server-side session bloat.
3. **Role-Based Access Control (RBAC)**: Backend endpoints use `requireRole(['admin'])` and `requireRole(['store_owner'])` to prevent unauthorized API access.
4. **Data Isolation**: Store owners can only query and view data for their assigned store.
5. **SQL Injection Prevention**: Parameterized queries via `mysql2/promise` prevent SQL injection attacks.
6. **Environment Separation**: Sensitive credentials (`DB_PASSWORD`, `JWT_SECRET`) reside exclusively in `.env` and are never exposed to the client.
