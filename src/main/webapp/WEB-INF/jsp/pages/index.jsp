<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>ELIS | Login</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Favicon -->
    <link rel="shortcut icon" href="favicon-16x16.png">

    <!-- Bootstrap -->
    <link rel="stylesheet" href="assets/login/css/bootstrap.min.css">

    <!-- Font Awesome -->
    <link rel="stylesheet" href="assets/login/css/fontawesome-all.min.css">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@500;600;700&family=Inter:wght@400;500&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Inter', sans-serif;
            background: #f4f6f9;
            min-height: 100vh;
        }

        .login-wrapper {
            display: flex;
            min-height: 100vh;
        }

        /* LEFT PANEL */
        .login-hero {
            flex: 1;
            background: linear-gradient(
                    rgba(0, 64, 43, 0.75),
                    rgba(0, 64, 43, 0.75)
                ),
                url("assets/login/img/land-bg.jpg") center/cover no-repeat;
            color: #fff;
            padding: 4rem;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .login-hero h1 {
            font-family: 'Poppins', sans-serif;
            font-size: 2.4rem;
            font-weight: 700;
        }

        .login-hero span {
            color: #4ade80;
        }

        .login-hero p {
            max-width: 520px;
            font-size: 1.05rem;
            margin-top: 1rem;
        }

        /* RIGHT PANEL */
        .login-form-wrapper {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            background: #ffffff;
        }

        .login-card {
            width: 100%;
            max-width: 420px;
            padding: 2.8rem;
            border-radius: 14px;
            box-shadow: 0 20px 45px rgba(0,0,0,0.08);
        }

        .login-card h2 {
            font-family: 'Poppins', sans-serif;
            font-weight: 600;
            margin-bottom: .5rem;
        }

        .login-card .text-muted {
            margin-bottom: 1.8rem;
        }

        .form-control {
            height: 48px;
            border-radius: 10px;
            font-size: 0.95rem;
        }

        .btn-login {
            background: #065f46;
            color: #fff;
            height: 48px;
            border-radius: 10px;
            font-weight: 500;
            width: 100%;
            transition: all .3s ease;
        }

        .btn-login:hover {
            background: #047857;
        }

        .forgot-link {
            font-size: 0.9rem;
        }

        footer {
            margin-top: 2rem;
            text-align: center;
            font-size: 0.85rem;
            color: #6b7280;
        }

        @media (max-width: 991px) {
            .login-hero {
                display: none;
            }
        }
    </style>
</head>

<body>

<div class="login-wrapper">

    <!-- LEFT: BRANDING -->
    <div class="login-hero">
        <h1><span>LANDS</span> COMMISSION</h1>
        <p class="mt-3">
            Welcome to the <strong>Enterprise Land Information System (ELIS)</strong>.
            Securely manage land records, workflows, and spatial data.
        </p>
        <p class="mt-4 text-warning">
            <strong>Notice:</strong> Never share your password with anyone.
        </p>
        <footer>
            &copy; Lands Commission <script>document.write(new Date().getFullYear())</script>
        </footer>
    </div>

    <!-- RIGHT: LOGIN FORM -->
    <div class="login-form-wrapper">
        <div class="login-card">

            <h2>Sign In</h2>
            <p class="text-muted">Enter your official credentials to continue.</p>

            ${login == 'failed' ? `
            <div class="alert alert-danger">
                Authentication Failed! Please check your username or password.
            </div>` : ''}

            ${login == 'failed_session' ? `
            <div class="alert alert-danger">
                Session expired. Please log in again.
            </div>` : ''}

            ${password_changed == 'passed' ? `
            <div class="alert alert-success">
                Password reset successful. Please log in.
            </div>` : ''}

            <form method="POST" action="two_factor_verification">
                <div class="mb-3">
                    <input type="email" name="username" class="form-control"
                           placeholder="Official email address" required>
                </div>

                <div class="mb-3">
                    <input type="password" name="password" class="form-control"
                           placeholder="Password" required>
                </div>

                <div class="mb-3 text-end">
                    <a href="forgot_password" class="forgot-link">Forgot password?</a>
                </div>

                <button type="submit" class="btn btn-login">Log In</button>
            </form>

        </div>
    </div>

</div>

<script src="assets/login/js/jquery-3.5.0.min.js"></script>
<script src="assets/login/js/bootstrap.min.js"></script>
<script>
    $(function () {
        setTimeout(() => $('.alert').fadeOut(800), 8000);
    });
</script>

</body>
</html>